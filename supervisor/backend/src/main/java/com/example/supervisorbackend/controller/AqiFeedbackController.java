package com.example.supervisorbackend.controller;

import com.example.supervisorbackend.common.ApiResponse;
import com.example.supervisorbackend.dto.AqiFeedbackResponse;
import com.example.supervisorbackend.dto.AqiFeedbackSaveRequest;
import com.example.supervisorbackend.service.AqiFeedbackService;
import jakarta.validation.Valid;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@Validated
@RequestMapping("/api/aqiFeedback")
public class AqiFeedbackController {

    private final AqiFeedbackService aqiFeedbackService;

    public AqiFeedbackController(AqiFeedbackService aqiFeedbackService) {
        this.aqiFeedbackService = aqiFeedbackService;
    }

    @PostMapping("/save")
    public ApiResponse<Integer> save(@Valid @RequestBody AqiFeedbackSaveRequest request) {
        boolean success = aqiFeedbackService.saveFeedback(request);
        return ApiResponse.success("保存成功", success ? 1 : 0);
    }

    @GetMapping("/listByTel")
    public ApiResponse<List<AqiFeedbackResponse>> listByTel(@RequestParam(value = "telId", required = false) String telId,
                                                            @RequestParam(value = "phone", required = false) String phone) {
        String queryTel = telId != null && !telId.isBlank() ? telId : phone;
        if (queryTel == null || queryTel.isBlank()) {
            return ApiResponse.fail(400, "手机号不能为空");
        }
        return ApiResponse.success("查询成功", aqiFeedbackService.listByTel(queryTel));
    }

    @GetMapping("/{id}")
    public ApiResponse<AqiFeedbackResponse> getById(@PathVariable Integer id) {
        AqiFeedbackResponse response = aqiFeedbackService.getById(id);
        if (response == null) {
            return ApiResponse.fail(404, "反馈信息不存在");
        }
        return ApiResponse.success("查询成功", response);
    }
}
