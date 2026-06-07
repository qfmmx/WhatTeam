package com.example.supervisorbackend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("grid_city")
public class GridCity {

    @TableId(value = "city_id", type = IdType.INPUT)
    private Integer cityId;
    private String cityName;
    private Integer provinceId;
    private String remarks;
}
