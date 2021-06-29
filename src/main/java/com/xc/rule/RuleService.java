package com.xc.rule;

import com.ql.util.express.DefaultContext;
import com.ql.util.express.ExpressRunner;
import com.xc.datasouce.manage.ProcessSegmentManage;
import com.xc.po.ActionDO;
import com.xc.po.ExpressionDO;
import com.xc.po.Rule;
import com.xc.until.CommonUtils;
import com.xc.until.JsonUtil;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.logging.impl.Log4JLogger;
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
    //https://segmentfault.com/a/1190000039415013
    private static final ExpressRunner runner = new ExpressRunner(false, false);
    @Autowired
    private ProcessSegmentManage dataSourceManage;

    public Object execute(Rule rule, Map<String, Object> param, boolean isPrintError) throws Exception {
        Integer aggregatId = rule.getAggregatId();
        Map<String, Object> objectMap = new HashMap<>(param);
        if (aggregatId != null) {
            Map<String, Object> dataSourceRut = dataSourceManage.executeProcess(aggregatId, param);
            objectMap.putAll(dataSourceRut);
        }
        System.out.println(rule);
        String expression = getExpression(rule, objectMap);
        System.out.println(expression);
        DefaultContext<String, Object> context = new DefaultContext<>();
        ArrayList<String> errorList = null;
        if (isPrintError) {
            errorList = new ArrayList<>();
        }
        Object execute = runner.execute(expression, context, errorList, false, false);
        if (errorList != null && !errorList.isEmpty()) {
            log.error("errorList {}", errorList);
        }
        System.out.println(execute);
        if (execute!=null){
            System.out.println(execute.getClass());
        }
        String expectReturnClassStr = rule.getExpectReturnClass();
        Class expectReturnClass = null;
        if (StringUtils.isNotBlank(expectReturnClassStr)) {
            expectReturnClass = Class.forName(expectReturnClassStr);
        }
        if (expectReturnClass != null && (execute == null || expectReturnClass != execute.getClass())) {
            log.warn("Expected return does not match actual return;  ExpectedClass={}, actual={}, actualClass={}", expectReturnClass, JsonUtil.toJSONString(execute), execute.getClass());
        }

        String actionJsonList = rule.getActionJsonList();
        List<ActionDO> actionDOS = JsonUtil.parseArray(actionJsonList, ActionDO.class);
        if (actionDOS != null) {
            for (ActionDO actionDO : actionDOS) {
                log.info("ActionDO {}", actionDO);
            }
        }
        return execute;
    }

    public static void main(String[] args) throws Exception {
      /*  DefaultContext<String, Object> context = new DefaultContext<>();
        context.put("a", 1);
        context.put("bc", 432);
        ArrayList<String> errorList = new ArrayList<>();
        Log4JLogger aLog = new Log4JLogger();
        Object execute = runner.execute("a+b", context, errorList, false, false, aLog);
        System.out.println(execute);
        log.error("errorList {}" + errorList);*/
        /*String executiveLogic = "1&&2";
        Pattern pattern = Pattern.compile("\\d{1,3}");
        Matcher mc = pattern.matcher(executiveLogic);
        StringBuilder sb = new StringBuilder("1&&2");
        int index=0;
        while (mc.find()) {
            String group = mc.group();
            int i = executiveLogic.indexOf(group);
            sb.insert(i+index,"${");
            index=index+2;
            sb.insert(i+group.length()+index,"}");
            index=index+1;
        }
        System.out.println(sb);*/
        Map<String, String> map = new HashMap<>();
        map.put("ss11","(2>1)");
        map.put("ssss22","(100<100)");
        String s = CommonUtils.assemblyTemplate("${ss11}&&${ssss22}", map);
        System.out.println(s);
        System.out.println(boolean.class.getName());
    }

    private String getExpression(Rule rule, Map<String, Object> param) throws IOException, TemplateException {
        String expressionJsonList = rule.getExpressionJsonList();
        List<ExpressionDO> expressionDOs = JsonUtil.parseArray(expressionJsonList, ExpressionDO.class);
        Map<String, String> map = new HashMap<>();
        for (int i = 0; i < expressionDOs.size(); i++) {
            ExpressionDO expressionDO = expressionDOs.get(i);
            map.put("P"+String.valueOf(i+1), "(" + param.get(expressionDO.getLeft()) + expressionDO.getOperation() + expressionDO.getRight() + ")");
        }
        String executiveLogic = rule.getExecutiveLogic();
        Pattern pattern = Pattern.compile("\\d{1,3}");
        Matcher mc = pattern.matcher(executiveLogic);
        StringBuilder sb = new StringBuilder(executiveLogic);
        int index=0;
        while (mc.find()) {
            String group = mc.group();
            int i = executiveLogic.indexOf(group);
            sb.insert(i+index,"${P");
            index=index+3;
            sb.insert(i+group.length()+index,"}");
            index=index+1;
        }
        return CommonUtils.assemblyTemplate(sb.toString(), map);
    }
}
