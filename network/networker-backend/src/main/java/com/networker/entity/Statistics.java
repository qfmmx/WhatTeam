package com.networker.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("statistics")
public class Statistics {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private Integer provinceId;
    private Integer cityId;
    private String address;
    private Integer so2Value;
    private Integer so2Level;
    private Integer coValue;
    private Integer coLevel;
    private Integer spmValue;
    private Integer spmLevel;
    private Integer aqiId;
    @TableField("confirm_date")
    private String confirmDate;
    @TableField("confirm_time")
    private String confirmTime;
    @TableField("gm_id")
    private Integer gmId;
    @TableField("fd_id")
    private String fdId;
    private String information;
    private String remarks;
}