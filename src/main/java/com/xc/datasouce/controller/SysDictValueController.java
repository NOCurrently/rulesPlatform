package com.xc.datasouce.controller;

import com.xc.config.WebResponse;
import com.xc.datasouce.service.DictService;
import com.xc.po.DictValue;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/sysDictValue")
public class SysDictValueController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private DictService dictService;

    @RequestMapping(value = "/listSysDictValue")
    public String listSysDictValue(
            @RequestParam(value = "id", required = false) Integer id, @RequestParam(value = "code", required = false) String code,
            Model model
    ) {
        logger.info("-----------查询数据字典值列表");
        if (id != null) {
            List<DictValue> o = dictService.selectValueByTypeId(id);
            model.addAttribute("sysDictValueList", o);
        } else {
            List<DictValue> o = dictService.selectValueByTypeCode(code);
            model.addAttribute("sysDictValueList", o);
        }

        return "/datadictionary/dictvalue-list";
    }

   /* @RequestMapping("/getSysDictValue")
    public DictValue getSysDictValue(Integer id) {
        return dictService.selecByValueId(id);
    }*/

    @RequestMapping("/addSysDictValue")
    public @ResponseBody
    WebResponse addSysDictValue(DictValue sysDictValue) {
        int i = dictService.insertValue(sysDictValue);
        return WebResponse.succeed(i);
    }

    @RequestMapping("/updateSysDictValue")
    public @ResponseBody
    WebResponse updateSysDictValue(DictValue sysDictValueVO) {

        if (sysDictValueVO != null) {
            //TODO 校验value唯一约束
            dictService.updateValue(sysDictValueVO);
        }
        return WebResponse.succeed(null);
    }

    @RequestMapping("/deleteSysDictValue")
    public @ResponseBody
    WebResponse deleteSysDictValue(@RequestParam("id") Integer id) {
        DictValue sysDictValueVO = new DictValue();
        sysDictValueVO.setId(id);
        sysDictValueVO.setStatus(0);
        dictService.updateValue(sysDictValueVO);
        return WebResponse.succeed(null);
    }

    @RequestMapping(value = "/editDictValue")
    public String selectDictValueById(@RequestParam(value = "id", required = false) Integer id, Model model) {
        if (id != null) {
            DictValue sysDictValue = dictService.selecByValueId(id);
            model.addAttribute("dictValueResponse", sysDictValue);
        }
        model.addAttribute("option", "edit");
        return "/datadictionary/edit-dictvalue";
    }

    @RequestMapping(value = "/getDictValueByDictTypeCode")
    @ResponseBody
    public List<DictValue> getDictValueByDictTypeCode(String code) {
        if (StringUtils.isNotEmpty(code)) {
            return dictService.selectValueByTypeCode(code);
        }
        //防止前端循环报错
        return new ArrayList<>();
    }

}
