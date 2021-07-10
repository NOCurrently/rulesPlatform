package com.xc.vo;

import lombok.Data;

import java.util.Map;

@Data
public class PageVo {
    private Integer pageNum;
    private Integer pageSize;
    private Object list;
    private int total;
}
