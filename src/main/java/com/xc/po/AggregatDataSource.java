package com.xc.po;

import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Data
public class AggregatDataSource {
    private Integer id;
    private Integer dsId;
    private Integer parentId;
    private Integer status;
    private String aggregatKey;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;

    private List<AggregatDataSource> subAds;
}
