package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class UpdateStateVo {
    /** 反馈编号 */
    private Integer id;
    /** 目标状态（0/1/2） */
    private Integer state;
}
