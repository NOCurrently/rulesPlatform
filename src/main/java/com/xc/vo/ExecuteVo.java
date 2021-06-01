package com.xc.vo;

import lombok.Data;

import java.util.Map;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Data
public class ExecuteVo {

    private String key;
    private Map<String ,Object> param;
}
