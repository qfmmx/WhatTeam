package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class AQIDistributionVo {
    /** 等级（1~6） */
    private Integer level;
    /** 等级名称 */
    private String levelName;
    /** 该等级记录数 */
    private Integer count;
    /** 占比 */
    private String percentage;
}
