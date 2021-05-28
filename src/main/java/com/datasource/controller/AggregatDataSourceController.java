package com.datasource.controller;

import com.datasource.manage.DataSourceManage;
import com.datasource.mapper.AggregatDataSourceMapper;
import com.datasource.po.AggregatDataSource;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.datasource.vo.*;
import java.util.List;
import java.util.Map;
import java.util.Set;

@Api(description = "聚合数据源")
@RestController
@Slf4j
@RequestMapping(value = "/aggregat_data_source")
public class AggregatDataSourceController {

    @Autowired
    private AggregatDataSourceMapper aggregatDataSourceMapper;
    @Autowired
    private DataSourceManage dataSourceManage;

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation("插入聚合数据源")
    public int insertAggregatDataSource(@RequestBody AggregatDataSource aggregatDataSource) {
        return aggregatDataSourceMapper.insert(aggregatDataSource);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation("修改聚合数据源")
    public int updateDataSource(@RequestBody AggregatDataSource dataSource) {
        return aggregatDataSourceMapper.update(dataSource);
    }

    @RequestMapping(value = "/select_by_ids", method = RequestMethod.POST)
    @ApiOperation("查询聚合数据源")
    public List<AggregatDataSource> selectByIds(@RequestBody Set<Integer> ids) {
        return aggregatDataSourceMapper.selectByIds(ids);
    }

    @RequestMapping(value = "/execute", method = RequestMethod.POST)
    @ApiOperation("执行聚合数据源")
    public Map<String, Object> execute(@RequestBody ExecuteVo executeVo) {
        Map<String, Object> map = dataSourceManage.executeDataSource(executeVo.getKey(), executeVo.getParam());
        System.out.println(executeVo.getParam());
        return map;
    }

}
