package com.example.supervisorbackend.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class SupervisorResponse {

    private String telId;
    private String phone;
    private String realName;
    private Integer age;
    private Integer sex;
    private String birthday;
}
