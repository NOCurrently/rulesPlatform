package com.xc.datasouce.service;

import com.xc.mapper.DictTypeMapper;
import com.xc.mapper.DictValueMapper;
import com.xc.po.DictType;
import com.xc.po.DictValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

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
        DictType selectByTypeCode = dictTypeMapper.selectByTypeCode(dictType.getCode());
        if (selectByTypeCode != null) {
            return -1;
        }
        return dictTypeMapper.insertSelective(dictType);
    }

    /**
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    public int insertValue(DictValue dictValue) {
        return dictValueMapper.insertSelective(dictValue);
    }

    /**
     * @param code
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    public List<DictValue> selectByTypeCode(String code) {
        DictType dictType = dictTypeMapper.selectByTypeCode(code);
        if (dictType == null) {
            return new ArrayList<>(0);
        }
        List<DictValue> poList = dictValueMapper.selectByTypeId(dictType.getId());
        if (poList == null) {
            return new ArrayList<>(0);
        }
        return poList;
    }

    /**
     * 根据typeId查询所有字典值
     *
     * @param typeId
     * @return
     */
    public List<DictValue> selectDictValuesByTypeId(Integer typeId) {
        DictType dictType = dictTypeMapper.selectByPrimaryKey(typeId);
        if (dictType == null) {
            return new ArrayList<>(0);
        }
        List<DictValue> dictValues = dictValueMapper.selectByTypeId(typeId);
        return dictValues;
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
     * @param dictValue1
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    public int updateValue(DictValue dictValue) {
        return dictValueMapper.updateByPrimaryKeySelective(dictValue);
    }




    /**
     * 条件查询字典类型
     *
     * @param dictType
     * @return
     */
    public List<DictType> selectByCondition(DictType dictType) {
        List<DictType> dictTypes = dictTypeMapper.selectByCondition(dictType);
        return dictTypes;
    }



    /**
     * @param valueId
     * @return
     * @author: 肖超
     * @date: 2019年4月30日
     */
    public List<DictValue> selectByValueId(Set<Integer> valueId) {
        List<DictValue> dictValue = dictValueMapper.selectByIds(valueId);
        return dictValue;
    }

}
