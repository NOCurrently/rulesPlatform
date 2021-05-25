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
public class RPCDataSource {

    private String service;
    private String method;
    private String token;
    private String alise;
    private String paramTemplate;
    private String resultExtract;
    private Integer timeout;
    private String backup;
}
