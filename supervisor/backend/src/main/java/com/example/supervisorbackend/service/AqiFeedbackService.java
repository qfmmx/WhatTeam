package com.example.supervisorbackend.service;

import com.example.supervisorbackend.dto.AqiFeedbackResponse;
import com.example.supervisorbackend.dto.AqiFeedbackSaveRequest;

import java.util.List;

public interface AqiFeedbackService {

    boolean saveFeedback(AqiFeedbackSaveRequest request);

    List<AqiFeedbackResponse> listByTel(String telId);

    AqiFeedbackResponse getById(Integer id);
}
