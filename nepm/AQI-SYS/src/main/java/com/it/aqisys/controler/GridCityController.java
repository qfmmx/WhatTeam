package com.it.aqisys.controler;

import com.it.aqisys.pojo.vo.GridCityVo;
import com.it.aqisys.result.Result;
import com.it.aqisys.service.GridCityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 城市网格控制器
 */
@RestController
@RequestMapping("/gridCity")
public class GridCityController {
    
    /**
     * 城市服务接口
     */
    @Autowired
    private GridCityService gridCityService;
    
    /**
     * 获取指定省下的所有城市信息
     * @param provinceId 省份ID
     * @return 城市信息列表
     */
    @GetMapping("/listByProvince")
    public Result<List<GridCityVo>> getGridCityByProvinceId(@RequestParam("provinceId") Integer provinceId){
        List<GridCityVo> res = gridCityService.getGridCity(provinceId);
        return Result.ok(res);
    }
}
