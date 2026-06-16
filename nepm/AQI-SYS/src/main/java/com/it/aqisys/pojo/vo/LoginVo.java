package com.it.aqisys.pojo.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class LoginVo {
    private String adminCode; //系统管理员登陆编号
    private String password;//系统管理员密码
}
