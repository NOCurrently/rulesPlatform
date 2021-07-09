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
public class RuleCollection {
    private Integer id;
    private String name;
    private Integer type;
    private Integer status;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
}
