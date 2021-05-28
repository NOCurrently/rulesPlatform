package com.datasource.mapper;

import com.datasource.po.AggregatDataSource;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Set;

@Repository
public interface AggregatDataSourceMapper {
    int delete(Integer id);

    int insert(AggregatDataSource record);

    AggregatDataSource selectById(Integer id);

    List<AggregatDataSource> selectByIds(@Param("ids") Set<Integer> ids);

    int update(AggregatDataSource record);

    List<AggregatDataSource> selectByKey(String key);
}