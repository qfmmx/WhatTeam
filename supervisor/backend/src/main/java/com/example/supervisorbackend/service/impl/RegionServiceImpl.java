package com.example.supervisorbackend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.supervisorbackend.entity.GridCity;
import com.example.supervisorbackend.entity.GridProvince;
import com.example.supervisorbackend.mapper.GridCityMapper;
import com.example.supervisorbackend.mapper.GridProvinceMapper;
import com.example.supervisorbackend.service.RegionService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RegionServiceImpl implements RegionService {

    private final GridProvinceMapper gridProvinceMapper;
    private final GridCityMapper gridCityMapper;

    public RegionServiceImpl(GridProvinceMapper gridProvinceMapper, GridCityMapper gridCityMapper) {
        this.gridProvinceMapper = gridProvinceMapper;
        this.gridCityMapper = gridCityMapper;
    }

    @Override
    public List<GridProvince> listProvinces() {
        return gridProvinceMapper.selectList(new LambdaQueryWrapper<GridProvince>()
                .orderByAsc(GridProvince::getProvinceId));
    }

    @Override
    public List<GridCity> listCities(Integer provinceId) {
        return gridCityMapper.selectList(new LambdaQueryWrapper<GridCity>()
                .eq(GridCity::getProvinceId, provinceId)
                .orderByAsc(GridCity::getCityId));
    }
}
