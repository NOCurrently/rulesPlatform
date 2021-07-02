package com.xc.vo;

import lombok.Data;

import java.util.List;
import java.util.Map;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Data
public class RuleResultVo {

    private String expression;
    private List<Map<String, Object>> deBugInfo;
    private Map<String, Object> ruleParam;
    private Object result;
}
