package com.datasource.until;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
public abstract class JsonUtil {

    private final static ObjectMapper OBJECT_MAPPER = new ObjectMapper();

    static {
        // 美化输出
        //mapper.enable(SerializationFeature.INDENT_OUTPUT);
// 允许序列化空的POJO类
// （否则会抛出异常）
        OBJECT_MAPPER.setDateFormat(new SimpleDateFormat("yyyy-MM-dd"));
        OBJECT_MAPPER.setSerializationInclusion(JsonInclude.Include.NON_NULL);
        OBJECT_MAPPER.configure(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES, false);
        OBJECT_MAPPER.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
        // 允许出现特殊字符和转义符
        OBJECT_MAPPER.configure(JsonParser.Feature.ALLOW_UNQUOTED_CONTROL_CHARS, true);
        // 允许出现单引号
        //objectMapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        // 字段保留，将null值转为""
		/*objectMapper.getSerializerProvider().setNullValueSerializer(new JsonSerializer<Object>()
		{
			@Override
			public void serialize(Object o, JsonGenerator jsonGenerator,
								  SerializerProvider serializerProvider)
					throws IOException
			{
				jsonGenerator.writeString("");
			}
		});*/
    }

    /**
     * 将JSON格式字符串转换成对象
     */
    public static <T> T json2Object(String jsonString, Class<T> clazz) {
        if (StringUtils.isBlank(jsonString)) {
            return null;
        }
        try {
            return OBJECT_MAPPER.readValue(jsonString, clazz);
        } catch (IOException e) {
            log.error("parse json string error:" + jsonString, e);
        }
        return null;
    }

    /**
     * 将json字符串转换为Map
     *
     * @param json 需要转换为Map的json字符串 {}开头结尾的
     * @return 转换后的map 如果转换失败返回null
     */
    public static Map<String, Object> json2Map(String json) {
        try {
            if (StringUtils.isBlank(json)) {
                return new HashMap<>();
            }
            return OBJECT_MAPPER.readValue(json, Map.class);
        } catch (IOException e) {
            log.error("json2Map(), 出错的json内容为：" + json + " ,IOException: ", e);
        }
        return new HashMap<>();
    }

    /**
     * 将JSON格式字符串转换成对象
     */
    public static <T> T json2Object(String jsonString, TypeReference<T> typeReference) {
        if (StringUtils.isBlank(jsonString)) {
            return null;
        }
        try {
            return (T) OBJECT_MAPPER.readValue(jsonString, typeReference);
        } catch (IOException e) {
            log.error("parse json string error:" + jsonString, e);
        }
        return null;
    }

    /**
     * 将对象转换成JSON格式
     */
    public static String write2JsonStr(Object object) {
        try {
            return OBJECT_MAPPER.writeValueAsString(object);
        } catch (IOException e) {
            log.error("write to json string error:" + object, e);
        }
        return null;
    }


    public static Map<String, String> json2MapString(String str) {
        if (StringUtils.isEmpty(str)) {
            return new HashMap<>();
        }
        try {
            //convert JSON string to Map
            Map<String, String> map = OBJECT_MAPPER.readValue(str, new TypeReference<HashMap<String, String>>() {
            });
            return map;
        } catch (Exception e) {
            log.error("get string map from Json String error.", e);
        }
        return new HashMap<>();
    }

    /**
     * 将json数组转换为List<Map<String,Object>> json数组格式[{},{}]
     *
     * @return 转换后的列表   如果转换失败返回null
     * @author zhaoyunxiao
     * //     * @param  需要转换的json数组
     */
    public static List<Map<String, Object>> jsonArray2List(String jsonArray) {
        if (StringUtils.isEmpty(jsonArray)) {
            return new ArrayList<>();
        }
        try {
            return OBJECT_MAPPER.readValue(jsonArray, List.class);
        } catch (IOException e) {
            log.error("jsonArray2List() exception", e);
        }
        return new ArrayList<>();
    }


    public final static boolean isJSONString(String jsonString) {
        try {
            if (jsonString == null) {
                return false;
            }
            if ((jsonString.startsWith("{") && jsonString.endsWith("}")) || (jsonString.startsWith("[") && jsonString.endsWith("]"))) {
                OBJECT_MAPPER.readTree(jsonString);
                return true;
            }
        } catch (IOException e) {
            log.error("jsonArray2List() exception", e);
        }
        return false;
    }

}
