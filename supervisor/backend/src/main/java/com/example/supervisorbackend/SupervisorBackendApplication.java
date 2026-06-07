package com.example.supervisorbackend;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan("com.example.supervisorbackend.mapper")
@SpringBootApplication
public class SupervisorBackendApplication {

    public static void main(String[] args) {
        SpringApplication.run(SupervisorBackendApplication.class, args);
    }
}
