package com.networker.dto;

import com.networker.entity.AqiFeedback;
import lombok.Data;

@Data
public class FeedbackDTO {
    private Integer afId;
    private String telId;
    private Integer provinceId;
    private String provinceName;
    private Integer cityId;
    private String cityName;
    private String address;
    private String information;
    private Integer estimatedGrade;
    private String afDate;
    private String afTime;
    private String gmId;
    private String assignDate;
    private String assignTime;
    private Integer state;
    private String remarks;

    public static FeedbackDTO fromEntity(AqiFeedback feedback, String provinceName, String cityName) {
        FeedbackDTO dto = new FeedbackDTO();
        dto.setAfId(feedback.getAfId());
        dto.setTelId(feedback.getTelId());
        dto.setProvinceId(feedback.getProvinceId());
        dto.setProvinceName(provinceName);
        dto.setCityId(feedback.getCityId());
        dto.setCityName(cityName);
        dto.setAddress(feedback.getAddress());
        dto.setInformation(feedback.getInformation());
        dto.setEstimatedGrade(feedback.getEstimatedGrade());
        dto.setAfDate(feedback.getAfDate() != null ? feedback.getAfDate().toString() : null);
        dto.setAfTime(feedback.getAfTime());
        dto.setGmId(feedback.getGmId());
        dto.setAssignDate(feedback.getAssignDate() != null ? feedback.getAssignDate().toString() : null);
        dto.setAssignTime(feedback.getAssignTime());
        dto.setState(feedback.getState());
        dto.setRemarks(feedback.getRemarks());
        return dto;
    }
}
