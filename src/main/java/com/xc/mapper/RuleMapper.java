package com.xc.mapper;

import com.xc.po.DictValue;
import com.xc.po.Rule;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * 字典值
 *
 * @author 肖超
 * @date: 2019年5月2日
 */
public interface RuleMapper {

    /**
     * 主键查找
     *
     * @param id
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    Rule selectById(Integer id);

    /**
     * 查找多个
     *
     * @param ids
     * @return
     * @author: 肖超
     * @date: 2019年4月30日
     */
    List<Rule> selectByIds(@Param("ids") Set<Integer> ids);

    /**
     * 增量增加
     *
     * @param record
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    int insertSelective(Rule record);

    /**
     * 在增量修改
     *
     * @param record
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    int updateByPrimaryKeySelective(Rule record);

}