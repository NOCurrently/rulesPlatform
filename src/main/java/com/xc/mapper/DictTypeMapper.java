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
	 * 删除
	 *
	 * @author: 肖超
	 * @date: 2019年5月2日
	 * @param id
	 * @return
	 */
	int deleteByPrimaryKey(Integer id);


	/**
	 * 增量添加
	 *
	 * @author: 肖超
	 * @date: 2019年5月2日
	 * @param record
	 * @return
	 */
	int insertSelective(DictType record);

	/**
	 * 查找
	 *
	 * @author: 肖超
	 * @date: 2019年5月2日
	 * @param id
	 * @return
	 */
	DictType selectByPrimaryKey(Integer id);

	/**
	 * 增量修改
	 *
	 * @author: 肖超
	 * @date: 2019年5月2日
	 * @param record
	 * @return
	 */
	int updateByPrimaryKeySelective(DictType record);


	/**
	 * 条件查询字典类型
	 *
	 * @param dictTypeParam
	 * @return
	 */
	List<DictType> selectByCondition(DictType dictTypeParam);

	/**
	 * code查询
	 * 
	 * @param code
	 * @return
	 * @author: 肖超
	 * @date: 2019年4月17日
	 */
	DictType selectByTypeCode(@Param("code") String code);
}