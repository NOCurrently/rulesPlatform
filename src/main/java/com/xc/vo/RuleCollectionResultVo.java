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
public class RuleCollectionResultVo {

    private List<RuleResultVo> ruleResultVos;
    private boolean success;
}
