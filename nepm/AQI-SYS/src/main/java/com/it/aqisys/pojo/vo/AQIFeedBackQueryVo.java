package com.it.aqisys.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AQIFeedBackQueryVo {
    /** 页码，从 1 开始 */
    private Integer pageNum;
    /** 每页条数 */
    private Integer pageSize;
    /** 反馈状态过滤（0/1/2） */
    private Integer state;
    /** 城市编码，模糊匹配 */
    private String cityCode;
    /** 反馈人手机号，模糊匹配 */
    private String telId;
    /** 反馈起始时间 */
    private String startTime;
    /** 反馈结束时间 */
    private String endTime;

}
