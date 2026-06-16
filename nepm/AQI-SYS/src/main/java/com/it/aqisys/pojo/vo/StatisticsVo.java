package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class StatisticsVo {
    private Integer id;//记录 ID
    private String cityCode;//城市编码
    private Integer aqiValue;//AQI 值
    private String confirmTime;//确认时间
    private Integer gmId;//确认网格员 ID
    private Integer isExceed;//是否超标（0/1）
}
