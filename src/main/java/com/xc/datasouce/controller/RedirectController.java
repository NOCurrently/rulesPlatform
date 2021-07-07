package com.xc.datasouce.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

/**
 * 重定向控制器
 *
 * @Author: tangwei
 * @Date: 2019-05-08 17:14
 */
@Controller
@RequestMapping("/re")
public class RedirectController {

    /**
     * 重定向
     *
     * @param param
     * @param model
     * @return
     */
    @RequestMapping("/redirect")
    public String redirect(String param, Model model)  {
        byte[] decode = Base64.getUrlDecoder().decode(param.getBytes());
        String url = new String(decode, StandardCharsets.UTF_8);

        model.addAttribute("url", url);
        return "/redirect";
    }

}
