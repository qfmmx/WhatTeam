package com.networker.controller;

import com.networker.common.Result;
import com.networker.entity.GridMember;
import com.networker.service.GridMemberService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/api/gridMember")
@RequiredArgsConstructor
@CrossOrigin
public class GridMemberController {

    private final GridMemberService gridMemberService;

    @PostMapping("/login")
    public Result<GridMember> login(@RequestBody Map<String, String> loginData) {
        String loginCode = loginData.get("loginCode");
        String password = loginData.get("password");

        GridMember member = gridMemberService.login(loginCode, password);
        if (member == null) {
            return Result.error("登录失败，账号或密码错误");
        }
        member.setPassword(null);
        return Result.success(member);
    }
}