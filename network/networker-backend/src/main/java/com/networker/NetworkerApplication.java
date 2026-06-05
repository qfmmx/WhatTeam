package com.networker;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.networker.mapper")
public class NetworkerApplication {

    public static void main(String[] args) {
        SpringApplication.run(NetworkerApplication.class, args);
    }
}
