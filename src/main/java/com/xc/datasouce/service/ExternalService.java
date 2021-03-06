package com.xc.datasouce.service;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.xc.constant.ConstantType;
import com.xc.po.DataSource;
import com.xc.until.HttpUtil;
import com.xc.until.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.dubbo.config.ApplicationConfig;
import org.apache.dubbo.config.ReferenceConfig;
import org.apache.dubbo.config.RegistryConfig;
import org.apache.dubbo.config.utils.ReferenceConfigCache;
import org.apache.dubbo.rpc.service.GenericService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class ExternalService {
    @Autowired
    private ApplicationConfig applicationConfig;
    @Autowired
    private RegistryConfig registryConfig;

    public String requestHttpService(DataSource dataSource, String requestParam) {
        String result;
        String headers = dataSource.getHeaders();
        Map<String, String> headersMap = null;
        if (StringUtils.isNotBlank(headers)) {
            headersMap = JsonUtil.parseMapString(headers);
        }
        Integer dataType = dataSource.getDataType() == null ? 0 : dataSource.getDataType();
        if (dataType == ConstantType.DataType.PARAM) {
            Map<String, String> stringObjectMap = JsonUtil.parseMapString(requestParam);
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
        try {
            ReferenceConfig<GenericService> referenceConfig = new ReferenceConfig<>();
            referenceConfig.setInterface(dataSource.getService());
            referenceConfig.setApplication(applicationConfig);
            referenceConfig.setRegistry(registryConfig);
            referenceConfig.setTimeout(1000);
            referenceConfig.setUrl("dubbo://127.0.0.1:5001");
            referenceConfig.setGeneric(Boolean.TRUE);
            referenceConfig.setCheck(false);
            referenceConfig.setRetries(0);
            ReferenceConfigCache cache = ReferenceConfigCache.getCache();
            GenericService genericService = cache.get(referenceConfig);

            List<String> parameterTypes = new ArrayList<>();
            List<Object> parameter = new ArrayList<>();

            List<Object> paramList = JSON.parseArray(requestParam, Object.class);
            for (Object params : paramList) {
                String clazz = null;
                if (params instanceof JSONObject) {
                    clazz = (String) ((JSONObject) params).get("class");
                    if (clazz == null) {
                        clazz = Map.class.getName();
                    }
                } else if (params instanceof JSONArray) {
                    clazz = List.class.getName();
                } else {
                    clazz = params.getClass().getName();
                }
                parameterTypes.add(clazz);
                parameter.add(params);
            }
            log.error("requestRPCService parameterTypes ={} ,parameter ={}", parameterTypes,parameter);
            // ??????????????????Date,List,Map?????????????????????????????????
            Object result = genericService.$invoke(dataSource.getMethod(), parameterTypes.toArray(new String[0]), parameter.toArray());
            if (result != null) {
                if (result instanceof String) {
                    return (String) result;
                }
                return JsonUtil.toJSONString(result);
            }
        } catch (Exception e) {
            log.error("referenceConfig GenericException", e);
        }
        return null;
    }


}
