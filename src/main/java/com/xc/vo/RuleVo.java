package com.xc.vo;

import lombok.Data;

import java.util.Map;

@Data
public class RuleVo {
    private Integer id;
    private Map<String,Object> param;
}
