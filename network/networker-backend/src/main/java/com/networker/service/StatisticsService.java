package com.networker.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.networker.entity.Aqi;
import com.networker.entity.AqiFeedback;
import com.networker.entity.Statistics;
import com.networker.mapper.AqiFeedbackMapper;
import com.networker.mapper.StatisticsMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;

@Service
public class StatisticsService extends ServiceImpl<StatisticsMapper, Statistics> {

    private final AqiFeedbackMapper aqiFeedbackMapper;
    private final AqiService aqiService;

    public StatisticsService(AqiFeedbackMapper aqiFeedbackMapper, AqiService aqiService) {
        this.aqiFeedbackMapper = aqiFeedbackMapper;
        this.aqiService = aqiService;
    }

    public boolean saveMeasureData(String gmId, Integer afId, Integer so2, Double co, Integer pm25) {
        try {
            // 获取反馈信息
            AqiFeedback feedback = aqiFeedbackMapper.selectById(afId);
            if (feedback == null) {
                return false;
            }

            // 创建统计记录
            Statistics statistics = new Statistics();
            statistics.setGmId(gmId);
            statistics.setProvinceId(feedback.getProvinceId());
            statistics.setCityId(feedback.getCityId());
            // 根据SO2值查找对应的AQI记录
            Aqi aqi = aqiService.getAqiByValues(so2, BigDecimal.valueOf(co), pm25);
            if (aqi != null) {
                statistics.setAqiId(aqi.getAqiId());
            }
            statistics.setSo2Value(so2);
            statistics.setCoValue(co);
            statistics.setSpmValue(pm25);
            statistics.setMonitorDate(LocalDate.now().toString());
            statistics.setMonitorTime(LocalTime.now().toString());
            statistics.setIsDeleted(0);
            statistics.setCreateTime(LocalDateTime.now());
            statistics.setUpdateTime(LocalDateTime.now());
            
            // 填充缺失的字段
            statistics.setAddress(feedback.getAddress());
            statistics.setFdId(afId);
            statistics.setInformation(feedback.getInformation());
            
            // 计算等级 (根据数值范围计算)
            statistics.setSo2Level(calculateLevel(so2));
            statistics.setCoLevel(calculateCoLevel(co));
            statistics.setSpmLevel(calculateLevel(pm25));

            // 保存统计数据
            this.save(statistics);

            // 更新反馈状态为已实测 (state = 2)
            feedback.setState(2);
            feedback.setUpdateTime(LocalDateTime.now());
            aqiFeedbackMapper.updateById(feedback);

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 计算SO2和PM2.5的等级
    private Integer calculateLevel(Integer value) {
        if (value == null) return null;
        if (value <= 50) return 1;   // 优
        if (value <= 150) return 2;  // 良
        if (value <= 250) return 3;  // 轻度污染
        if (value <= 350) return 4;  // 中度污染
        return 5;                     // 重度污染
    }
    
    // 计算CO的等级
    private Integer calculateCoLevel(Double value) {
        if (value == null) return null;
        if (value <= 2) return 1;    // 优
        if (value <= 4) return 2;    // 良
        if (value <= 14) return 3;   // 轻度污染
        if (value <= 24) return 4;   // 中度污染
        return 5;                     // 重度污染
    }
}
