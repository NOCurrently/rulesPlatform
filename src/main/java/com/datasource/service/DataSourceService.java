package com.datasource.service;

import com.datasource.constant.ConstantType;
import com.datasource.po.DataSource;
import com.datasource.until.HttpUtil;
import com.datasource.until.JsonUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.ApplicationConfig;
import org.apache.dubbo.config.ReferenceConfig;
import org.apache.dubbo.config.RegistryConfig;
import org.apache.dubbo.config.utils.ReferenceConfigCache;
import org.apache.dubbo.rpc.service.GenericException;
import org.apache.dubbo.rpc.service.GenericService;
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
    private ApplicationConfig applicationConfig;
    @Autowired
    private RegistryConfig registryConfig;

    private final static Configuration configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);

    static {
        configuration.setNumberFormat("#");
    }

    public Map<String, Object> execute(DataSource dataSource, Map<String, Object> param) {
        String paramTemplate = dataSource.getParamTemplate();
        String requestParam = null;
        if (StringUtils.isNotBlank(paramTemplate)) {
            try {
                Template template = new Template(null, new StringReader(paramTemplate), configuration);
                StringWriter writer = new StringWriter();
                template.process(param, writer);
                requestParam = writer.getBuffer().toString();
            } catch (Exception e) {
                log.error("freemarker.template 合成失败", e);
            }
        }
        String result = null;
        if (dataSource.getType() == 0) {
            result = requestRPCService(dataSource, requestParam);
        } else if (dataSource.getType() == 1) {
            result = requestHttpService(dataSource, requestParam);
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
            boolean isJsonAble = JsonUtil.isJSONString(result);
            if (isJsonAble) {
                for (Map.Entry<String, String> entry : resultExtractMap.entrySet()) {
                    Object extract = extract(entry.getKey(), result);
                    mappingResult.put(entry.getValue(), extract);
                }
            } else {
                for (Map.Entry<String, String> entry : resultExtractMap.entrySet()) {
                    mappingResult.put(entry.getValue(), result);
                }
            }
        }
        return mappingResult;
    }

    private Object extract(String fieldPath, String resultStr) {
        Map<String, Object> resultMap = JsonUtil.json2Map(resultStr);
        String[] split = fieldPath.split("\\.");
        Object res = null;
        int length = split.length;
        for (int i = 0; i < length; i++) {
            String s = split[i];
            Object object = resultMap.get(s);
            if (i == length - 1) {
                res = object;
                break;
            }
            if (object instanceof Map) {
                resultMap = (Map) object;
            } else {
                break;
            }
        }
        return res;
    }

    public String requestHttpService(DataSource dataSource, String requestParam) {
        String result;
        String headers = dataSource.getHeaders();
        Map<String, String> headersMap = null;
        if (StringUtils.isNotBlank(headers)) {
            headersMap = JsonUtil.json2MapString(headers);
        }
        Integer dataType = dataSource.getDataType() == null ? 0 : dataSource.getDataType();
        if (dataType == ConstantType.DataType.PARAM) {
            Map<String, String> stringObjectMap = JsonUtil.json2MapString(requestParam);
            Integer requestType = dataSource.getRequestType() == null ? 0 : dataSource.getRequestType();
            if (requestType == ConstantType.RequestType.POST) {
                result = HttpUtil.doPost(dataSource.getUrl(), stringObjectMap, headersMap, null, dataSource.getTimeout());
            } else {
                result = HttpUtil.doGet(dataSource.getUrl(), stringObjectMap, headersMap, null, dataSource.getTimeout());
            }
        } else {
            result = HttpUtil.doPostJson(dataSource.getUrl(), requestParam, headersMap, null, dataSource.getTimeout());
        }

        return result;
    }

    public String requestRPCService(DataSource dataSource, String requestParam) {
        Object o = referenceConfig(dataSource.getService(), dataSource.getMethod(), requestParam);
        if (o != null) {
            if (o instanceof String) {
                return (String) o;
            }
            return JsonUtil.write2JsonStr(o);
        }
        return null;
    }

    public Object referenceConfig(String service, String mether, String param) {
        try {
            ReferenceConfig<GenericService> referenceConfig = new ReferenceConfig<>();
            referenceConfig.setInterface(service);
            referenceConfig.setApplication(applicationConfig);
            referenceConfig.setRegistry(registryConfig);
            referenceConfig.setTimeout(1000);
            referenceConfig.setUrl("dubbo://127.0.0.1:5001");
            referenceConfig.setGeneric(Boolean.TRUE);
            referenceConfig.setCheck(false);
            referenceConfig.setRetries(0);
            ReferenceConfigCache cache = ReferenceConfigCache.getCache();
            GenericService genericService = cache.get(referenceConfig);

            boolean jsonString = JsonUtil.isJSONString(param);
            Object pram = null;
            String name = null;
            if (jsonString) {
                pram = JsonUtil.json2Map(param);
                name = Map.class.getName();
            } else {
                pram = param;
                name = String.class.getName();
            }
            // 基本类型以及Date,List,Map等不需要转换，直接调用

            Object result = genericService.$invoke(mether, new String[]{name},
                    new Object[]{pram});
            return result;
        } catch (GenericException e) {
            log.error("referenceConfig GenericException", e);
        }
        return null;
    }

}
