package com.xc.until;



import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

/**
 * @author changliang time:2013-3-27 19:48:00
 */
public class EasyUtils {
    private final static Log log = LogFactory.getLog(EasyUtils.class);

    /**
     * 默认返回值为入参defaultValue
     *
     * @param origin       要进行转型的对象
     * @param defaultValue 默认值，有异常情况时返回的值
     * @return 转型后的int值
     * @author changliang
     */
    public static int parseInt(Object origin, int defaultValue) {
        if (origin == null) {
            return defaultValue;
        }
        if (origin instanceof Integer) {
            return (Integer) origin;
        }
        String s = origin.toString();
        try {
            return Integer.parseInt(s);
        } catch (Exception e) {
            log.error("转型异常，参数：" + s);
        }
        return defaultValue;
    }

    /**
     * 调用此方法时，默认返回值为0
     *
     * @param origin 要进行转型的对象
     * @return 转型后的int值
     * @author changliang
     */
    public static int parseInt(Object origin) {
        return parseInt(origin, -1);
    }

    /**
     * 默认返回值为入参defaultValue
     *
     * @param origin       要进行转型的对象
     * @param defaultValue 默认值，有异常情况时返回的值
     * @return 转型后的long值
     * @author maowenhui
     */
    public static long parseLong(Object origin, long defaultValue) {
        if (origin == null) {
            return defaultValue;
        }
        if (origin instanceof Integer) {
            return (Integer) origin;
        }
        String s = origin.toString();
        try {
            return Long.parseLong(s);
        } catch (Exception e) {
            log.error("转型异常，参数：" + s);
        }
        return defaultValue;
    }

    /**
     * 调用此方法时，默认返回值为0
     *
     * @param origin 要进行转型的对象
     * @return 转型后的long值
     * @author maowenhui
     */
    public static long parseLong(Object origin) {
        return parseLong(origin, -1);
    }

    public static double parseDouble(Object origin) {
        return parseDouble(origin, -1);
    }

    public static double parseDouble(Object origin, double defaultValue) {
        if (origin == null) {
            return defaultValue;
        }
        if (origin instanceof Integer) {
            return (Integer) origin;
        }
        String s = origin.toString();
        try {
            return Double.parseDouble(s);
        } catch (Exception e) {
            log.error("转型异常，参数：" + s);
        }
        return defaultValue;
    }


    /**
     * 调用此方法时，默认返回值为""
     *
     * @param o 要进行转型的对象
     * @return 转型后的String值
     * @author liujinfeng
     */
    public static String toString(Object o) {
        return toString(o, "");
    }

    /**
     * 默认返回值为入参defaultValue
     *
     * @param defaultValue 默认返回值
     * @return 转型后的String值
     * @author liujinfeng
     */
    public static String toString(Object origin, String defaultValue) {
        if (origin == null) {
            return defaultValue;
        }
        String temp = origin.toString();
        return temp;
    }

}

