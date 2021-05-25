package com.xc.until;


import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.annotate.JsonSerialize;
import org.codehaus.jackson.type.TypeReference;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@SuppressWarnings({ "deprecation", "unchecked" })
public class JsonUtil {

	private final static Logger LOG = Logger.getLogger(JsonUtil.class.getName());
	private final static ObjectMapper OBJECT_MAPPER = new ObjectMapper();

	static {
		OBJECT_MAPPER.getSerializationConfig().setSerializationInclusion(JsonSerialize.Inclusion.NON_NULL);
		OBJECT_MAPPER.getDeserializationConfig().set(org.codehaus.jackson.map.DeserializationConfig.Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		OBJECT_MAPPER.getSerializationConfig().setDateFormat(df);
		OBJECT_MAPPER.getDeserializationConfig().setDateFormat(df);
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
			LOG.error("parse json string error:" + jsonString, e);
		}
		return null;
	}

    /**
     * 将json字符串转换为Map
     * @param  json 需要转换为Map的json字符串 {}开头结尾的
     * @return 转换后的map 如果转换失败返回null
     * */
	public static Map<String,Object> json2Map(String json){
    	try {
    		if(StringUtils.isBlank(json)) {
    			return new HashMap<>() ;
    		}    		
			return OBJECT_MAPPER.readValue(json,Map.class);
		} catch (IOException e) {
			LOG.error("json2Map(), 出错的json内容为："  + " ,IOException: " + e.getMessage());
		}
   	    return new HashMap<>() ;
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
			LOG.error("parse json string error:" + jsonString, e);
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
			LOG.error("write to json string error:" + object, e);
		}
		return null;
	}
	
	
	public static Map<String, String> json2MapString(String str) {
		if(StringUtils.isEmpty(str)) {
			return null;
		}

		Map<String,String> map;
		try {
			//convert JSON string to Map
			map = OBJECT_MAPPER.readValue(str,
			    new TypeReference<HashMap<String,String>>(){});

		} catch (Exception e) {
			LOG.error("get string map from Json String error.",e);
			map = null;
		}

		return map;
	}

	 /**
     * 将json数组转换为List<Map<String,Object>> json数组格式[{},{}]
     * @author zhaoyunxiao
//     * @param  需要转换的json数组
     * @return 转换后的列表   如果转换失败返回null
     * */
	public static List<Map<String,Object>> jsonArray2List(String jsonArray){
        try {
			return OBJECT_MAPPER.readValue(jsonArray, List.class);
		} catch (JsonParseException | JsonMappingException e) {
			LOG.error("jsonArray2List() exception, 异常字符串: " + jsonArray, e);
		} catch (IOException e) {
			LOG.error("jsonArray2List() exception",e);
		}
        return new ArrayList<>();
    }
	private JsonUtil() {
	}

	public static ObjectMapper getMapper() {
		return OBJECT_MAPPER;
	}

}
