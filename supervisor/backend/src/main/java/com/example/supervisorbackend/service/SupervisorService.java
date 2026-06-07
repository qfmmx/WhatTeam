package com.example.supervisorbackend.service;

import com.example.supervisorbackend.dto.SupervisorLoginRequest;
import com.example.supervisorbackend.dto.SupervisorRegisterRequest;
import com.example.supervisorbackend.dto.SupervisorResponse;
import com.example.supervisorbackend.entity.Supervisor;

public interface SupervisorService {

    Supervisor findByPhone(String phone);

    boolean register(SupervisorRegisterRequest request);

    Supervisor login(SupervisorLoginRequest request);

    SupervisorResponse toResponse(Supervisor supervisor);
}
