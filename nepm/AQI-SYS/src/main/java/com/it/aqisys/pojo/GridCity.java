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
@TableName("grid_city")
public class GridCity {

    @TableId(value = "city_id", type = IdType.AUTO)
    private Integer cityId;//系统网格覆盖市区域编号

    private String cityName;//系统网格覆盖市区域名称

    private Integer provinceId;//所属省区域编号

    private String remarks;//备注

}