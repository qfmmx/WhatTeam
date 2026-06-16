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
@TableName("admins")
public class Admin {
    @TableId(value = "admin_id", type = IdType.AUTO)
    private Integer adminId; //系统管理员编号
    private String adminCode; //系统管理员登陆编号
    private String password;//系统管理员密码
    private String remarks;//备注
}
