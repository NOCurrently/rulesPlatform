package com.xc.datasouce.service;

import com.xc.mapper.DataSourceMapper;
import com.xc.po.DataSource;
import com.xc.until.CommonUtils;
import com.xc.po.ProcessSegmentDO;
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

    public void execute(List<ProcessSegmentDO> processSegmentDOS, Map<String, Object> param, Map<String, Object> resultMap) throws ExecutionException, InterruptedException {
        Set<Integer> ids = processSegmentDOS.stream().map(ProcessSegmentDO::getId).collect(Collectors.toSet());
        List<DataSource> dataSources = dataSourceMapper.selectByIds(ids);
        Map<Integer, DataSource> sourceMap = dataSources.stream().collect(Collectors.toMap(DataSource::getId, a -> a, (k1, k2) -> k1));

        List<Future<Boolean>> futures = new ArrayList<>();
        for (ProcessSegmentDO processSegmentDO : processSegmentDOS) {
            DataSource dataSource = sourceMap.get(processSegmentDO.getId());
            if (dataSource == null) {
                throw new RuntimeException("dataSource 不存在 id=" + processSegmentDO.getId());
            }
            Future<Boolean> submit = poolExecutor.submit(new Task(dataSource, param, resultMap));
            futures.add(submit);
        }
        for (Future<Boolean> future : futures) {
            future.get();
        }
        List<ProcessSegmentDO> segments = processSegmentDOS.stream().flatMap(a ->
                a.getSub() == null ? new ArrayList<ProcessSegmentDO>().stream() : a.getSub().stream()
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
