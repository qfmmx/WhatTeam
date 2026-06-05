package com.networker.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.networker.entity.GridCity;
import com.networker.mapper.GridCityMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GridCityService extends ServiceImpl<GridCityMapper, GridCity> {

    public List<GridCity> listByProvinceId(Integer provinceId) {
        LambdaQueryWrapper<GridCity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GridCity::getIsDeleted, 0)
               .eq(GridCity::getProvinceId, provinceId)
               .orderByAsc(GridCity::getCityId);
        return this.list(wrapper);
    }

    public List<GridCity> listAll() {
        LambdaQueryWrapper<GridCity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(GridCity::getIsDeleted, 0)
               .orderByAsc(GridCity::getCityId);
        return this.list(wrapper);
    }
}
