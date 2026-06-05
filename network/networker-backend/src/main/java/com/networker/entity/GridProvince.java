package com.networker.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("grid_province")
public class GridProvince {
    @TableId(type = IdType.AUTO)
    private Integer provinceId;
    private String provinceName;
    private String provinceAbbr;
    private String remarks;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
