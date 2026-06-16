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
@TableName("grid_province")
public class GridProvince {

    @TableId(value = "province_id", type = IdType.AUTO)
    private Integer provinceId; //系统网格覆盖省区域编号

    private String provinceName;//系统网格覆盖省区域名称

    private String provinceAbbr; //系统网格覆盖省区域简称

    private String remarks; //备注

}