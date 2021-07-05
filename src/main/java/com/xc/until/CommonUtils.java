package com.xc.until;

import com.google.common.collect.MapDifference;
import com.google.common.collect.Maps;
import com.ql.util.express.DefaultContext;
import com.ql.util.express.ExpressRunner;
import com.xc.config.WebResponse;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.CollectionUtils;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import java.io.IOException;
import java.io.StringReader;
import java.io.StringWriter;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * @author xiaochao18
 * @date 2021-07-02 17:50
 */
@Slf4j
public class CommonUtils {
    /**
     * 校验
     */
    private static final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
    /**
     * freemarker
     */
    private final static Configuration configuration = new Configuration(Configuration.DEFAULT_INCOMPATIBLE_IMPROVEMENTS);
    /**
     * QLExpress
     * https://segmentfault.com/a/1190000039415013
     */
    private static final ExpressRunner runner = new ExpressRunner(false, false);

    static {
        configuration.setNumberFormat("#");
    }

    /**
     * 打印map中有相同KEy但是不同value的数据
     *
     * @param map1
     * @param map2
     * @param message
     */
    public static void printDifferenceMap(Map map1, Map map2, String message) {
        MapDifference<String, Object> difference = Maps.difference(map1, map2);
        Map<String, MapDifference.ValueDifference<Object>> stringValueDifferenceMap = difference.entriesDiffering();
        if (stringValueDifferenceMap != null && !stringValueDifferenceMap.isEmpty()) {
            log.warn("     {},有重复的key键  {}", message, JsonUtil.toJSONString(stringValueDifferenceMap));
        }
    }

    /**
     * 使用javax.validation进行校验
     *
     * @param paramValue
     * @return
     */
    public static List<String> validator(Object paramValue) {
        Set<ConstraintViolation<Object>> violationSet = validator.validate(paramValue);
        if (violationSet != null && !CollectionUtils.isEmpty(violationSet)) {
            List<String> resultList = violationSet.stream().map(ConstraintViolation::getMessage).collect(Collectors.toList());
            return resultList;
        }
        return new ArrayList<>();
    }

    /**
     * freemarker进行模板组装
     *
     * @param templateStr
     * @param param
     * @return
     * @throws IOException
     * @throws TemplateException
     */
    public static String assemblyTemplate(String templateStr, Map<String, String> param) {
        try {
            Template template = new Template(null, new StringReader(templateStr), configuration);
            StringWriter writer = new StringWriter();
            template.process(param, writer);
            String requestParam = writer.getBuffer().toString();
            return requestParam;
        } catch (Exception e) {
            throw new RuntimeException("模板=" + templateStr + ",param=" + param, e);
        }

    }

    public static void main(String[] args) throws Exception {
      /*  String a = "{\"#name\":\"${#name!''}\",\"age\":${age!'null'}}";

        Map<String, String> param = new HashMap<>();
        param.put("#name", "23");
        param.put("age", "\"123\"");
        String s = assemblyTemplate(a, param);
        Map<String, String> stringObjectMap = JsonUtil.parseMapString(s);
        System.out.println(JsonUtil.toJSONString(stringObjectMap));*/

       /* String s = stringAppend("1234567#135abc#45ab#abc#2", "#\\d{1,2}", "${P", "}", "#");
        System.out.println(s);*/
        Map<String, Object> param = new HashMap<>();
        param.put("#12", true);
        param.put("#13rew", false);
        Object o = expressRunner("#12&&#13rew", param);
        System.out.println(o);
    }

    /**
     * QLExpress执行表达式
     *
     * @param expression
     * @param param
     * @return
     * @throws Exception
     */
    public static Object expressRunner(String expression, Map<String, Object> param) {
        DefaultContext<String, Object> context = new DefaultContext<>();
        if (param != null) {
            context.putAll(param);
        }
        Object execute = null;
        try {
            execute = runner.execute(expression, context, null, false, false);
            return execute;
        } catch (Exception e) {
            throw new RuntimeException("表达式=" + expression + ",context=" + context, e);
        }

    }

    /**
     * 字符串匹配regex, 匹配到的前加入prefix,后加入suffix
     *
     * @param str
     * @param regex
     * @param prefix
     * @param suffix
     * @return
     */
    public static String stringAppend(String str, String regex, String prefix, String suffix, String deleteStr) {
        Pattern pattern = Pattern.compile(regex);
        Matcher mc = pattern.matcher(str);
        StringBuilder sb = new StringBuilder(str);
        int index = 0;
        boolean deleteFlag = deleteStr != null && !deleteStr.equals("");
        while (mc.find()) {
            String group = mc.group();
            if (deleteFlag) {
                group = group.replaceAll(deleteStr, "");
            }
            int start = mc.start() + index;
            int end = mc.end() + index;
            String replace = prefix + group + suffix;
            sb.replace(start, end, replace);
            index = index + replace.length() - group.length();
        }
        return sb.toString();
    }

    public static List<String> getRegexStr(String str, String regex) {
        Pattern pattern = Pattern.compile(regex);
        Matcher mc = pattern.matcher(str);
        List<String> list = new ArrayList<>();
        while (mc.find()) {
            String group = mc.group();
            list.add(group);
        }
        return list;
    }

}
