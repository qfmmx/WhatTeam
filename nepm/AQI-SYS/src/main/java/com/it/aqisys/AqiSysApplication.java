package com.it.aqisys;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.it.aqisys.mapper")
public class AqiSysApplication {
    public static void main(String[] args) {
        SpringApplication.run(AqiSysApplication.class, args);
    }
}
