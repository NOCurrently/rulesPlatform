package com.xc.datasouce.service;

import com.google.common.collect.MapDifference;
import com.google.common.collect.Maps;
import com.xc.mapper.DataSourceMapper;
import com.xc.po.AggregatDataSource;
import com.xc.po.DataSource;
import com.xc.until.CommonUtils;
import com.xc.until.JsonUtil;
import com.xc.vo.ProcessSegment;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.concurrent.*;
import java.util.stream.Collectors;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Slf4j
@Service
public class AggregatDataSourceService {
    private static final ThreadPoolExecutor poolExecutor = new ThreadPoolExecutor(20, 100, 5, TimeUnit.MINUTES, new ArrayBlockingQueue<>(1));

    @Autowired
    private DataSourceService dataSourceService;
    @Autowired
    private DataSourceMapper dataSourceMapper;

    public void execute(List<ProcessSegment> processSegments, Map<String, Object> param, Map<String, Object> resultMap) throws ExecutionException, InterruptedException {
        Set<Integer> ids = processSegments.stream().map(ProcessSegment::getId).collect(Collectors.toSet());
        List<DataSource> dataSources = dataSourceMapper.selectByIds(ids);
        Map<Integer, DataSource> sourceMap = dataSources.stream().collect(Collectors.toMap(DataSource::getId, a -> a, (k1, k2) -> k1));

        List<Future<Boolean>> futures = new ArrayList<>();
        for (ProcessSegment processSegment : processSegments) {
            DataSource dataSource = sourceMap.get(processSegment.getId());
            if (dataSource == null) {
                throw new RuntimeException("dataSource 不存在 id=" + processSegment.getId());
            }
            Future<Boolean> submit = poolExecutor.submit(new Task(dataSource, param, resultMap));
            futures.add(submit);
        }
        for (Future<Boolean> future : futures) {
            future.get();
        }
        List<ProcessSegment> segments = processSegments.stream().flatMap(a ->
                a.getSub() == null ? new ArrayList<ProcessSegment>().stream() : a.getSub().stream()
        ).collect(Collectors.toList());
        if (segments == null || segments.isEmpty()) {
            return;
        }
        execute(segments, param, resultMap);
    }

    private class Task implements Callable<Boolean> {
        private DataSource dataSource;
        private Map<String, Object> param;
        private Map<String, Object> resultMap;

        Task(DataSource dataSource, Map<String, Object> param, Map<String, Object> resultMap) {
            this.param = param;
            this.dataSource = dataSource;
            this.resultMap = resultMap;
        }

        @Override
        public Boolean call() {
            Map<String, Object> map = new HashMap<>(param);
            CommonUtils.printDifferenceMap(map, resultMap, this.getClass().getName() + "request1");
            map.putAll(resultMap);

            Map<String, Object> objectMap = dataSourceService.requestService(dataSource, map);

            CommonUtils.printDifferenceMap(objectMap, resultMap, this.getClass().getName() + "request2");
            resultMap.putAll(objectMap);
            return true;
        }
    }
}
