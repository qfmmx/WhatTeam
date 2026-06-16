package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class GridMemberVo {
    /**
     * 网格员 ID
     */
    private Integer id;
    /**
     * 网格员编码
     */
    private String memberCode;
    /**
     * 网格员姓名
     */
    private String memberName;
    /**
     * 联系电话
     */
    private String phone;
    /**
     * 所属省份 ID
     */
    private Integer provinceId;
    /**
     * 所属省份名称
     */
    private String provinceName;
    /**
     * 所属城市 ID
     */
    private Integer cityId;
    /**
     * 所属城市名称
     */
    private String cityName;
    /**
     * 状态（1 启用 / 2 禁用）
     */
    private Integer status;
}
