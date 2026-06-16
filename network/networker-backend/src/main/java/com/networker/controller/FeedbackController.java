package com.networker.controller;

import com.networker.common.PageResult;
import com.networker.common.Result;
import com.networker.dto.FeedbackDTO;
import com.networker.dto.PageRequest;
import com.networker.entity.AqiFeedback;
import com.networker.entity.GridCity;
import com.networker.entity.GridProvince;
import com.networker.mapper.GridCityMapper;
import com.networker.mapper.GridProvinceMapper;
import com.networker.service.AqiFeedbackService;
import com.networker.service.StatisticsService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/api/feedback")
@RequiredArgsConstructor
@CrossOrigin
public class FeedbackController {

    private final AqiFeedbackService aqiFeedbackService;
    private final StatisticsService statisticsService;
    private final GridProvinceMapper gridProvinceMapper;
    private final GridCityMapper gridCityMapper;

    @GetMapping("/init")
    public Result<String> initTestData() {
        try {
            AqiFeedback feedback1 = new AqiFeedback();
            feedback1.setTelId("13800138001");
            feedback1.setProvinceId(1);
            feedback1.setCityId(1);
            feedback1.setAddress("北京市朝阳区建国路88号");
            feedback1.setInformation("用户反馈空气质量较差，有明显异味");
            feedback1.setEstimatedGrade(3);
            feedback1.setState(1);
            feedback1.setGmId(1);
            aqiFeedbackService.save(feedback1);

            AqiFeedback feedback2 = new AqiFeedback();
            feedback2.setTelId("13800138001");
            feedback2.setProvinceId(1);
            feedback2.setCityId(2);
            feedback2.setAddress("北京市海淀区中关村大街1号");
            feedback2.setInformation("用户反馈PM2.5浓度较高");
            feedback2.setEstimatedGrade(2);
            feedback2.setState(1);
            feedback2.setGmId(1);
            aqiFeedbackService.save(feedback2);

            AqiFeedback feedback3 = new AqiFeedback();
            feedback3.setTelId("13800138001");
            feedback3.setProvinceId(2);
            feedback3.setCityId(3);
            feedback3.setAddress("上海市浦东新区陆家嘴环路999号");
            feedback3.setInformation("用户反馈有轻微雾霾");
            feedback3.setEstimatedGrade(1);
            feedback3.setState(1);
            feedback3.setGmId(1);
            aqiFeedbackService.save(feedback3);

            return Result.success("测试数据初始化成功");
        } catch (Exception e) {
            return Result.error("初始化失败: " + e.getMessage());
        }
    }

    @PostMapping("/assign")
    public Result<Boolean> assign(@RequestBody Map<String, Object> data) {
        Integer afId = (Integer) data.get("afId");
        Integer gmId = (Integer) data.get("gmId");
        
        AqiFeedback feedback = aqiFeedbackService.getById(afId);
        if (feedback == null) {
            return Result.error("反馈记录不存在");
        }
        
        feedback.setState(1);
        feedback.setGmId(gmId);
        aqiFeedbackService.updateById(feedback);
        
        return Result.success(true);
    }

    @PostMapping("/list")
    public Result<PageResult<FeedbackDTO>> list(@RequestBody PageRequest request, @RequestParam Integer gmId) {
        try {
            PageResult<AqiFeedback> page = aqiFeedbackService.listByGmId(gmId, request);
            
            List<FeedbackDTO> dtoList = page.getRecords().stream().map(feedback -> {
                String provinceName = getProvinceName(feedback.getProvinceId());
                String cityName = getCityName(feedback.getCityId());
                return FeedbackDTO.fromEntity(feedback, provinceName, cityName);
            }).collect(Collectors.toList());
            
            PageResult<FeedbackDTO> result = new PageResult<>();
            result.setTotal(page.getTotal());
            result.setRecords(dtoList);
            result.setCurrent(page.getCurrent());
            result.setSize(page.getSize());
            
            return Result.success(result);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.error("获取列表失败: " + e.getMessage());
        }
    }

    private String getProvinceName(Integer provinceId) {
        if (provinceId == null) return "";
        GridProvince province = gridProvinceMapper.selectById(provinceId);
        return province != null ? province.getProvinceName() : "";
    }

    private String getCityName(Integer cityId) {
        if (cityId == null) return "";
        GridCity city = gridCityMapper.selectById(cityId);
        return city != null ? city.getCityName() : "";
    }

    @PostMapping("/submit")
    public Result<Boolean> submit(@RequestBody Map<String, Object> data) {
        Integer gmId = (Integer) data.get("gmId");
        Integer afId = (Integer) data.get("afId");
        Integer so2 = (Integer) data.get("so2");
        Integer pm25 = (Integer) data.get("pm25");
        
        // 处理 co 参数，可能是 Integer 或 Double
        Double co = null;
        Object coObj = data.get("co");
        if (coObj instanceof Integer) {
            co = ((Integer) coObj).doubleValue();
        } else if (coObj instanceof Double) {
            co = (Double) coObj;
        }

        boolean success = statisticsService.saveMeasureData(gmId, afId, so2, co, pm25);
        return success ? Result.success(true) : Result.error("提交失败");
    }
}