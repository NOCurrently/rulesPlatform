package com.xc.po;

import lombok.Data;

/**
 * @Author xiaochao18
 * @Description TODO
 * @Date $ $
 * @Param $
 * @return $
 **/
@Data
public class DataSource {
    private String paramTemplate;
    private String resultExtract;
    private Integer timeout;
    private String backup;

}
