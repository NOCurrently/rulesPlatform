package com.xc.mapper;

import com.xc.po.DataSource;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Set;

@Repository
public interface DataSourceMapper {
    int delete(Integer id);

    int insert(DataSource record);

    DataSource selectById(Integer id);

    List<DataSource> selectByIds(@Param("ids") Set<Integer> ids);

    int update(DataSource record);


}