package com.example.supervisorbackend.dto;

import lombok.Data;

@Data
public class AqiFeedbackResponse {

    private Integer id;
    private String telId;
    private Integer provinceId;
    private String provinceName;
    private Integer cityId;
    private String cityName;
    private String address;
    private String information;
    private Integer estimatedGrade;
    private String feedbackDate;
    private String feedbackTime;
    private String feedbackDateTime;
    private Integer gmId;
    private String assignDate;
    private String assignTime;
    private Integer state;
    private String stateLabel;
    private String remarks;
}
