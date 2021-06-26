package com.xc.datasouce.manage;

import com.xc.mapper.AggregatDataSourceMapper;
import com.xc.po.AggregatDataSource;
import com.xc.datasouce.service.AggregatDataSourceService;
import com.xc.until.CommonUtils;
import com.xc.until.JsonUtil;
import com.xc.vo.ProcessSegment;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Service
@Slf4j
public class ProcessSegmentManage {
    @Autowired
    private AggregatDataSourceService aggregatDataSourceService;
    @Autowired
    private AggregatDataSourceMapper aggregatDataSourceMapper;
    private static final ThreadPoolExecutor poolExecutor = new ThreadPoolExecutor(20, 100, 5, TimeUnit.MINUTES, new ArrayBlockingQueue<>(1));

    public Map<String, Object> executeProcess(Integer aggregatId, Map<String, Object> param) throws ExecutionException, InterruptedException {
        AggregatDataSource aggregatDataSource = aggregatDataSourceMapper.selectById(aggregatId);
        List<ProcessSegment> processSegments = null;
        if (aggregatDataSource == null || StringUtils.isBlank(aggregatDataSource.getProcessSegmentJson())) {
            throw new RuntimeException("aggregatId 不存在!");
        }
        processSegments = JsonUtil.parseArray(aggregatDataSource.getProcessSegmentJson(), ProcessSegment.class);
        if (processSegments == null || processSegments.isEmpty()) {
            throw new RuntimeException("ProcessSegmentJson 不合法!");
        }
        Map<String, Object> resultMap = new HashMap<>();
        //处理依赖请求
        String dependAggregatIdsString = aggregatDataSource.getDependAggregatIds();
        if (StringUtils.isNotBlank(dependAggregatIdsString)) {
            List<Integer> dependAggregatIds = JsonUtil.parseArray(dependAggregatIdsString, Integer.class);
            if (dependAggregatIds != null && !dependAggregatIds.isEmpty()) {
                List<Future<Map<String, Object>>> futures = new ArrayList<>();

                for (Integer dependAggregatId : dependAggregatIds) {
                    Future<Map<String, Object>> submit = poolExecutor.submit(new Task(dependAggregatId, param));
                    futures.add(submit);
                }
                for (Future<Map<String, Object>> future : futures) {
                    Map<String, Object> m = future.get();
                    CommonUtils.printDifferenceMap(m, resultMap, this.getClass().getName() + "聚合");
                    resultMap.putAll(m);
                }
            }
        }
        //处理请求
        aggregatDataSourceService.execute(processSegments, param, resultMap);
        return resultMap;
    }

    private class Task implements Callable<Map<String, Object>> {
        private Integer aggregatId;
        private Map<String, Object> param;

        Task(Integer aggregatId, Map<String, Object> param) {
            this.aggregatId = aggregatId;
            this.param = param;
        }

        @Override
        public Map<String, Object> call() throws ExecutionException, InterruptedException {
            return executeProcess(aggregatId, param);
        }
    }
}
