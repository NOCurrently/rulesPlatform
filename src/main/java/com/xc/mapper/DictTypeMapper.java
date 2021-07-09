package com.xc.mapper;

import com.xc.po.DictType;
import org.apache.ibatis.annotations.Param;


import java.util.List;

/**
 * 字典类型
 *
 * @author 肖超
 * @date: 2019年5月2日
 */
public interface DictTypeMapper {


    /**
     * 增量添加
     *
     * @param record
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    int insertSelective(DictType record);


    /**
     * 增量修改
     *
     * @param record
     * @return
     * @author: 肖超
     * @date: 2019年5月2日
     */
    int updateByPrimaryKeySelective(DictType record);


    /**
     * code查询
     *
     * @return
     * @author: 肖超
     * @date: 2019年4月17日
     */
    List<DictType> selectByName(@Param("name") String name, @Param("pageNum") int pageNum, @Param("pageSize") int pageSize);

    DictType selectById(@Param("id") Integer id);

	DictType selectByCode(@Param("code")String code);
}