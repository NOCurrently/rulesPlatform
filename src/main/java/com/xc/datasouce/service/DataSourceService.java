package com.xc.datasouce.service;

import com.xc.po.DataSource;
import com.xc.until.JsonUtil;
import com.jayway.jsonpath.JsonPath;
import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Service
public class DataSourceService {
    @Autowired
    private ExternalService externalService;

    private final static Configuration configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);

    static {
        configuration.setNumberFormat("#");
    }

    public Map<String, Object> requestService(DataSource dataSource, Map<String, Object> param) {
        String paramTemplate = dataSource.getParamTemplate();
        String requestParam = null;
        if (StringUtils.isNotBlank(paramTemplate)) {
            try {
                Template template = new Template(null, new StringReader(paramTemplate), configuration);
                StringWriter writer = new StringWriter();
                template.process(param, writer);
                requestParam = writer.getBuffer().toString();
            } catch (Exception e) {
                throw new RuntimeException("freemarker process template exception", e);
            }
        }
        String result = null;
        if (dataSource.getType() == 0) {
            result = externalService.requestRPCService(dataSource, requestParam);
        } else if (dataSource.getType() == 1) {
            result = externalService.requestHttpService(dataSource, requestParam);
        }
        if (result == null) {
            result = dataSource.getBackup();
        }
        Map<String, Object> mappingResult = new HashMap<>();
        if (result == null) {
            return mappingResult;
        }
        String resultExtract = dataSource.getResultExtract();
        if (StringUtils.isNotBlank(resultExtract)) {
            Map<String, String> resultExtractMap = JsonUtil.json2MapString(resultExtract);
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
