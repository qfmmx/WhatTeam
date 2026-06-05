package com.networker.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

@Data
@TableName("aqi")
public class Aqi {
    @TableId(type = IdType.AUTO)
    private Integer aqiId;
    private String chineseExplain;
    private String aqiExplain;
    private String color;
    private String healthImpact;
    private String takeSteps;
    private Integer so2Min;
    private Integer so2Max;
    private BigDecimal coMin;
    private BigDecimal coMax;
    private Integer spmMin;
    private Integer spmMax;
    private String remarks;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
