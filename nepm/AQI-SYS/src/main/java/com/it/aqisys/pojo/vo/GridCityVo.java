package com.it.aqisys.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GridCityVo {
    /**
     * 城市 ID
     */
    private Integer id;
    /**
     * 城市编码
     */
    private String cityCode;
    /**
     * 城市名称
     */
    private String cityName;
    /**
     * 所属省份 ID
     */
    private Integer provinceId;
}
