package com.it.aqisys.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("aqi_feedback")
public class AQIFeedBack {
    @TableId(value = "af_id", type = IdType.AUTO)
    private Integer afId; //空气质量公众监督反馈信息编号

    private String telId; //所属公众监督员编号(即手机号码)

    private Integer provinceId;//反馈信息所在省区域编号

    private Integer cityId;//反馈信息所在市区域编号

    private String address;//反馈信息所在区域详细地址

    private String information;//反馈信息描述

    private Integer estimatedGrade;//反馈者对空气质量指数级别的预估等级

    private String afDate;//反馈日期

    private String afTime;//反馈时间

    private String gmId;//指派网格员编号

    private String assignDate;//指派日期

    private String assignTime;//指派时间

    private Integer state;//信息状态 0:未指派 1:已指派 2:已确认

    private String remarks;//备注
}
