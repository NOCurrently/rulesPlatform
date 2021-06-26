package com.xc.vo;

import lombok.Data;

import java.util.List;

@Data
public class ProcessSegment {
    private Integer id;

    private List<ProcessSegment> sub;

}
