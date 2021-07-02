package com.xc.po;

import lombok.Data;

import java.util.List;

@Data
public class ProcessSegmentDO {
    private Integer id;

    private List<ProcessSegmentDO> sub;

}
