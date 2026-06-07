package com.example.supervisorbackend.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName("supervisor")
public class Supervisor {

    @TableId(value = "tel_id", type = IdType.INPUT)
    private String telId;
    private String password;
    private String realName;
    private String birthday;
    private Integer sex;
    private String remarks;
}
