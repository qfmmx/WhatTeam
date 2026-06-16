package com.networker.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.networker.entity.Aqi;
import com.networker.mapper.AqiMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AqiService extends ServiceImpl<AqiMapper, Aqi> {

    public List<Aqi> listAll() {
        LambdaQueryWrapper<Aqi> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(Aqi::getAqiId);
        return this.list(wrapper);
    }

    public Aqi getAqiByValues(Integer so2Value, java.math.BigDecimal coValue, Integer spmValue) {
        List<Aqi> allAqi = listAll();
        for (Aqi aqi : allAqi) {
            if (so2Value >= aqi.getSo2Min() && so2Value <= aqi.getSo2Max()) {
                return aqi;
            }
        }
        return null;
    }
}
