package com.it.aqisys.controler;

import com.it.aqisys.pojo.GridProvince;
import com.it.aqisys.pojo.vo.GridProvinceVo;
import com.it.aqisys.result.Result;
import com.it.aqisys.service.GridProvinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 省份网格控制器
 */
@RestController
@RequestMapping("/gridProvince")
public class GridProvinceController {
    
    /**
     * 省份服务接口
     */
    @Autowired
    private GridProvinceService gridProvinceService;
    
    /**
     * 获取所有省信息
     * @return 省份信息列表
     */
    @GetMapping("/listAll")
    public Result<List<GridProvinceVo>> getAllGridProvince(){
        List<GridProvinceVo> res = gridProvinceService.getAllGridProvince();
        return Result.ok(res);
    }

}
