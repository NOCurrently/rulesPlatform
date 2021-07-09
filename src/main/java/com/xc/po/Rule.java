package com.xc.po;

import lombok.Data;

import java.util.Date;

@Data
public class Rule {
    private Integer id;
    private String name;
    private Integer type;
    private Integer sort;
    //规则列表
    private String expressionJsonList;
    //执行逻辑
    private String executiveLogic;
    //执行动作
    private String actionJsonList;
    //数据源id
    private Integer aggregatId;
    //规则集合id
    private Integer ruleCollectionId;
    private String expectReturn;
    private String paramJson;
    private Integer status;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
}
