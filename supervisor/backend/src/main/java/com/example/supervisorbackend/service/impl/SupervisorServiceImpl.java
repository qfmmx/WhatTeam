package com.example.supervisorbackend.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.example.supervisorbackend.dto.SupervisorLoginRequest;
import com.example.supervisorbackend.dto.SupervisorRegisterRequest;
import com.example.supervisorbackend.dto.SupervisorResponse;
import com.example.supervisorbackend.entity.Supervisor;
import com.example.supervisorbackend.mapper.SupervisorMapper;
import com.example.supervisorbackend.service.SupervisorService;
import com.example.supervisorbackend.util.AgeUtil;
import org.springframework.stereotype.Service;

@Service
public class SupervisorServiceImpl implements SupervisorService {

    private final SupervisorMapper supervisorMapper;

    public SupervisorServiceImpl(SupervisorMapper supervisorMapper) {
        this.supervisorMapper = supervisorMapper;
    }

    @Override
    public Supervisor findByPhone(String phone) {
        return supervisorMapper.selectById(phone);
    }

    @Override
    public boolean register(SupervisorRegisterRequest request) {
        if (findByPhone(request.getPhone()) != null) {
            return false;
        }
        if (request.getSex() == null || (request.getSex() != 0 && request.getSex() != 1)) {
            throw new IllegalArgumentException("性别取值必须为0或1");
        }
        Supervisor supervisor = new Supervisor();
        supervisor.setTelId(request.getPhone());
        supervisor.setPassword(request.getPassword());
        supervisor.setRealName(request.getRealName());
        supervisor.setBirthday(AgeUtil.ageToBirthday(request.getAge()));
        supervisor.setSex(request.getSex());
        return supervisorMapper.insert(supervisor) > 0;
    }

    @Override
    public Supervisor login(SupervisorLoginRequest request) {
        return supervisorMapper.selectOne(new LambdaQueryWrapper<Supervisor>()
                .eq(Supervisor::getTelId, request.getPhone())
                .eq(Supervisor::getPassword, request.getPassword())
                .last("limit 1"));
    }

    @Override
    public SupervisorResponse toResponse(Supervisor supervisor) {
        if (supervisor == null) {
            return null;
        }
        return new SupervisorResponse(
                supervisor.getTelId(),
                supervisor.getTelId(),
                supervisor.getRealName(),
                AgeUtil.birthdayToAge(supervisor.getBirthday()),
                supervisor.getSex(),
                supervisor.getBirthday()
        );
    }
}
