package com.xc.datasouce.controller;

import com.alibaba.fastjson.JSON;
import com.xc.config.LoginInterceptor;
import com.xc.config.WebResponse;
import com.xc.po.UserDO;
import com.xc.until.CommonUtils;
import com.xc.until.CookieUtil;
import com.xc.vo.ResourceTree;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * 登陆及初始化页面控制器
 *
 * @Author: tangwei
 * @Date: 2019-04-04 17:21
 */
@Controller
@RequestMapping("/web")
@Slf4j
public class IndexController {

    @RequestMapping("/index")
    public String index(Model model) {
        ResourceTree filterTrees = new ResourceTree();
        filterTrees.setId(1);
        filterTrees.setName("12");
        filterTrees.setIcon("fad");
        List<ResourceTree> second = new ArrayList<>();
        ResourceTree seconds = new ResourceTree();
        seconds.setId(2);
        seconds.setName("12");
        seconds.setIcon("fad");
        seconds.setUrl("/sysDictType/dictList");
        second.add(seconds);
        filterTrees.setTreeList(second);
        List<ResourceTree> resourceTreesVOVo = new ArrayList<>();
        resourceTreesVOVo.add(filterTrees);
        UserDO userDO = new UserDO();
        userDO.setUsername("xiaochao");
        model.addAttribute("ssoUser", userDO);
        model.addAttribute("resourceTrees", resourceTreesVOVo);
        return "/index";
    }

    @PostMapping("/userLogin")
    @ResponseBody
    public WebResponse userLogin(UserDO sysUserVo, HttpServletRequest request, HttpServletResponse response) {
        log.error(sysUserVo.toString());
        if (sysUserVo!=null&&sysUserVo.getUsername()!=null){
            String uuid = CommonUtils.getUUID();
            CookieUtil.writeCookie(response, LoginInterceptor.TOKEN_KEY, uuid, "/", 30 * 24 * 60 * 60 * 1000);
            LoginInterceptor.session.put(uuid,sysUserVo);
        }
        return WebResponse.succeed(null);
    }
}
