package com.xc.po;

import lombok.Data;
import java.util.Date;

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
    private String processSegmentJson;
    private Integer status;
    private String dependAggregatIds;
    private String createBy;
    private String updateBy;
    private Date createTime;
    private Date updateTime;
}
