package com.datasource.manage;

import com.datasource.mapper.AggregatDataSourceMapper;
import com.datasource.po.AggregatDataSource;
import com.datasource.service.AggregatDataSourceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Service
public class DataSourceManage {
    @Autowired
    private AggregatDataSourceService aggregatDataSourceService;
    @Autowired
    private AggregatDataSourceMapper aggregatDataSourceMapper;

    public Map<String, Object> executeDataSource(String key, Map<String, Object> param) {
        List<AggregatDataSource> aggregatDataSources = aggregatDataSourceMapper.selectByKey(key);
        Map<String, Object> execute = aggregatDataSourceService.execute(execute(aggregatDataSources), param);
        return execute;
    }

    private List<AggregatDataSource> execute(List<AggregatDataSource> aggregatDataSources) {
        Map<Integer, List<AggregatDataSource>> groupBy = aggregatDataSources.stream().collect(Collectors.groupingBy(AggregatDataSource::getParentId));
        List<AggregatDataSource> parentDo = groupBy.get(0);
        if (parentDo != null) {
            doExecute(groupBy, parentDo);
        }
        return parentDo;
    }


    private void doExecute(Map<Integer, List<AggregatDataSource>> groupBy, List<AggregatDataSource> parentDo) {
        for (AggregatDataSource aggregatDataSource : parentDo) {
            Integer id = aggregatDataSource.getId();
            List<AggregatDataSource> aggregatDataSources = groupBy.get(id);
            if (aggregatDataSources == null) {
                continue;
            }
            aggregatDataSource.setSubAds(aggregatDataSources);
            doExecute(groupBy, aggregatDataSources);
        }
    }
}
