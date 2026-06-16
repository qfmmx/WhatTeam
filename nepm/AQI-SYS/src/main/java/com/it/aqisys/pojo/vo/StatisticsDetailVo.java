package com.it.aqisys.pojo.vo;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class StatisticsDetailVo extends StatisticsVo{
    private String address;//详细地址
    private String aqiExplain;//AQI指数解释
    private String aqiLevel;//AQI指数等级
    private String gridMemberName;//网格员姓名
    private String gridMemberPhone;//网格员手机号
    private String supervisorName;//监督员姓名
    private String supervisorPhone;//监督员手机号
    private String aqiFeedBackInformation;//AQI指数反馈信息
    private String provinceName;//省份名称
    private String cityName;//城市名称
}
