package com.xc.datasouce.controller;

import com.xc.config.WebResponse;
import com.xc.datasouce.service.DataSourceService;
import com.xc.datasouce.service.DictService;
import com.xc.mapper.DataSourceMapper;
import com.xc.po.DataSource;
import com.xc.po.DictType;
import com.xc.po.DictValue;
import com.xc.vo.DataSourceVo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Api(description = "数据字典")
@RestController
@Slf4j
@RequestMapping(value = "/xiaochao/dict")
public class DictController {

    @Autowired
    private DictService dictService;

    @RequestMapping(value = "/insertType", method = RequestMethod.POST)
    @ApiOperation("插入类型")
    public WebResponse insertDataSource(@RequestBody DictType dataSource) {
        int insert = dictService.insertType(dataSource);
        return WebResponse.succeed(insert);
    }

    @RequestMapping(value = "/insertValue", method = RequestMethod.POST)
    @ApiOperation("插入值")
    public WebResponse updateDataSource(@RequestBody DictValue dataSource) {
        int insert = dictService.insertValue(dataSource);
        return WebResponse.succeed(insert);
    }

    @RequestMapping(value = "/updateType", method = RequestMethod.POST)
    @ApiOperation("更新类型")
    public WebResponse selectByIds(@RequestBody DictType dataSource) {
        int insert = dictService.updateType(dataSource);
        return WebResponse.succeed(insert);
    }

    @RequestMapping(value = "/updateValue", method = RequestMethod.POST)
    @ApiOperation("更新值")
    public WebResponse dataSourceService(@RequestBody DictValue dataSource) {
        int insert = dictService.updateValue(dataSource);
        return WebResponse.succeed(insert);
    }


}
