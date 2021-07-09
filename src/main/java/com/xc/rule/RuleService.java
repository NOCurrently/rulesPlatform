package com.xc.rule;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.TypeReference;
import com.xc.datasouce.manage.ProcessSegmentManage;
import com.xc.po.ActionDO;
import com.xc.po.ExpressionDO;
import com.xc.po.Rule;
import com.xc.until.CommonUtils;
import com.xc.until.EasyUtils;
import com.xc.until.JsonUtil;
import com.xc.vo.RuleResultVo;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ExecutionException;

@Service
@Slf4j
public class RuleService {

    @Autowired
    private ProcessSegmentManage dataSourceManage;

    public RuleResultVo execute(Rule rule, Map<String, Object> param, boolean isDebug) throws ExecutionException, InterruptedException {
        if (StringUtils.isBlank(rule.getExecutiveLogic())) {
            throw new RuntimeException("执行规则不能为空");
        }
        Integer aggregatId = rule.getAggregatId();
        String staticParam = rule.getParamJson();
        Map<String, Object> objectMap = JsonUtil.parseObject(staticParam, new TypeReference<Map<String, Object>>() {
        }, new HashMap<>());
        objectMap.putAll(param);
        if (aggregatId != null) {
            Map<String, Object> dataSourceRut = dataSourceManage.executeProcess(aggregatId, objectMap);
            objectMap.putAll(dataSourceRut);
        }
        RuleResultVo ruleResultVo = getExpression(rule.getExecutiveLogic(), rule.getExpressionJsonList(), objectMap, isDebug);

        //期望值
        boolean flag = expectReturn(ruleResultVo.getResult(), rule.getExpectReturn());
        ruleResultVo.setSuccess(flag);
        action(rule.getActionJsonList());
        return ruleResultVo;
    }

    private void action(String actionJsonList) {
        List<ActionDO> actionDOS = JsonUtil.parseArray(actionJsonList, ActionDO.class);
        if (actionDOS != null) {
            for (ActionDO actionDO : actionDOS) {
                log.info("ActionDO {}", actionDO);
            }
        }
    }

    private boolean expectReturn(Object result, String expectReturn) {
        if (StringUtils.isBlank(expectReturn)) {
            return false;
        }
        JSONObject expectReturnJson = JsonUtil.parseObject(expectReturn);
        JSONObject resultJson = JsonUtil.parseObject(JsonUtil.toJSONString(result));
        if (expectReturnJson != null && !expectReturnJson.equals(resultJson)) {
            log.warn("Expected return does not match actual return;  expectReturn={}, result={}", expectReturn, JsonUtil.toJSONString(result));
            return false;
        }
        return true;
    }


    /**
     * @param param
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    private RuleResultVo getExpression(String executiveLogic, String expressionJsonList, Map<String, Object> param, boolean isDebug) {

        RuleResultVo ruleResultVo = new RuleResultVo();
        List<Map<String, Object>> debugMessage = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        List<ExpressionDO> expressionDOs = JsonUtil.parseArray(expressionJsonList, ExpressionDO.class);
        List<String> list = CommonUtils.getRegexStr(executiveLogic, "#\\d{1,2}");
        int size = expressionDOs == null ? 0 : expressionDOs.size();
        for (String subRule : list) {
            int index = EasyUtils.parseInt(subRule.replaceAll("#", "")) - 1;
            String expression = null;
            Object execute = null;
            String message = null;
            if (index >= 0 && index < size) {
                ExpressionDO expressionDO = expressionDOs.get(index);
                expression = "(" + expressionDO.getLeft() + expressionDO.getOperation() + expressionDO.getRight() + ")";
                execute = CommonUtils.expressRunner(expression, param);
                if (execute != null && execute instanceof Boolean && !(Boolean) execute) {
                    message = expressionDO.getMessage();
                }
                map.put(subRule, execute);
            } else {
                message = "表达式列表未找到对应索引!";
            }
            if (isDebug) {
                Map<String, Object> errorMessage = new HashMap<>();
                errorMessage.put("expression", expression);
                errorMessage.put("index", index + 1);
                errorMessage.put("msg", message);
                errorMessage.put("result", execute);
                debugMessage.add(errorMessage);
            }
        }
        map.putAll(param);
        Object execute = CommonUtils.expressRunner(executiveLogic, map);
        ruleResultVo.setExpression(executiveLogic);
        ruleResultVo.setDeBugInfo(debugMessage);
        ruleResultVo.setRuleParam(param);
        ruleResultVo.setResult(execute);
        return ruleResultVo;
    }

}
