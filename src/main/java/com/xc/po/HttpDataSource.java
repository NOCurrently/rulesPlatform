package com.xc.po;

import lombok.Data;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Data
public class HttpDataSource {
    private String url;
    private String paramTemplate;
    private int requestType;//0:post,1:get
    private int dataType;//0:param,1:json
    private String headers;
    private String resultExtract;
    private Integer timeout;
    private String backup;

}
