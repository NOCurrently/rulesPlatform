/*
package com.xc.datasouce.controller;

import com.oyo.cms.back.service.configmanager.SysDictValueService;
import com.oyo.cms.common.base.RopCode;
import com.oyo.cms.common.base.RopResponse;
import com.oyo.cms.common.configmanager.datadictionary.bean.SysDictValue;
import com.oyo.cms.common.configmanager.datadictionary.vo.SysDictValueVO;
import com.xc.datasouce.service.DictService;
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

*/
/**
 * 数据字典值维护
 *
 * @author dengqz
 *//*

@Controller
@RequestMapping("/sysDictValue")
public class SysDictValueController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private DictService dictService;

    @RequestMapping(value = "/listSysDictValue")
    public String listSysDictValue(
            @RequestParam(value = "id", required = false) Integer id,
            Model model
    ) {
        logger.info("-----------查询数据字典值列表");
        model.addAttribute("sysDictValueList", sysDictValueService.listSysDictValue(id));
        return "/datadictionary/dictvalue-list";
    }

    @RequestMapping("/getSysDictValue")
    public SysDictValue getSysDictValue(Integer id) {
        return sysDictValueService.getSysDictValue(id);
    }

    @RequestMapping("/addSysDictValue")
    public @ResponseBody
    RopResponse<SysDictValueVO> addSysDictValue(SysDictValue sysDictValue) {
        return sysDictValueService.addSysDictValue(sysDictValue);
    }

    @RequestMapping("/updateSysDictValue")
    public @ResponseBody
    RopResponse<SysDictValueVO> updateSysDictValue(SysDictValueVO sysDictValueVO) {

        if (sysDictValueVO != null) {
            //TODO 校验value唯一约束
            sysDictValueService.updateSysDictValue(sysDictValueVO);
            return RopResponse.success(null, "修改成功");
        }
        return RopResponse.error(RopCode.ERROR.getCode(), "修改失败");
    }

    @RequestMapping("/deleteSysDictValue")
    public @ResponseBody
    RopResponse<SysDictValueVO> deleteSysDictValue(@RequestParam("id") Integer id) {
        return sysDictValueService.deleteSysDictValue(id);
    }

    @RequestMapping(value = "/editDictValue")
    public String selectDictValueById(@RequestParam(value = "id", required = false) Integer id, Model model) {
        SysDictValue sysDictValue = new SysDictValue();
        if (id != null) {
            sysDictValue = sysDictValueService.getSysDictValue(id);
        }
        model.addAttribute("dictValueResponse", sysDictValue);
        model.addAttribute("option", "edit");
        return "/datadictionary/edit-dictvalue";
    }

    */
/**
     * 通过DictTypeCode查询对应的类型数据
     *
     * @param sysDictValueVO
     * @return
     *//*

    @RequestMapping(value = "/getDictValueByDictTypeCode")
    @ResponseBody
    public List<SysDictValueVO> getDictValueByDictTypeCode(SysDictValueVO sysDictValueVO) {
        if (sysDictValueVO != null && StringUtils.isNotEmpty(sysDictValueVO.getDictTypeCode())) {
            return sysDictValueService.getDicValueListByTypeCode(sysDictValueVO);
        }
        //防止前端循环报错
        return new ArrayList<SysDictValueVO>();
    }

    @RequestMapping(value = "/getDictValueByParam")
    @ResponseBody
    public List<SysDictValueVO> getDictValueByParam(String dictTypeCode, String remark) {
        SysDictValueVO sysDictValueVO = new SysDictValueVO();
        if (sysDictValueVO != null && StringUtils.isNotEmpty(dictTypeCode)) {
            sysDictValueVO.setDictTypeCode(dictTypeCode);
            if (StringUtils.isNotBlank(remark)) {
                sysDictValueVO.setRemark(remark);
            }
            return sysDictValueService.getDicValueListByTypeCode(sysDictValueVO);
        }
        //防止前端循环报错
        return new ArrayList<SysDictValueVO>();
    }
}
*/
