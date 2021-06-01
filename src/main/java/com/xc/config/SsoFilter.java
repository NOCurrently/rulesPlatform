package com.xc.config;

import com.google.common.collect.Sets;
import com.xc.po.User;
import com.xc.until.JsonUtil;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

/**
 * SSO登陆过滤器
 *
 * @Author: tangwei
 * @Date: 2019-04-09 17:51
 */
@Slf4j
public class SsoFilter extends HttpServlet implements Filter {

    public SsoFilter() {
    }

    public static final ThreadLocal<User> sThreadLocal = new ThreadLocal<>();
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {


        try {
            HttpServletRequest req = (HttpServletRequest) request;
            HttpServletResponse res = (HttpServletResponse) response;
            String auth = req.getHeader("auth");
            if (StringUtils.isNotBlank(auth)) {
                User user = new User();
                user.setName(auth);
                sThreadLocal.set(user);
                chain.doFilter(request, response);
                return;
            }else{
                String requestURI = req.getRequestURI();
                if (requestURI.startsWith("/xiaochao")) {
                    forbiddenResponse(res, WebResponse.fail("444", "没登录!"));
                }
            }
            chain.doFilter(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }finally {
            sThreadLocal.remove();
        }
    }


    private void forbiddenResponse(HttpServletResponse response, WebResponse ropResponse) throws IOException {
        response.setStatus(200);
        response.setContentType("application/json;charset=UTF-8");
        response.getWriter().println(JsonUtil.write2JsonStr(ropResponse));

    }


}

