package com.example.supervisorbackend.dto;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Data;

@Data
public class AqiFeedbackSaveRequest {

    @NotBlank(message = "手机号不能为空")
    @Pattern(regexp = "^1\\d{10}$", message = "手机号格式不正确")
    private String telId;

    @NotNull(message = "省份不能为空")
    private Integer provinceId;

    @NotNull(message = "城市不能为空")
    private Integer cityId;

    @NotBlank(message = "详细地址不能为空")
    private String address;

    @NotBlank(message = "反馈信息不能为空")
    private String information;

    @NotNull(message = "AQI预估等级不能为空")
    @Min(value = 1, message = "AQI预估等级范围错误")
    @Max(value = 6, message = "AQI预估等级范围错误")
    private Integer estimatedGrade;
}
