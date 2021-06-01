package com.xc.until;

import com.xc.config.SsoFilter;
import com.xc.po.User;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
public class SsoUtil {

    public static String getUserName(){
        User user = SsoFilter.sThreadLocal.get();
        return user.getName();
    }
}
