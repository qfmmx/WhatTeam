package com.networker.service;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.networker.common.PageResult;
import com.networker.dto.PageRequest;
import com.networker.entity.AqiFeedback;
import com.networker.mapper.AqiFeedbackMapper;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.time.LocalDate;

@Service
public class AqiFeedbackService extends ServiceImpl<AqiFeedbackMapper, AqiFeedback> {

    public PageResult<AqiFeedback> listPage(PageRequest request) {
        Page<AqiFeedback> page = new Page<>(request.getPageNum(), request.getPageSize());
        LambdaQueryWrapper<AqiFeedback> wrapper = new LambdaQueryWrapper<>();

        if (StringUtils.hasText(request.getKeyword())) {
            wrapper.like(AqiFeedback::getAddress, request.getKeyword())
                   .or()
                   .like(AqiFeedback::getInformation, request.getKeyword());
        }

        if (request.getProvinceId() != null) {
            wrapper.eq(AqiFeedback::getProvinceId, request.getProvinceId());
        }
        if (request.getCityId() != null) {
            wrapper.eq(AqiFeedback::getCityId, request.getCityId());
        }

        wrapper.orderByDesc(AqiFeedback::getAfDate);
        Page<AqiFeedback> result = this.page(page, wrapper);

        return PageResult.of(result.getTotal(), result.getRecords(), request.getPageNum(), request.getPageSize());
    }

    public PageResult<AqiFeedback> listByGmId(Integer gmId, PageRequest request) {
        Page<AqiFeedback> page = new Page<>(request.getPageNum(), request.getPageSize());
        LambdaQueryWrapper<AqiFeedback> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AqiFeedback::getState, 1)
               .eq(AqiFeedback::getGmId, gmId);

        wrapper.orderByDesc(AqiFeedback::getAfDate);
        Page<AqiFeedback> result = this.page(page, wrapper);

        return PageResult.of(result.getTotal(), result.getRecords(), request.getPageNum(), request.getPageSize());
    }

    public boolean saveFeedback(AqiFeedback feedback) {
        feedback.setAfDate(LocalDate.now().toString());
        feedback.setAfTime(java.time.LocalTime.now().toString());
        feedback.setState(0);
        return this.save(feedback);
    }

    public boolean assignFeedback(Integer afId, Integer gmId) {
        AqiFeedback feedback = this.getById(afId);
        if (feedback == null) return false;
        feedback.setGmId(gmId);
        feedback.setAssignDate(LocalDate.now().toString());
        feedback.setAssignTime(java.time.LocalTime.now().toString());
        feedback.setState(1);
        return this.updateById(feedback);
    }

    public boolean updateState(Integer afId, Integer state) {
        AqiFeedback feedback = this.getById(afId);
        if (feedback == null) return false;
        feedback.setState(state);
        return this.updateById(feedback);
    }

    public boolean submitMeasureData(Integer gmId, Integer afId, Integer so2, Double co, Integer pm25) {
        if (afId == null) return false;
        AqiFeedback feedback = this.getById(afId);
        if (feedback == null) return false;
        feedback.setState(2);
        return this.updateById(feedback);
    }
}