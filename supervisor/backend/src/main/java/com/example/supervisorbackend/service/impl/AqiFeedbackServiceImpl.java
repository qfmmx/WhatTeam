package com.example.supervisorbackend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.supervisorbackend.dto.AqiFeedbackResponse;
import com.example.supervisorbackend.dto.AqiFeedbackSaveRequest;
import com.example.supervisorbackend.entity.AqiFeedback;
import com.example.supervisorbackend.entity.GridCity;
import com.example.supervisorbackend.entity.GridProvince;
import com.example.supervisorbackend.mapper.AqiFeedbackMapper;
import com.example.supervisorbackend.mapper.GridCityMapper;
import com.example.supervisorbackend.mapper.GridProvinceMapper;
import com.example.supervisorbackend.mapper.SupervisorMapper;
import com.example.supervisorbackend.service.AqiFeedbackService;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

@Service
public class AqiFeedbackServiceImpl implements AqiFeedbackService {

    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    private static final DateTimeFormatter TIME_FORMATTER = DateTimeFormatter.ofPattern("HH:mm:ss");

    private final AqiFeedbackMapper aqiFeedbackMapper;
    private final SupervisorMapper supervisorMapper;
    private final GridProvinceMapper gridProvinceMapper;
    private final GridCityMapper gridCityMapper;

    public AqiFeedbackServiceImpl(AqiFeedbackMapper aqiFeedbackMapper,
                                  SupervisorMapper supervisorMapper,
                                  GridProvinceMapper gridProvinceMapper,
                                  GridCityMapper gridCityMapper) {
        this.aqiFeedbackMapper = aqiFeedbackMapper;
        this.supervisorMapper = supervisorMapper;
        this.gridProvinceMapper = gridProvinceMapper;
        this.gridCityMapper = gridCityMapper;
    }

    @Override
    public boolean saveFeedback(AqiFeedbackSaveRequest request) {
        if (supervisorMapper.selectById(request.getTelId()) == null) {
            throw new IllegalArgumentException("公众监督员不存在");
        }
        GridProvince province = gridProvinceMapper.selectById(request.getProvinceId());
        if (province == null) {
            throw new IllegalArgumentException("省份不存在");
        }
        GridCity city = gridCityMapper.selectById(request.getCityId());
        if (city == null || !request.getProvinceId().equals(city.getProvinceId())) {
            throw new IllegalArgumentException("城市不存在或与省份不匹配");
        }

        AqiFeedback feedback = new AqiFeedback();
        feedback.setTelId(request.getTelId());
        feedback.setProvinceId(request.getProvinceId());
        feedback.setCityId(request.getCityId());
        feedback.setAddress(request.getAddress());
        feedback.setInformation(request.getInformation());
        feedback.setEstimatedGrade(request.getEstimatedGrade());
        feedback.setAfDate(LocalDate.now().format(DATE_FORMATTER));
        feedback.setAfTime(LocalTime.now().format(TIME_FORMATTER));
        feedback.setGmId(0);
        feedback.setState(0);
        return aqiFeedbackMapper.insert(feedback) > 0;
    }

    @Override
    public List<AqiFeedbackResponse> listByTel(String telId) {
        List<AqiFeedback> records = aqiFeedbackMapper.selectList(new LambdaQueryWrapper<AqiFeedback>()
                .eq(AqiFeedback::getTelId, telId)
                .orderByDesc(AqiFeedback::getAfDate)
                .orderByDesc(AqiFeedback::getAfTime));
        if (records == null || records.isEmpty()) {
            return Collections.emptyList();
        }
        Map<Integer, String> provinceMap = gridProvinceMapper.selectList(null).stream()
                .collect(Collectors.toMap(GridProvince::getProvinceId, GridProvince::getProvinceName));
        Map<Integer, String> cityMap = gridCityMapper.selectList(null).stream()
                .collect(Collectors.toMap(GridCity::getCityId, GridCity::getCityName));
        return records.stream().map(item -> toResponse(item, provinceMap, cityMap)).toList();
    }

    @Override
    public AqiFeedbackResponse getById(Integer id) {
        AqiFeedback feedback = aqiFeedbackMapper.selectById(id);
        if (feedback == null) {
            return null;
        }
        Map<Integer, String> provinceMap = gridProvinceMapper.selectList(null).stream()
                .collect(Collectors.toMap(GridProvince::getProvinceId, GridProvince::getProvinceName));
        Map<Integer, String> cityMap = gridCityMapper.selectList(null).stream()
                .collect(Collectors.toMap(GridCity::getCityId, GridCity::getCityName));
        return toResponse(feedback, provinceMap, cityMap);
    }

    private AqiFeedbackResponse toResponse(AqiFeedback feedback, Map<Integer, String> provinceMap, Map<Integer, String> cityMap) {
        AqiFeedbackResponse response = new AqiFeedbackResponse();
        response.setId(feedback.getAfId());
        response.setTelId(feedback.getTelId());
        response.setProvinceId(feedback.getProvinceId());
        response.setProvinceName(provinceMap.get(feedback.getProvinceId()));
        response.setCityId(feedback.getCityId());
        response.setCityName(cityMap.get(feedback.getCityId()));
        response.setAddress(feedback.getAddress());
        response.setInformation(feedback.getInformation());
        response.setEstimatedGrade(feedback.getEstimatedGrade());
        response.setFeedbackDate(feedback.getAfDate());
        response.setFeedbackTime(feedback.getAfTime());
        response.setFeedbackDateTime(feedback.getAfDate() + " " + feedback.getAfTime());
        response.setGmId(feedback.getGmId());
        response.setAssignDate(feedback.getAssignDate());
        response.setAssignTime(feedback.getAssignTime());
        response.setState(feedback.getState());
        response.setStateLabel(stateLabel(feedback.getState()));
        response.setRemarks(feedback.getRemarks());
        return response;
    }

    private String stateLabel(Integer state) {
        if (state == null) {
            return "未知";
        }
        return switch (state) {
            case 0 -> "未指派";
            case 1 -> "已指派";
            case 2 -> "已确认";
            default -> "未知";
        };
    }
}
