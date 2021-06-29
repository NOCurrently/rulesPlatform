package com.xc.datasouce.service;

import com.xc.po.DataSource;
import com.jayway.jsonpath.JsonPath;
import com.xc.until.CommonUtils;
import com.xc.until.EasyUtils;
import com.xc.until.JsonUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
public class DataSourceService {
    @Autowired
    private ExternalService externalService;



    public Map<String, Object> requestService(DataSource dataSource, Map<String, Object> param) {
        String paramTemplate = dataSource.getParamTemplate();
        if (param == null) {
            param = new HashMap<>();
        }
        Map<String, String> collect = param.entrySet().stream().collect(Collectors.toMap(item -> item.getKey(), item -> EasyUtils.toString(item.getValue())));

        String requestParam = null;
        if (StringUtils.isNotBlank(paramTemplate)) {
            try {
                requestParam = CommonUtils.assemblyTemplate(paramTemplate, collect);
            } catch (Exception e) {
                throw new RuntimeException("freemarker process template exception", e);
            }
        }
        log.error("requestService requestParam {}", requestParam);
        String result = null;
        if (dataSource.getType() == 0) {
            result = externalService.requestRPCService(dataSource, requestParam);
        } else if (dataSource.getType() == 1) {
            result = externalService.requestHttpService(dataSource, requestParam);
        }
        log.error("requestService result {}", result);
        if (result == null) {
            result = dataSource.getBackup();
        }
        Map<String, Object> mappingResult = new HashMap<>();
        if (result == null) {
            return mappingResult;
        }
        String resultExtract = dataSource.getResultExtract();
        if (StringUtils.isNotBlank(resultExtract)) {
            Map<String, String> resultExtractMap = JsonUtil.parseMapString(resultExtract);
            for (Map.Entry<String, String> entry : resultExtractMap.entrySet()) {
                try {
                    Object extract = JsonPath.read(result, entry.getKey());
                    mappingResult.put(entry.getValue(), extract);
                } catch (Exception e) {
                    log.error("jsonPath result extract exception", e);
                }
            }
        }
        return mappingResult;
    }



}
