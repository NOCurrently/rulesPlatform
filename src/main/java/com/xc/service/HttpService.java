package com.xc.service;

import com.xc.po.DataSource;
import com.xc.po.HttpDataSource;
import com.xc.until.HttpClientUtil;
import com.xc.until.JsonUtil;

import java.util.Map;

public class HttpService extends DataService<HttpDataSource> {
    @Override
    public Object requestService(HttpDataSource dataSource, String requestParam) {
        String result ;
        if (dataSource.getDataType() == 0) {
            Map<String, String> stringObjectMap = JsonUtil.json2MapString(requestParam);
            if (dataSource.getRequestType() == 0) {
                result = HttpClientUtil.doPost(dataSource.getUrl(), stringObjectMap);
            } else {
                result = HttpClientUtil.doGet(dataSource.getUrl(), stringObjectMap);
            }
        } else {
            result = HttpClientUtil.doPostJson(dataSource.getUrl(), requestParam);
        }

        return result;
    }
}
