package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class AQIFeedBackVo {
    /**
     * 反馈编号
     */
    private Integer id;
    /**
     * 反馈人手机号
     */
    private String telId;
    /**
     * 城市编码
     */
    private String cityCode;
    /**
     * 城市名称
     */
    private String cityName;
    /**
     * 观测 AQI 值
     */
    private Integer aqiValue;
    /**
     * 反馈时间
     */
    private String feedbackTime;
    /**
     * 状态（0/1/2）
     */
    private Integer state;
    /**
     * 指派网格员 ID
     */
    private Integer gmId;
    /**
     * 网格员姓名
     */
    private String gmName;
    /**
     * 指派时间
     */
    private String assignTime;
    /**
     * 反馈描述
     */
    private String remark;
}
