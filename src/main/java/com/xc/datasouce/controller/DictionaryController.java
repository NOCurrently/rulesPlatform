/*
package com.xc.datasouce.controller;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.oyo.cms.console.common.enums.ResponseCodeEnum;
import com.oyo.cms.console.common.response.RopResponse;
import com.oyo.cms.console.common.util.BeanUtils;
import com.oyo.cms.console.common.util.VersionUtil;
import com.oyo.cms.console.integration.offlinead.DictionaryService;
import com.oyo.cms.console.web.controller.offlinead.vo.DictTypeVo;
import com.oyo.cms.console.web.controller.offlinead.vo.DictValueVo;
import com.oyo.cms.offlinead.dto.req.DictTypeParamDto;
import com.oyo.cms.offlinead.dto.req.DictTypeReqDto;
import com.oyo.cms.offlinead.dto.req.DictValueReqDto;
import com.oyo.cms.offlinead.dto.resp.BaseCmsRespDto;
import com.oyo.cms.offlinead.dto.resp.DictRespDto;
import com.oyo.cms.offlinead.dto.resp.DictTypeRespDto;
import com.oyo.cms.offlinead.dto.resp.DictValueRespDto;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import rdfa.user.auth.client.auth.core.user.SsoUser;
import rdfa.user.auth.client.auth.util.SsoUtil;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.TreeSet;

*/
/**
 * 字典管理
 *
 * @author tangwei
 * @date 2019-04-16
 *//*

@Slf4j
@Controller
@RequestMapping("/web/dict")
public class DictionaryController {

    @Autowired
    private DictionaryService dictionaryService;

    */
/**
     * 跳转查询页面
     *
     * @return
     *//*

    @RequestMapping(value = "/dictList")
    public String dictList() {
        return "/datadictionary/dict-list";
    }

    */
/**
     * 条件查询
     *
     * @param name
     * @param pageNum
     * @param pageSize
     * @param model
     * @return
     *//*

    @RequestMapping(value = "/listSysDictType")
    public String listSysDictType(
            @RequestParam(value = "keyword", required = false) String name,
            @RequestParam(value = "currentPage", required = false) Integer pageNum,
            @RequestParam(value = "pageSize", required = false) Integer pageSize,
            Model model
    ) {
        log.info("-----------查询数据字典类型列表");
        DictTypeParamDto dictTypeParamDto = new DictTypeParamDto();
        dictTypeParamDto.setName(name);
        dictTypeParamDto.setPageNum(pageNum);
        dictTypeParamDto.setPageSize(pageSize);
        PageInfo<DictTypeRespDto> pageInfo = dictionaryService.listDictTypes(dictTypeParamDto);
        model.addAttribute("sysDictTypeList", pageInfo);
        return "/datadictionary/dict-listpage";
    }

    */
/**
     * 新增数据字典类型
     *
     * @param dictTypeVo
     *//*

    @RequestMapping(value = "/addSysDictType")
    public @ResponseBody
    RopResponse<DictTypeVo> addSysDictType(DictTypeVo dictTypeVo) {
        if (dictTypeVo != null && !StringUtils.isEmpty(dictTypeVo.getName()) && !StringUtils.isEmpty(dictTypeVo.getCode())) {
            DictTypeParamDto dictTypeParamDto = new DictTypeParamDto();
            dictTypeParamDto.setCode(dictTypeVo.getCode());
            dictTypeParamDto.setDeleteFlag(0);
            List<DictTypeRespDto> dictTypeRespDtos = dictionaryService.selectByCondition(dictTypeParamDto);
            if (dictTypeRespDtos != null && dictTypeRespDtos.size() > 0) {
                return RopResponse.error(ResponseCodeEnum.DICT_CODE_ALREADY_EXISTS.getCode(), ResponseCodeEnum.DICT_CODE_ALREADY_EXISTS.getMessage());
            }
            DictTypeReqDto dictTypeReqDto = new DictTypeReqDto();
            BeanUtils.copyProperties(dictTypeVo, dictTypeReqDto);
            SsoUser ssoUser = SsoUtil.currentUser();
            String userName = ssoUser.getUserName();
            dictTypeReqDto.setCreateBy(userName);
            dictTypeReqDto.setUpdateBy(userName);
            dictTypeReqDto.setDeleteFlag(0);
            dictTypeReqDto.setOnlineFlag(1);
            dictionaryService.insertType(dictTypeReqDto);
            return RopResponse.success(ResponseCodeEnum.INSERT_SUCCESS.getMessage(), null);
        }
        return RopResponse.error(ResponseCodeEnum.INSERT_ERROR.getCode(), ResponseCodeEnum.INSERT_ERROR.getMessage());
    }

    */
