package com.xc.po;

import lombok.Data;

import java.util.Date;

@Data
public class Rule {
    private String name;
    private Integer type;
    private int sort;
    private String expressionJsonList;
    private String executiveLogic;
    private String actionJsonList;
    private Integer status;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
}
