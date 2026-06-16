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
@TableName("supervisor")
public class Supervisor {

    @TableId(value = "tel_id", type = IdType.INPUT)
    private String telId; //公众监督员编号(即手机号码)

    private String password; //公众监督员登录密码

    private String realName;//公众监督员真实姓名

    private String birthday;//公众监督员出生日期

    private Integer sex;//公众监督员性别(1:男;0:女)

    private String remarks;//备注


}