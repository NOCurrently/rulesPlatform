package com.xc.datasouce.controller;

import com.xc.annotation.Log;
import com.xc.datasouce.manage.ProcessSegmentManage;
import com.xc.mapper.AggregatDataSourceMapper;
import com.xc.po.AggregatDataSource;
import com.xc.vo.AggregatDataVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ExecutionException;

@Api(description = "聚合数据源")
@RestController
@Slf4j
@RequestMapping(value = "/xiaochao/aggregat_data_source")
public class AggregatDataSourceController {

    @Autowired
    private AggregatDataSourceMapper aggregatDataSourceMapper;
    @Autowired
    private ProcessSegmentManage dataSourceManage;

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
    @Log
    public List<AggregatDataSource> selectByIds(@RequestBody Set<Integer> ids) {
        return aggregatDataSourceMapper.selectByIds(ids);
    }

    @RequestMapping(value = "/execute", method = RequestMethod.POST)
    @ApiOperation("执行聚合数据源")
    public Map<String, Object> execute(@RequestBody AggregatDataVo executeVo) {
        Map<String, Object> map = null;
        try {
            map = dataSourceManage.executeProcess(executeVo.getId(), executeVo.getParam());
        } catch (ExecutionException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println(executeVo.getParam());
        return map;
    }

}
