package com.xc.po;

import lombok.Data;

import java.util.Date;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Data
public class DataSource {
    /**
     * 通用参数
     */
    private Integer id;
    private String paramTemplate;
    private String resultExtract;
    private Integer timeout;
    private String backup;
    private Integer type;//0:rpc,1:http
    private Integer status;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
    /**
     * http独有参数
     */
    private String url;
    private Integer requestType;//0:post,1:get
    private Integer dataType;//0:param,1:json
    private String headers;
    /**
     * RPC独有参数
     */
    private String service;
    private String method;
    private String token;
    private String alise;
}
