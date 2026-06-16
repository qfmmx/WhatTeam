package com.it.aqisys.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@TableName("statistics")
public class Statistics {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer statId; //监测统计编号

    private String gmId;//所属网格员编号

    private Integer provinceId;//所属省编号

    private Integer cityId;//所属市编号

    private Integer aqiId;//所属AQI级别编号

    private Integer so2Value; //实测二氧化硫浓度

    private Integer coValue;//实测一氧化碳浓度

    private Integer spmValue;//实测悬浮颗粒物浓度

    @TableField("confirm_date")
    private String monitorDate;//监测日期

    @TableField("confirm_time")
    private String monitorTime;//监测时间

    private String remarks;//备注


}