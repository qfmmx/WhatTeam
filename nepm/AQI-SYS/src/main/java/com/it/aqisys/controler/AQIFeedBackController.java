package com.it.aqisys.controler;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import com.it.aqisys.pojo.AQIFeedBack;
import com.it.aqisys.pojo.GridCity;
import com.it.aqisys.pojo.GridProvince;
import com.it.aqisys.pojo.vo.*;
import com.it.aqisys.result.Result;
import com.it.aqisys.service.AQIFeedBackService;
import com.it.aqisys.service.GridCityService;
import com.it.aqisys.service.GridMemberService;
import com.it.aqisys.service.GridProvinceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;


/**
 * 公众监督反馈模块控制器
 */
@RestController
@RequestMapping({"/aqiFeedback", "/aqiFeedBack", "/feedback"})
public class AQIFeedBackController {
    
    /**
     * 公众监督反馈服务接口
     */
    @Autowired
    private AQIFeedBackService aqiFeedBackService;
    
    /**
     * 城市服务接口
     */
    @Autowired
    private GridCityService gridCityService;
    
    /**
     * 省份服务接口
     */
    @Autowired
    private GridProvinceService gridProvinceService;
    
    /**
     * 网格员服务接口
     */
    @Autowired
    private GridMemberService gridMemberService;

    /**
     * 分页查询公众监督员反馈的信息
     * @param queryVo 查询参数视图对象
     * @return 返回分页结果
     */
    @RequestMapping(value = {"/page", ""}, method = {RequestMethod.GET, RequestMethod.POST})
    public Result<IPage<AQIFeedBackVo>> pageItem(AQIFeedBackQueryVo queryVo){
        if (queryVo == null) {
            queryVo = new AQIFeedBackQueryVo();
        }
        long current = queryVo.getPageNum() != null ? queryVo.getPageNum() : 1;
        long size = queryVo.getPageSize() != null ? queryVo.getPageSize() : 10;
        Page<AQIFeedBackVo> page=new Page<>(current,size);
        IPage<AQIFeedBackVo> result= aqiFeedBackService.pageItem(page,queryVo);
        return Result.ok(result);
    }
    
    /**
     * 根据反馈信息id查看公众监督反馈详细信息
     * @param afId 反馈信息ID
     * @return 返回详细信息
     */
    @GetMapping("/{id}")
    public Result<AQIFeedBackDetailVo> getFeedBackDetail(@PathVariable("id") Integer afId){
        AQIFeedBackDetailVo detailVo= aqiFeedBackService.getFeedBackDetail(afId);
        return Result.ok(detailVo);
    }
    
    /**
     * 指派公众监督反馈信息
     * @param assignVo 指派视图对象
     * @return 返回受影响行数
     */
    @PutMapping("/assign")
    public Result<Integer> assignFeedBack(@RequestBody AssignVo assignVo){
        System.out.println(assignVo);
        aqiFeedBackService.assignFeedBack(String.valueOf(assignVo.getGmId()), assignVo.getAfId());
        return Result.ok(1); // 成功受影响行数为1
    }

    /**
     * 更新反馈状态
     * @param updateStateVo 更新状态视图对象
     * @return 返回受影响的行数
     */
    @PutMapping("/state")
    public Result<Integer> updateAqiFeedbackState(@RequestBody UpdateStateVo updateStateVo){
        aqiFeedBackService.updateState(updateStateVo.getId(), updateStateVo.getState());
        return Result.ok(1); // 成功受影响行数为1
    }

    /**
     * 查询本市在岗网格员
     * @param afId 反馈记录的ID
     * @return 返回本市在岗网格员及城市信息
     */
    @GetMapping("/{afId}/localMembers")
    public Result<Map<String, Object>> getLocalMembers(@PathVariable("afId") Integer afId) {
        AQIFeedBack aqiFeedBack = aqiFeedBackService.getById(afId);
        if (aqiFeedBack == null) {
            return Result.fail(204, "反馈记录不存在");
        }
        
        Integer provinceId = aqiFeedBack.getProvinceId();
        Integer cityId = aqiFeedBack.getCityId();
        
        GridProvince province = gridProvinceService.getById(provinceId);
        GridCity city = gridCityService.getById(cityId);
        
        List<GridMemberVo> members = gridMemberService.getGridMember(provinceId, cityId);
        // 过滤在岗网格员 1为在岗
        List<GridMemberVo> localMembers = members.stream()
                .filter(m -> m.getStatus() != null && m.getStatus() == 1)
                .collect(Collectors.toList());
        
        Map<String, Object> result = new HashMap<>();
        result.put("provinceId", provinceId);
        result.put("provinceName", province != null ? province.getProvinceName() : "");
        result.put("cityId", cityId);
        result.put("cityName", city != null ? city.getCityName() : "");
        result.put("hasLocal", !localMembers.isEmpty());
        result.put("members", localMembers);
        
        return Result.ok(result);
    }

    /**
     * 查询跨省可调派网格员
     * @param afId 反馈记录的ID
     * @return 返回外省在岗网格员列表
     */
    @GetMapping("/{afId}/crossMembers")
    public Result<List<GridMemberVo>> getCrossMembers(@PathVariable("afId") Integer afId) {
        AQIFeedBack aqiFeedBack = aqiFeedBackService.getById(afId);
        if (aqiFeedBack == null) {
            return Result.fail(204, "反馈记录不存在");
        }
        
        Integer provinceId = aqiFeedBack.getProvinceId();
        
        // 查询除了该省份以外的在岗网格员
        List<GridMemberVo> crossMembers = gridMemberService.getCrossMembers(provinceId);
                
        return Result.ok(crossMembers);
    }

}
