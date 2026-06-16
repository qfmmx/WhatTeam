package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class StatisticsQueryVo {
    /** 页码 */
    private Integer pageNum;
    /** 每页条数 */
    private Integer pageSize;
    /** 城市名称，模糊匹配 */
    private String cityName;
    /** 是否超标（0/1） */
    private Integer isExceed;
    /** 确认起始时间 */
    private String startTime;
    /** 确认结束时间 */
    private String endTime;
}
