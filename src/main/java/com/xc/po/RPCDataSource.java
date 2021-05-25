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
public class RPCDataSource extends DataSource{

    private String service;
    private String method;
    private String token;
    private String alise;
}
