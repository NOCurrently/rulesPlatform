package com.xc.until;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.parser.ParserConfig;
import com.alibaba.fastjson.serializer.JSONLibDataFormatSerializer;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializerFeature;

import java.util.List;
import java.util.Map;

/**
 * 阿里fastjson
 *
 * @author nachuan
 * @create 2019-04-28 18:10
 */
public class MyFastJsonUtils {

    private static final SerializeConfig SERIALIZE_CONFIG;

    static {
        SERIALIZE_CONFIG = new SerializeConfig();
        // 使用和json-lib兼容的日期输出格式
        SERIALIZE_CONFIG.put(java.util.Date.class, new JSONLibDataFormatSerializer());
        // 使用和json-lib兼容的日期输出格式
        SERIALIZE_CONFIG.put(java.sql.Date.class, new JSONLibDataFormatSerializer());
    }

    /**
     * 序列化
     */
    private static final SerializerFeature[] features = {
            SerializerFeature.SkipTransientField,
            SerializerFeature.DisableCircularReferenceDetect
            //SerializerFeature.WriteMapNullValue,
            // list字段如果为null，输出为[]，而不是null
            //SerializerFeature.WriteNullListAsEmpty,
            // 数值字段如果为null，输出为0，而不是null
//            SerializerFeature.WriteNullNumberAsZero,
            // Boolean字段如果为null，输出为false，而不是null
            //SerializerFeature.WriteNullBooleanAsFalse,
            // 字符类型字段如果为null，输出为""，而不是null
            //SerializerFeature.WriteNullStringAsEmpty
    };


    /**
     * 类转json字符串 时间复杂化处理,并且会打印空属性
     *
     * @param object
     * @return
     */
    public static String toJSONString(Object object) {
        return JSON.toJSONString(object, SERIALIZE_CONFIG, features);
    }

    /**
     * json字符串转为object类
     *
     * @param text
     * @return
     */
    public static Object parse(String text) {
        return JSON.parse(text);
    }

    /**
     * json字符串转bean
     *
     * @param text
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> T parseObject(String text, Class<T> clazz) {
        return JSON.parseObject(text, clazz);
    }



    /**
     * json字符串转为 对象集合
     *
     * @param text
     * @param clazz
     * @param <T>
     * @return
     */
    public static <T> List<T> parseArray(String text, Class<T> clazz) {
        return JSON.parseArray(text, clazz);
    }



}