/**
     * 根据id查询数据字典类型
     *
     * @param id
     * @param model
     * @return
     *//*

    @RequestMapping(value = "/editDictType")
    public String selectDictTypeById(@RequestParam(value = "id", required = false) Integer id, Model model) {
        DictTypeVo dictTypeVo = new DictTypeVo();
        if (!StringUtils.isEmpty(id)) {
            DictTypeParamDto dictTypeParamDto = new DictTypeParamDto();
            dictTypeParamDto.setId(id);
            List<DictTypeRespDto> dictTypeRespDtos = dictionaryService.selectByCondition(dictTypeParamDto);
            DictTypeRespDto dictTypeRespDto = dictTypeRespDtos.get(0);
            BeanUtils.copyProperties(dictTypeRespDto, dictTypeVo);
        }
        model.addAttribute("dictTypeResponse", dictTypeVo);
        model.addAttribute("option", "edit");
        return "/datadictionary/edit-dicttype";
    }

    */
/**
     * 更新数据字典类型
     *
     * @param dictTypeVo
     * @return
     *//*

    @RequestMapping(value = "/updateSysDictType")
    public @ResponseBody
    RopResponse<DictTypeVo> updateSysDictType(DictTypeVo dictTypeVo) {
        if (dictTypeVo != null && !StringUtils.isEmpty(dictTypeVo.getName()) && !StringUtils.isEmpty(dictTypeVo.getCode())) {
            DictTypeParamDto dictTypeParamDto = new DictTypeParamDto();
            dictTypeParamDto.setCode(dictTypeVo.getCode());
            dictTypeParamDto.setDeleteFlag(0);
            List<DictTypeRespDto> dictTypeRespDtos = dictionaryService.selectByCondition(dictTypeParamDto);
            for (DictTypeRespDto dictTypeRespDto : dictTypeRespDtos) {
                if (dictTypeRespDto.getCode().equals(dictTypeVo.getCode()) && dictTypeRespDto.getId().longValue() != dictTypeVo.getId().longValue()) {
                    return RopResponse.error(ResponseCodeEnum.DICT_CODE_ALREADY_EXISTS.getCode(), ResponseCodeEnum.DICT_CODE_ALREADY_EXISTS.getMessage());
                }
            }
            //通过一切校验，更新数据字典类型数据
            DictTypeReqDto dictTypeReqDto = new DictTypeReqDto();
            BeanUtils.copyProperties(dictTypeVo, dictTypeReqDto);
            SsoUser ssoUser = SsoUtil.currentUser();
            String userName = ssoUser.getUserName();
            dictTypeReqDto.setUpdateBy(userName);
            dictTypeReqDto.setDeleteFlag(0);
            dictTypeReqDto.setOnlineFlag(1);
            dictionaryService.updateType(dictTypeReqDto);
            return RopResponse.success(ResponseCodeEnum.UPDATE_SUCCESS.getMessage(), null);
        }
        return RopResponse.error(ResponseCodeEnum.UPDATE_ERROR.getCode(), ResponseCodeEnum.UPDATE_ERROR.getMessage());
    }


    */
/**
     * 查询广告位置、广告类型、使用状态
     *
     * @return
     *//*

    @GetMapping("/queryDictValuesByDictTypes")
    @ResponseBody
    public RopResponse<Map<String, List<DictRespDto>>> queryDictValuesByDictTypes() {
        List<String> codes = Lists.newArrayList("ad_location", "ad_type", "ad_status");
        Map<String, List<DictRespDto>> map = dictionaryService.selectByTypeCodes(codes);
        return RopResponse.success(map);
    }
    */
/**
     * 查询广告位置、广告类型、使用状态
     *
     * @return
     *//*

    @GetMapping("/findDict")
    @ResponseBody
    public RopResponse< List<DictRespDto>> findDict(String dictType ) {
    	if (dictType==null) {
    		RopResponse.error("1003", "dictType is null");
		}
    	List<String> codes = Lists.newArrayList(dictType);
    	Map<String, List<DictRespDto>> map = dictionaryService.selectByTypeCodes(codes);
    	
    	List<DictRespDto> data = map.get(dictType);
		return RopResponse.success(data);
    }


    */
/**
     * 列表展示字典值
     *
     * @param id
     * @param model
     * @return
     *//*

    @RequestMapping(value = "/listSysDictValue")
    public String listSysDictValue(@RequestParam(value = "id", required = false) Integer id, Model model) {
        DictTypeParamDto dictTypeParamDto = new DictTypeParamDto();
        dictTypeParamDto.setId(id);
        List<DictTypeRespDto> dictTypeRespDtos = dictionaryService.selectByCondition(dictTypeParamDto);
        DictTypeRespDto dictTypeRespDto = dictTypeRespDtos.get(0);
        List<DictValueRespDto> dictValueRespDtos = dictionaryService.selectDictValuesByTypeId(id);
        List<DictValueVo> dictValueVos = new ArrayList<>();
        BeanUtils.copyList(dictValueRespDtos, dictValueVos, DictValueVo.class);
        for (DictValueVo dictValueVo : dictValueVos) {
            dictValueVo.setTypeName(dictTypeRespDto.getName());
        }
        model.addAttribute("sysDictValueList", dictValueVos);
        return "/datadictionary/dictvalue-list";
    }

    */
