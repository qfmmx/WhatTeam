package com.example.supervisorbackend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("grid_province")
public class GridProvince {

    @TableId(value = "province_id", type = IdType.INPUT)
    private Integer provinceId;
    private String provinceName;
    private String remarks;
}
