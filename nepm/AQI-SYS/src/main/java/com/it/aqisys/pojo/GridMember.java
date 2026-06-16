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
@TableName("grid_member")
public class GridMember {

    @TableId(value = "gm_id", type = IdType.AUTO)
    private String gmId; //网格员手机号码

    private String gmName;//网格员名称

    private String gmCode;//网格员登录编码

    private String password;//登录密码

    private Integer provinceId;//网格区域：省编号

    private Integer cityId;//网格区域：市编号

    private String tel;//联系电话

    private Integer state;//网格员状态 0:可工作 1:临时抽调 2:休假 3:其它

    private String remarks;//备注


}