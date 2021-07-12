package com.xc.datasouce.controller;

import com.xc.config.WebResponse;
import com.xc.datasouce.service.DictService;
import com.xc.po.DictType;
import com.xc.vo.PageVo;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 数据字典类型维护
 *
 * @author dengqz
 */
@Controller
@RequestMapping("/sysDictType")
public class SysDictTypeController {

    private Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    private DictService dictService;

    /**
     * 新增数据字典类型
     *
     * @param sysDictType
     */
    @RequestMapping(value = "/addSysDictType")
    public @ResponseBody
    WebResponse addSysDictType(DictType sysDictType) {
        if (sysDictType != null && !StringUtils.isEmpty(sysDictType.getName()) && !StringUtils.isEmpty(sysDictType.getCode())) {
            //通过一切校验，添加数据字典类型
            try {
                dictService.insertType(sysDictType);
            } catch (Exception e) {
                return WebResponse.fail("2", e.getMessage());
            }

        }
        return WebResponse.succeed(null);
    }

    /**
     * 更新数据字典类型
     *
     * @param sysDictType
     * @return
     */
    @RequestMapping(value = "/updateSysDictType")
    public @ResponseBody
    WebResponse updateSysDictType(DictType sysDictType) {
        if (sysDictType != null && !StringUtils.isEmpty(sysDictType.getName())) {
            //通过一切校验，更新数据字典类型数据
            dictService.updateType(sysDictType);
            return WebResponse.succeed(null);
        }
        return WebResponse.fail("3", "修改失败");
    }

    /**
     * 删除数据字典类型
     *
     * @param id
     */
    @RequestMapping(value = "/deleteSysDictType", method = RequestMethod.POST)
    public @ResponseBody
    WebResponse deleteSysDictType(@RequestParam("id") Integer id) {
        DictType dictType = new DictType();
        dictType.setId(id);
        dictType.setStatus(0);
        int i = dictService.updateType(dictType);
        return WebResponse.succeed(i);
    }

    /**
     * 根据id查询数据字典类型
     *
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/editDictType")
    public String selectDictTypeById(@RequestParam(value = "id", required = false) Integer id, Model model) {
        DictType sysDictType = new DictType();
        if (!StringUtils.isEmpty(id)) {
            sysDictType = dictService.selectTypeId(id);
        }
        model.addAttribute("dictTypeResponse", sysDictType);
        model.addAttribute("option", "edit");
        return "/datadictionary/edit-dicttype";
    }

    /**
     * 跳转查询页面
     *
     * @param model
     * @return
     */
    @RequestMapping(value = "/dictList")
    public String formdata(Model model) {
        return "/datadictionary/dict-list";
    }

    /**
     * 条件查询
     *
     * @param name
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     */
    @RequestMapping(value = "/listSysDictType")
    public String listSysDictType(
            @RequestParam(value = "keyword", required = false) String name,
            @RequestParam(value = "currentPage", required = false) Integer pageNum,
            @RequestParam(value = "pageSize", required = false) Integer pageSize,
            Model model
    ) {
        logger.info("-----------查询数据字典类型列表");
        List<DictType> o = dictService.selectTypeByName(name, pageNum, pageSize);
        int i = dictService.selectTypeNumByName(name);
        PageVo pageVo = new PageVo();
        pageVo.setList(o);
        pageVo.setTotal(i);
        model.addAttribute("sysDictTypeList", pageVo);
        return "/datadictionary/dict-listpage";
    }

    @RequestMapping(value = "/getDictType")
    public String getDictTypeById(@RequestParam(value = "id", required = false) Integer id, Model model) {
        DictType sysDictType = new DictType();
        if (!StringUtils.isEmpty(id)) {
            sysDictType = dictService.selectTypeId(id);
        }
        model.addAttribute("dictTypeResponse", sysDictType);
        model.addAttribute("option", "edit");
        return "/datadictionary/create-dictvalue";
    }
}
