package com.networker.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.networker.entity.GridProvince;
import com.networker.mapper.GridProvinceMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GridProvinceService extends ServiceImpl<GridProvinceMapper, GridProvince> {

    public List<GridProvince> listAll() {
        LambdaQueryWrapper<GridProvince> wrapper = new LambdaQueryWrapper<>();
        wrapper.orderByAsc(GridProvince::getProvinceId);
        return this.list(wrapper);
    }
}
