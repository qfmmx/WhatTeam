package com.it.aqisys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.it.aqisys.pojo.GridProvince;
import com.it.aqisys.pojo.vo.GridProvinceVo;
import org.springframework.stereotype.Service;

import java.util.List;


public interface GridProvinceService extends IService<GridProvince> {


    List<GridProvinceVo> getAllGridProvince();

}
