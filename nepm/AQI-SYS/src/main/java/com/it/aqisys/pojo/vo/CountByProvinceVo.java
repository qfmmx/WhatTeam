package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class CountByProvinceVo {
    /** 省份名称 */
    private String provinceName;
    /** 超标记录数 */
    private Integer exceedCount;
    /** 总记录数 */
    private Integer totalCount;
    /** 超标率 */
    private String exceedRate;
}
