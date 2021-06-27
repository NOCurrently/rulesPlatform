package com.xc.until;

import com.google.common.collect.MapDifference;
import com.google.common.collect.Maps;
import com.xc.config.WebResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.CollectionUtils;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
public class CommonUtils {
    private static final Validator validator = Validation.buildDefaultValidatorFactory().getValidator();
    ;

    public static void printDifferenceMap(Map map1, Map map2, String message) {
        MapDifference<String, Object> difference = Maps.difference(map1, map2);
        Map<String, MapDifference.ValueDifference<Object>> stringValueDifferenceMap = difference.entriesDiffering();
        if (stringValueDifferenceMap != null && !stringValueDifferenceMap.isEmpty()) {
            log.warn("     {},有重复的key键  {}", message, JsonUtil.toJSONString(stringValueDifferenceMap));
        }
    }

    public static List<String> validator(Object paramValue) {
        Set<ConstraintViolation<Object>> violationSet = validator.validate(paramValue);
        if (violationSet != null && !CollectionUtils.isEmpty(violationSet)) {
            List<String> resultList = violationSet.stream().map(ConstraintViolation::getMessage).collect(Collectors.toList());
            return resultList;
        }
        return new ArrayList<>();
    }
}
