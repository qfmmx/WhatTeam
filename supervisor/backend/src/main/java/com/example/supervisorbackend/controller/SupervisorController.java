package com.example.supervisorbackend.controller;

import com.example.supervisorbackend.common.ApiResponse;
import com.example.supervisorbackend.dto.SupervisorLoginRequest;
import com.example.supervisorbackend.dto.SupervisorRegisterRequest;
import com.example.supervisorbackend.dto.SupervisorResponse;
import com.example.supervisorbackend.entity.Supervisor;
import com.example.supervisorbackend.service.SupervisorService;
import jakarta.validation.Valid;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@Validated
@RequestMapping("/api/supervisor")
public class SupervisorController {

    private final SupervisorService supervisorService;

    public SupervisorController(SupervisorService supervisorService) {
        this.supervisorService = supervisorService;
    }

    @GetMapping("/checkPhone")
    public ApiResponse<SupervisorResponse> checkPhone(@RequestParam("phone") String phone) {
        Supervisor supervisor = supervisorService.findByPhone(phone);
        if (supervisor != null) {
            return ApiResponse.fail(409, "手机号已注册", supervisorService.toResponse(supervisor));
        }
        return ApiResponse.success("手机号可用", null);
    }

    @PostMapping("/register")
    public ApiResponse<Integer> register(@Valid @RequestBody SupervisorRegisterRequest request) {
        boolean success = supervisorService.register(request);
        if (!success) {
            return ApiResponse.fail(409, "手机号已注册", 0);
        }
        return ApiResponse.success("注册成功", 1);
    }

    @PostMapping("/login")
    public ApiResponse<SupervisorResponse> login(@Valid @RequestBody SupervisorLoginRequest request) {
        Supervisor supervisor = supervisorService.login(request);
        if (supervisor == null) {
            return ApiResponse.fail(401, "手机号或密码错误");
        }
        return ApiResponse.success("登录成功", supervisorService.toResponse(supervisor));
    }
}
