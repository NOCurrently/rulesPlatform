package com.xc.until;

import org.apache.commons.lang3.StringUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class CookieUtil {
    public static String getValue(HttpServletRequest request, String key) {
        if (StringUtils.isBlank(key)) {
            return null;
        }
        Cookie[] cookies = request.getCookies();
        if (cookies != null && cookies.length > 0) {
            for (Cookie cookie : cookies) {
                if (key.equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    public static void writeCookie(HttpServletResponse response, String key, String value, String path, int maxAge) {
        Cookie cookie = new Cookie(key, value);
        //设置cookie时间为30天
        cookie.setPath(path);
        cookie.setMaxAge(maxAge);
        response.addCookie(cookie);
    }
}
