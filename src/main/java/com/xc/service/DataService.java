package com.xc.service;

import com.xc.po.DataSource;
import com.xc.until.EasyUtils;
import com.xc.until.JsonUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.HashMap;
import java.util.Map;

public abstract class DataService<T extends DataSource> {

    private final static Configuration configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);

    static {
        configuration.setNumberFormat("#");
    }

    public Map<String, Object> execute(T dataSource, Map<String, Object> param) throws TemplateException, IOException {
        String paramTemplate = dataSource.getParamTemplate();
        String requestParam = null;
        if (StringUtils.isNotBlank(paramTemplate)) {
            Template template = new Template(null, new StringReader(paramTemplate), configuration);
            StringWriter writer = new StringWriter();
            template.process(param, writer);
            requestParam = writer.getBuffer().toString();
        }
        Object result = requestService(dataSource, requestParam);
        String resultExtract = dataSource.getResultExtract();
        Map<String, Object> mappingResult = new HashMap<>();
        if (StringUtils.isNotBlank(resultExtract) && result != null) {
            Map<String, String> resultExtractMap = JsonUtil.json2MapString(resultExtract);
            for (Map.Entry<String, String> entry : resultExtractMap.entrySet()) {
                Object extract = extract(entry.getKey(), result);
                mappingResult.put(entry.getValue(), extract);
            }
        }
        return mappingResult;
    }

    private Object extract(String fieldPath, Object result) {
        Map<String, Object> resultMap = new HashMap<>();
        String[] split = fieldPath.split(".");
        for (String s : split) {
            if (result == null) {
                break;
            }
            resultMap = JsonUtil.json2Map(JsonUtil.write2JsonStr(result));
            result = resultMap.get(s);

        }
        return result;
    }

    public abstract Object requestService(T dataSource, String requestParam);
}
