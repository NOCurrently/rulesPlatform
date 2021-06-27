package com.xc.datasouce.controller;

import com.xc.annotation.Verify;
import com.xc.config.WebResponse;
import com.xc.mapper.DataSourceMapper;
import com.xc.po.DataSource;
import com.xc.datasouce.service.DataSourceService;
import com.xc.vo.DataSourceVo;
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
@RequestMapping(value = "/xiaochao/data_source")
public class DataSourceController {

    @Autowired
    private DataSourceMapper dataSourceMapper;
    @Autowired
    private DataSourceService dataSourceService;

    @RequestMapping(value = "/insert", method = RequestMethod.POST)
    @ApiOperation("插入数据源")
    public WebResponse insertDataSource(@RequestBody  DataSource dataSource) {
        if (dataSource.getType()==0){
            String paramTemplate = dataSource.getParamTemplate();
            if (!paramTemplate.startsWith("[")) {
                dataSource.setParamTemplate("[" + paramTemplate + "]");
            }
        }
        int insert = dataSourceMapper.insert(dataSource);
        return WebResponse.succeed(null);
    }

    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ApiOperation("修改数据源")
    public int updateDataSource(@RequestBody DataSource dataSource) {
        String paramTemplate = dataSource.getParamTemplate();
        if (!paramTemplate.startsWith("[")) {
            dataSource.setParamTemplate("[" + paramTemplate + "]");
        }
        return dataSourceMapper.update(dataSource);
    }

    @RequestMapping(value = "/select_by_ids", method = RequestMethod.POST)
    @ApiOperation("查询数据源")
    public List<DataSource> selectByIds(@RequestBody Set<Integer> ids) {
        return dataSourceMapper.selectByIds(ids);
    }

    @RequestMapping(value = "/dataSourceService", method = RequestMethod.POST)
    @ApiOperation("dataSourceService")
    public Map<String, Object> dataSourceService(@RequestBody DataSourceVo executeVo) {
        DataSource dataSource = dataSourceMapper.selectById(executeVo.getId());

        Map<String, Object> execute = dataSourceService.requestService(dataSource, executeVo.getParam());
        return execute;
    }

}
