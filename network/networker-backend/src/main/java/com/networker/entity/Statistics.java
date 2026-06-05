package com.networker.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("statistics")
public class Statistics {
    @TableId(type = IdType.AUTO)
    private Integer statId;
    private String gmId;
    private Integer provinceId;
    private Integer cityId;
    private Integer aqiId;
    private Integer so2Value;
    private Double coValue;
    private Integer spmValue;
    private String monitorDate;
    private String monitorTime;
    private String remarks;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
    private String address;
    private Integer so2Level;
    private Integer coLevel;
    private Integer spmLevel;
    private Integer fdId;
    private String information;
}
