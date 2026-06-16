package com.it.aqisys.pojo.vo;

import lombok.Data;

@Data
public class AssignVo {
    /** 反馈编号 */
    private Integer afId;
    /** 被指派的网格员 ID */
    private Integer gmId;
}
