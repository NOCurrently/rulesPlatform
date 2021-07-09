package com.xc.rule;

import com.xc.mapper.RuleCollectionMapper;
import com.xc.mapper.RuleMapper;
import com.xc.po.Rule;
import com.xc.po.RuleCollection;
import com.xc.vo.RuleCollectionResultVo;
import com.xc.vo.RuleResultVo;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Service
@Slf4j
public class RuleCollectionService {
    @Autowired
    private RuleService ruleService;
    @Autowired
    private RuleMapper ruleMapper;

    public RuleCollectionResultVo execute(RuleCollection ruleCollection, Map<String, Object> param, boolean isDebug) throws ExecutionException, InterruptedException {
        List<Rule> rules = ruleMapper.selectByRuleCollId(ruleCollection.getId());
        RuleCollectionResultVo ruleCollectionResultVo = new RuleCollectionResultVo();
        if (rules == null || rules.isEmpty()) {
            throw new RuntimeException("没配置规则!");
        }
        List<RuleResultVo> list = new ArrayList<>();
        ruleCollectionResultVo.setRuleResultVos(list);
        for (Rule rule : rules) {
            RuleResultVo execute = ruleService.execute(rule, param, isDebug);
            list.add(execute);
            if (!execute.isSuccess()) {
                return ruleCollectionResultVo;
            }
        }
        ruleCollectionResultVo.setSuccess(true);
        return ruleCollectionResultVo;

    }
}
