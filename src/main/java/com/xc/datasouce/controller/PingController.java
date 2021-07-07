package com.xc.datasouce.controller;

import com.google.common.collect.ImmutableMap;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.Map;

/**
 * @author woney.wang
 * @date 2018-10-16
 */
@RestController
@RequestMapping
@Slf4j
public class PingController {
    @Value("${server.port}")
    private String serverPort;
    @Value("${spring.application.name}")
    private String applicationName;


    /**
     * @return
     */
    @GetMapping(value = "/ping")
    @ResponseBody
    public Map<String, Object> ping() {
        return ImmutableMap.of("message", "pong!", "applicationName", applicationName, "serverPort", serverPort);
    }


}
