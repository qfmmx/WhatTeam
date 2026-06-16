package com.it.aqisys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.it.aqisys.pojo.GridCity;
import com.it.aqisys.pojo.vo.GridCityVo;

import java.util.List;

public interface GridCityService extends IService<GridCity> {
    List<GridCityVo> getGridCity(Integer provinceId);
}
