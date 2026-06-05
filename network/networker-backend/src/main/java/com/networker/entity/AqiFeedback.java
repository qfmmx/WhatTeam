package com.networker.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@TableName("aqi_feedback")
public class AqiFeedback {
    @TableId(type = IdType.AUTO)
    private Integer afId;
    private String telId;
    private Integer provinceId;
    private Integer cityId;
    private String address;
    private String information;
    private Integer estimatedGrade;
    private LocalDate afDate;
    private String afTime;
    private String gmId;
    private LocalDate assignDate;
    private String assignTime;
    private Integer state;
    private String remarks;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