/**
     * 根据id获取字典类型
     *
     * @param id
     * @param model
     * @return
     *//*

    @RequestMapping(value = "/getDictType")
    public String getDictTypeById(@RequestParam(value = "id", required = false) Integer id, Model model) {
        DictTypeParamDto dictTypeParamDto = new DictTypeParamDto();
        DictTypeRespDto dictTypeRespDto = null;
        if (!StringUtils.isEmpty(id)) {
            dictTypeParamDto.setId(id);
            List<DictTypeRespDto> dictTypeRespDtos = dictionaryService.selectByCondition(dictTypeParamDto);
            dictTypeRespDto = dictTypeRespDtos.get(0);
        }
        model.addAttribute("dictTypeResponse", dictTypeRespDto);
        model.addAttribute("option", "edit");
        return "/datadictionary/create-dictvalue";
    }

    */
/**
     * 添加字典值
     *
     * @param dictValueVo
     * @return
     *//*

    @RequestMapping("/addSysDictValue")
    public @ResponseBody
    RopResponse<DictValueVo> addSysDictValue(DictValueVo dictValueVo) {
        DictValueReqDto dictValueReqDto = new DictValueReqDto();
        BeanUtils.copyProperties(dictValueVo, dictValueReqDto);
        SsoUser ssoUser = SsoUtil.currentUser();
        String userName = ssoUser.getUserName();
        dictValueReqDto.setCreateBy(userName);
        dictValueReqDto.setUpdateBy(userName);
        dictValueReqDto.setDeleteFlag(0);
        dictValueReqDto.setOnlineFlag(1);
        BaseCmsRespDto baseCmsRespDto = dictionaryService.insertValue(dictValueReqDto);
        if (baseCmsRespDto.isSuccess()) {
            return RopResponse.success(ResponseCodeEnum.INSERT_SUCCESS.getMessage(), null);
        } else {
            return RopResponse.error(ResponseCodeEnum.INSERT_ERROR.getCode(), ResponseCodeEnum.INSERT_ERROR.getMessage());
        }
    }

    */
/**
     * 编辑字典值
     *
     * @param id
     * @param model
     * @return
     *//*

    @RequestMapping(value = "/editDictValue")
    public String selectDictValueById(@RequestParam(value = "id", required = false) Integer id, Model model) {
        DictValueRespDto dictValueRespDto = null;
        if (id != null) {
            dictValueRespDto = dictionaryService.selectDictValueById(id);
        }
        model.addAttribute("dictValueResponse", dictValueRespDto);
        model.addAttribute("option", "edit");
        return "/datadictionary/edit-dictvalue";
    }

    */
/**
     * 更新字典值
     *
     * @param dictValueReqDto
     * @return
     *//*

    @RequestMapping("/updateSysDictValue")
    @ResponseBody
    public RopResponse<DictValueVo> updateSysDictValue(DictValueReqDto dictValueReqDto) {
        if (dictValueReqDto != null) {
            dictionaryService.updateValue(dictValueReqDto);
            return RopResponse.success(ResponseCodeEnum.UPDATE_SUCCESS.getMessage(), null);
        }
        return RopResponse.error(ResponseCodeEnum.UPDATE_ERROR.getCode(), ResponseCodeEnum.UPDATE_ERROR.getMessage());
    }

    */
/**
     *
     * 通过DictTypeCode查询对应的类型数据
     * @param sysDictValueVO
     * @return
     *//*

    @RequestMapping(value="/getDictValueByDictTypeCode")
    @ResponseBody
    public List<DictValueRespDto> getDictValueByDictTypeCode(DictValueReqDto sysDictValueVO) {
        if(sysDictValueVO != null && org.apache.commons.lang3.StringUtils.isNotEmpty(sysDictValueVO.getCode())) {
            List<DictValueRespDto> respList = new ArrayList<>();
            if("target_version".equals(sysDictValueVO.getCode())){
                List<DictValueRespDto> list = dictionaryService.getDicValueListByTypeCode(sysDictValueVO);
                // 按版本号从大到小排序
                sortByVersion(respList, list);
            }else{
                respList = dictionaryService.getDicValueListByTypeCode(sysDictValueVO);
            }
            return respList;
        }
        //防止前端循环报错
        return new ArrayList<DictValueRespDto>();
    }

    */
/**
     * 按版本号从大到小排序,排序前list，排序后respList
     * @auther: 张霞文
     * @date: 2019/9/24
     * @param respList
     * @param list
     * @return
     *//*

    private void sortByVersion(List<DictValueRespDto> respList, List<DictValueRespDto> list){
        if(null == list || list.isEmpty()){
            return;
        }
        if(list.size() == 1){
            respList = list;
        }else {
            TreeSet<DictValueRespDto> tree = new TreeSet<DictValueRespDto>(
                    (DictValueRespDto value1, DictValueRespDto value2)->{
                if(VersionUtil.compareVersion(value1.getCode(),value2.getCode()) > 0){
                    return -1;
                }else if(VersionUtil.compareVersion(value1.getCode(),value2.getCode()) < 0){
                    return 1;
                }
                return 0;
            });
            tree.addAll(list);
            respList.addAll(tree);
        }

    }




}
*/
