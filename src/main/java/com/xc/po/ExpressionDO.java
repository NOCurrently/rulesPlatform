package com.xc.po;

import lombok.Data;

@Data
public class ExpressionDO {

    private String left;
    private String operation;
    private String right;
    private boolean isReverse;
    private String message;
}
