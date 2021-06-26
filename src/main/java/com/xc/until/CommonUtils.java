package com.xc.until;

import com.google.common.collect.MapDifference;
import com.google.common.collect.Maps;
import lombok.extern.slf4j.Slf4j;

import java.util.Map;

@Slf4j
public class CommonUtils {

    public static void printDifferenceMap(Map map1,Map map2,String message){
        MapDifference<String, Object> difference = Maps.difference(map1, map2);
        Map<String, MapDifference.ValueDifference<Object>> stringValueDifferenceMap = difference.entriesDiffering();
        if (stringValueDifferenceMap != null) {
            log.warn("{},有重复的key键  {}" , message,JsonUtil.toJSONString(stringValueDifferenceMap));
        }
    }
}
