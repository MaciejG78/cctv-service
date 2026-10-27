package com.example.cctvservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
@PropertySource("classpath:application-${spring.profiles.active}.properties")
public class CctvServiceApplication {

    static void main(String[] args) {
        SpringApplication.run(CctvServiceApplication.class, args);
    }

}
