package com.xc.mapper;

import com.xc.po.DictValue;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Set;

/**
 * 字典值
 *
 * @author 肖超
 * @date: 2019年5月2日
 */
public interface DictValueMapper {
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
	 * 增量增加
	 *
	 * @author: 肖超
	 * @date: 2019年5月2日
	 * @param record
	 * @return
	 */
	int insertSelective(DictValue record);

	/**
	 * 主键查找
	 *
	 * @author: 肖超
	 * @date: 2019年5月2日
	 * @param id
	 * @return
	 */
	DictValue selectByPrimaryKey(Integer id);

	/**
	 * 在增量修改
	 *
	 * @author: 肖超
	 * @date: 2019年5月2日
	 * @param record
	 * @return
	 */
	int updateByPrimaryKeySelective(DictValue record);


	/**
	 * 类型id查找
	 * 
	 * @author: 肖超
	 * @date: 2019年4月17日
	 * @param typeId
	 * @return
	 */
	List<DictValue> selectByTypeId(@Param("typeId") Integer typeId);


	/**
	 * 查找多个
	 * 
	 * @author: 肖超
	 * @date: 2019年4月30日
	 * @param ids
	 * @return
	 */
	List<DictValue> selectByIds(@Param("ids") Set<Integer> ids);

}