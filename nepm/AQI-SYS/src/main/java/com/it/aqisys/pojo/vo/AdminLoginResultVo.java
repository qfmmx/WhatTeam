package com.it.aqisys.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class AdminLoginResultVo {
    /** 管理员 ID */
    private Integer id;
    /** 登录编码 */
    private String adminCode;
    /** 管理员姓名 */
    private String adminName;
    /** 角色 */
    private String role;
    /** 状态 */
    private Integer status;
}
