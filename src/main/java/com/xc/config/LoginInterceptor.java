package com.xc.config;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.xc.po.UserDO;
import com.xc.until.CommonUtils;
import com.xc.until.CookieUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * @author zhangyang
 * @date 2018/7/25
 * 登录过滤器
 */
@Slf4j
public class LoginInterceptor implements HandlerInterceptor {
    public static final String TOKEN_KEY = "token";
    public static final Map<String, UserDO> session = new HashMap<>();

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        log.error("111111111111111111111111111"+request.getRequestURI());
        String loginUrl = "http://127.0.0.1:5000/login";
        //获取cokie中的key值
        //如果没有参数，可以用cookie登录，从cookie中读取用户信息，如果存在则打印欢迎信息

        String token = CookieUtil.getValue(request, TOKEN_KEY);
        //跳转到登陆界面，同时给cokie一个key
        if (StringUtils.isEmpty(token)) {
            response.sendRedirect(loginUrl);
            return false;
        }
        UserDO userDO = session.get(token);
        //访问一次刷新redis失效时间
        if (userDO == null) {
            //表示用户登陆已经过期
            response.sendRedirect(loginUrl);
            return false;
        }
        return true;
    }


}