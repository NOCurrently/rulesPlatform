package com.xc.datasouce.service;

import com.xc.mapper.DataSourceMapper;
import com.xc.po.AggregatDataSource;
import com.xc.po.DataSource;
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

    public Map<String, Object> execute(List<AggregatDataSource> aggregatDataSources, Map<String, Object> param) {
        Map<String, Object> result = new HashMap<>();
        try {
            Set<Integer> dsIds = aggregatDataSources.stream().map(AggregatDataSource::getDsId).collect(Collectors.toSet());
            List<DataSource> dataSources = dataSourceMapper.selectByIds(dsIds);
            Map<Integer, DataSource> sourceMap = dataSources.stream().collect(Collectors.toMap(DataSource::getId, a -> a, (k1, k2) -> k1));

            List<Future<Map<String, Object>>> futures = new ArrayList<>();
            for (AggregatDataSource aggregatDataSource : aggregatDataSources) {
                DataSource dataSource = sourceMap.get(aggregatDataSource.getDsId());
                Future<Map<String, Object>> submit = poolExecutor.submit(new Task(dataSourceService, aggregatDataSource, dataSource, param));
                futures.add(submit);
            }
            for (Future<Map<String, Object>> future : futures) {
                result.putAll(future.get());
            }
        } catch (Exception e) {
            log.error("execute Exception", e);
        }
        return result;
    }


    class Task implements Callable<Map<String, Object>> {
        private AggregatDataSource aggregatDataSource;
        private DataSourceService dataSourceService;
        private DataSource dataSource;
        private Map<String, Object> param;

        Task(DataSourceService dataSourceService, AggregatDataSource aggregatDataSource, DataSource dataSource, Map<String, Object> param) {
            this.dataSourceService = dataSourceService;
            this.param = param;
            this.aggregatDataSource = aggregatDataSource;
            this.dataSource = dataSource;
        }


        @Override
        public Map<String, Object> call() {
            Map<String, Object> objectMap = dataSourceService.requestService(dataSource, param);
            List<AggregatDataSource> subAds = aggregatDataSource.getSubAds();
            if (subAds == null || subAds.isEmpty()) {
                return objectMap;
            }
            param.putAll(objectMap);
            Map<String, Object> execute = execute(subAds, param);
            objectMap.putAll(execute);
            return objectMap;
        }
    }
}
