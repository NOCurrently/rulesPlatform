package com.xc.mapper;

import com.xc.po.Rule;
import com.xc.po.RuleCollection;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * 字典值
 *
 * @author 肖超
 * @date: 2019年5月2日
 */
public interface RuleCollectionMapper {

    /**
     * 主键查找
     *
     * @param id
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    RuleCollection selectById(Integer id);


    /**
     * 增量增加
     *
     * @param record
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    int insertSelective(RuleCollection record);

    /**
     * 在增量修改
     *
     * @param record
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    int updateByPrimaryKeySelective(RuleCollection record);

}