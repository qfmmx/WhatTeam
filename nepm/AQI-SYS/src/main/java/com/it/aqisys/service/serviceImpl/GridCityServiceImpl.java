package com.it.aqisys.service.serviceImpl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.it.aqisys.mapper.GridCityMapper;
import com.it.aqisys.pojo.GridCity;
import com.it.aqisys.pojo.vo.GridCityVo;
import com.it.aqisys.service.GridCityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GridCityServiceImpl extends ServiceImpl<GridCityMapper, GridCity> implements GridCityService {
    @Autowired
    private GridCityMapper gridCityMapper;
    @Override
    public List<GridCityVo> getGridCity(Integer provinceId) {
        LambdaQueryWrapper<GridCity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.eq(GridCity::getProvinceId,provinceId);
        List<GridCity> citys = this.list(queryWrapper);
        List<GridCityVo> list = citys.stream().map(city -> new GridCityVo(city.getCityId(), String.valueOf(city.getCityId()), city.getCityName(), city.getProvinceId())).toList();
        return list;
    }
}
