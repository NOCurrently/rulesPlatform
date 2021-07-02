package com.xc.rule;

import com.ql.util.express.DefaultContext;
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
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@Service
@Slf4j
public class RuleService {

    @Autowired
    private ProcessSegmentManage dataSourceManage;

    public RuleResultVo execute(Rule rule, Map<String, Object> param, boolean idDebug, boolean isPrintError) throws Exception {
        Integer aggregatId = rule.getAggregatId();
        Map<String, Object> objectMap = new HashMap<>(param);
        if (aggregatId != null) {
            Map<String, Object> dataSourceRut = dataSourceManage.executeProcess(aggregatId, param);
            objectMap.putAll(dataSourceRut);
        }
        RuleResultVo ruleResultVo = getExpression(rule, objectMap, idDebug, isPrintError);

        Object result = ruleResultVo.getResult();
        String expectReturnClassStr = rule.getExpectReturnClass();
        Class expectReturnClass = null;
        if (StringUtils.isNotBlank(expectReturnClassStr)) {
            expectReturnClass = Class.forName(expectReturnClassStr);
        }
        if (expectReturnClass != null && (result == null || expectReturnClass != result.getClass())) {
            log.warn("Expected return does not match actual return;  ExpectedClass={}, actual={}, actualClass={}", expectReturnClass, JsonUtil.toJSONString(result), result == null ? null : result.getClass());
        }

        String actionJsonList = rule.getActionJsonList();
        List<ActionDO> actionDOS = JsonUtil.parseArray(actionJsonList, ActionDO.class);
        if (actionDOS != null) {
            for (ActionDO actionDO : actionDOS) {
                log.info("ActionDO {}", actionDO);
            }
        }
        return ruleResultVo;
    }

    /**
     * @param rule
     * @param param
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    private RuleResultVo getExpression(Rule rule, Map<String, Object> param, boolean idDebug, boolean isPrintError) throws Exception {
        RuleResultVo ruleResultVo = new RuleResultVo();
        List<Map<String, Object>> debugMessage = new ArrayList<>();
        List<ExpressionDO> expressionDOs = JsonUtil.parseArray(rule.getExpressionJsonList(), ExpressionDO.class);
        Map<String, String> map = new HashMap<>();
        if (expressionDOs != null) {
            List<String> list = CommonUtils.getRegexStr(rule.getExecutiveLogic(), "#\\d{1,2}");
            int size = expressionDOs.size();
            for (String s : list) {
                int index = EasyUtils.parseInt(s.substring(1)) - 1;
                if (index >= 0 && index < size) {
                    ExpressionDO expressionDO = expressionDOs.get(index);
                    String expression = "(" + expressionDO.getLeft() + expressionDO.getOperation() + expressionDO.getRight() + ")";
                    Object execute = CommonUtils.expressRunner(expression, param, isPrintError);
                    if (idDebug) {
                        Map<String, Object> errorMessage = new HashMap<>();
                        errorMessage.put("expression", expression);
                        errorMessage.put("index", index + 1);
                        if (execute != null && execute instanceof Boolean && !(Boolean) execute) {
                            errorMessage.put("msg", expressionDO.getMessage());
                        }
                        errorMessage.put("result", execute);
                        debugMessage.add(errorMessage);
                    }
                    map.put("P" + (index + 1), EasyUtils.toString(execute));
                } else {
                    map.put("P" + (index + 1), s);
                }
            }
        }
        String sb = CommonUtils.stringAppend(rule.getExecutiveLogic(), "#\\d{1,2}", "${P", "}", "#");
        String expression = CommonUtils.assemblyTemplate(sb, map);
        Object execute = CommonUtils.expressRunner(expression, param, isPrintError);
        ruleResultVo.setExpression(expression);
        ruleResultVo.setDeBugInfo(debugMessage);
        ruleResultVo.setRuleParam(param);
        ruleResultVo.setResult(execute);
        return ruleResultVo;
    }

    public static void main(String[] args) throws Exception {
        Map<String, Object> map = new HashMap<>();
        map.put("P1", 3);
        map.put("P2", 3);
        Object execute = CommonUtils.expressRunner("P3+2+4", map, true);
        System.out.println(execute);
    }
}
