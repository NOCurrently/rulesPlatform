package com.xc.datasouce.service;


import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.xc.mapper.DictTypeMapper;
import com.xc.mapper.DictValueMapper;
import com.xc.po.DictType;
import com.xc.po.DictValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * 服务实现类
 *
 * @author 肖超
 * @date: 2019年4月19日
 */
@Service
public class DictService {
    @Autowired
    private DictTypeMapper dictTypeMapper;
    @Autowired
    private DictValueMapper dictValueMapper;

    /**
     * @param dictType
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    public int insertType(DictType dictType) {
        DictType selectByTypeCode = dictTypeMapper.selectByCode(dictType.getCode());
        if (selectByTypeCode != null) {
            throw new RuntimeException(dictType.getCode() + "已存在");
        }
        return dictTypeMapper.insertSelective(dictType);
    }

    /**
     * @param dictValue
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    public int insertValue(DictValue dictValue) {
        return dictValueMapper.insertSelective(dictValue);
    }

    public List<DictType> selectTypeByName(String name,Integer pageNum,Integer pageSize) {
        List<DictType> dictType = dictTypeMapper.selectByName(name,pageNum,pageSize);
        if (dictType == null) {
            return new ArrayList<>(0);
        }
        return dictType;
    }
    public DictType selectTypeId(Integer id) {
        DictType dictType = dictTypeMapper.selectById(id);
        return dictType;
    }


    /**
     * @param dictType
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    public int updateType(DictType dictType) {
        return dictTypeMapper.updateByPrimaryKeySelective(dictType);
    }

    /**
     * @param dictValue
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    public int updateValue(DictValue dictValue) {
        return dictValueMapper.updateByPrimaryKeySelective(dictValue);
    }

}
