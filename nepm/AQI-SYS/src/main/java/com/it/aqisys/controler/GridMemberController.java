package com.it.aqisys.controler;

import com.it.aqisys.pojo.vo.GridMemberVo;
import com.it.aqisys.result.Result;
import com.it.aqisys.service.GridMemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * 网格员控制器
 */
@RestController
@RequestMapping("/gridMember")
public class GridMemberController {
    
    /**
     * 网格员服务接口
     */
    @Autowired
    private GridMemberService gridMemberService;

    /**
     * 查询指定地区的网格员
     * @param provinceId 省份ID
     * @param cityId 城市ID
     * @return 网格员列表
     */
    @GetMapping("/listByCity")
    public Result<List<GridMemberVo>> getGridMember(@RequestParam("provinceId") Integer provinceId, @RequestParam("cityId") Integer cityId){
        List<GridMemberVo> res = gridMemberService.getGridMember(provinceId,cityId);
        return Result.ok(res);
    }

}
