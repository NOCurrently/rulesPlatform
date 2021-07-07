package com.xc.datasouce.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

/**
 * @author zhangyang
 */
@Controller
public class FreemarkController {

    @RequestMapping("/")
    public String index(Model model) {
        //登陆成功之后拿到这个userId
        model.addAttribute("treeMenu", "");
        return "index";
    }

    @RequestMapping("/login")
    public String login(Model model) {

        return "login";
    }

    @RequestMapping("/userList")
    public String formdata(Model model) {

        return "/user/user-list";
    }

    @RequestMapping(value = "user/toEditPassword", method = {RequestMethod.GET})
    public ModelAndView toEditPassword() {
        return new ModelAndView(
                "user/modify-password");
    }
}
