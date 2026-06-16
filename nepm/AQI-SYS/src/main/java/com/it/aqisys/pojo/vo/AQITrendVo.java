package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class AQITrendVo {
    /** 月份（YYYY-MM） */
    private String month;
    /** 当月超标数 */
    private Integer exceedCount;
}
