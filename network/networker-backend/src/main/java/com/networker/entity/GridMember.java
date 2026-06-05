package com.networker.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.time.LocalDateTime;

@Data
@TableName("grid_member")
public class GridMember {
    @TableId(type = IdType.INPUT)
    private String gmId;
    private String gmName;
    private String gmCode;
    private String password;
    private Integer provinceId;
    private Integer cityId;
    private String tel;
    private Integer state;
    private String remarks;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isDeleted;
}
