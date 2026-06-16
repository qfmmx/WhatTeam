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
@TableName("aqi")
public class AQI {
    @TableId(value = "aqi_id", type = IdType.AUTO)
    private Integer aqiId; //空气质量指数级别(共六级)
    private String chineseExplain;//空气质量指数级别汉字表述
    private String aqiExplain;//空气质量指数级别描述
    private String color;// 空气质量指数级别表示颜色
    private String healthImpact;//对健康影响情况
    private String takeSteps;//建议采取的措施
    private Integer so2Min;//本级别二氧化硫浓度最小限值
    private Integer so2Max;//本级别二氧化硫浓度最大限值
    private Integer coMin;//本级别一氧化碳浓度最小限值
    private Integer coMax;//本级别一氧化碳浓度最大限值
    private Integer spmMin;//本级别PM2.5浓度最小限值
    private Integer spmMax;//本级别PM2.5浓度最大限值
    private String remarks;//备注
}
