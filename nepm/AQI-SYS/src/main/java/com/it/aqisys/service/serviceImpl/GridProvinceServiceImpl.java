package com.it.aqisys.service.serviceImpl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.it.aqisys.mapper.GridProvinceMapper;
import com.it.aqisys.pojo.GridProvince;
import com.it.aqisys.pojo.vo.GridProvinceVo;
import com.it.aqisys.service.GridProvinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GridProvinceServiceImpl extends ServiceImpl<GridProvinceMapper, GridProvince> implements GridProvinceService {
   @Autowired
   private GridProvinceMapper gridProvinceMapper;
    @Override
    public List<GridProvinceVo> getAllGridProvince() {
        List<GridProvince> list = list();
        return list.stream()
                .map(gridProvince -> new GridProvinceVo(gridProvince.getProvinceId(), gridProvince.getProvinceAbbr(), gridProvince.getProvinceName())).toList();
    }
}
