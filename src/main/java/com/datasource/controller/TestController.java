package com.datasource.controller;

import com.datasource.po.DataSource;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Api(description = "测试")
@RestController
@Slf4j
public class TestController {


    @RequestMapping(value = "/get", method = RequestMethod.GET)
    @ApiOperation("get")
    public Map<String, Object> insertDataSource(DataSource dataSource, HttpServletRequest request) {
        String type = request.getHeader("type");
        log.info(type + "--get--");
        log.info(dataSource + "--get--");
        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        Map<String, Object> data = new HashMap<>();
        Map<String, Object> dto = new HashMap<>();
        dto.put("name", "get");
        data.put("dto", dto);
        map.put("data", data);
        return map;
    }

    @RequestMapping(value = "/post", method = RequestMethod.POST)
    @ApiOperation("post")
    public Map<String, Object> updateDataSource(DataSource dataSource, HttpServletRequest request) {
        String type = request.getHeader("type");
        log.info(type + "--POST--");
        log.info(dataSource + "--POST--");
        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        Map<String, Object> data = new HashMap<>();
        Map<String, Object> dto = new HashMap<>();
        dto.put("name", "post");
        data.put("dto", dto);
        map.put("data", data);
        return map;
    }

    @RequestMapping(value = "/postJson", method = RequestMethod.POST)
    @ApiOperation("postJson")
    public Map<String, Object> selectByIds(@RequestBody DataSource dataSource, HttpServletRequest request) {
        /*Enumeration<String> headerNames = request.getHeaderNames();
        while (headerNames.hasMoreElements()){
            String s = headerNames.nextElement();
            String header = request.getHeader(s);
            System.out.println(header);
        }*/
        String type = request.getHeader("type");
        log.info(type + "--postJson--");
        log.info(dataSource + "--postJson--");
        Map<String, Object> map = new HashMap<>();
        map.put("code", 0);
        Map<String, Object> data = new HashMap<>();
        Map<String, Object> dto = new HashMap<>();
        dto.put("name", "postJson");
        data.put("dto", dto);
        map.put("data", data);
        return map;
    }

}
