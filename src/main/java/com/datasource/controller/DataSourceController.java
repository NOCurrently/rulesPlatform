package com.datasource.controller;

import com.datasource.mapper.AggregatDataSourceMapper;
import com.datasource.mapper.DataSourceMapper;
import com.datasource.po.DataSource;
import com.datasource.service.AggregatDataSourceService;
import com.datasource.service.DataSourceService;
import com.datasource.vo.ExecuteVo;
import com.datasource.vo.ExecuteVo1;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Api(description = "数据源")
@RestController
@Slf4j
@RequestMapping(value = "/data_source")
public class DataSourceController {

    @Autowired
    private DataSourceMapper dataSourceMapper;
    @Autowired
    private DataSourceService dataSourceService;

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation("插入数据源")
    public int insertDataSource(@RequestBody DataSource dataSource) {
        return dataSourceMapper.insert(dataSource);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation("修改数据源")
    public int updateDataSource(@RequestBody DataSource dataSource) {
        return dataSourceMapper.update(dataSource);
    }

    @RequestMapping(value = "/select_by_ids", method = RequestMethod.POST)
    @ApiOperation("查询数据源")
    public List<DataSource> selectByIds(@RequestBody Set<Integer> ids) {
        return dataSourceMapper.selectByIds(ids);
    }
    @RequestMapping(value = "/dataSourceService", method = RequestMethod.POST)
    @ApiOperation("dataSourceService")
    public Map<String, Object> dataSourceService(@RequestBody ExecuteVo1 executeVo) {
        DataSource dataSource = dataSourceMapper.selectById(executeVo.getId());

        Map<String, Object> execute = dataSourceService.execute(dataSource, executeVo.getParam());
        return execute;
    }

}
