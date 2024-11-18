package com.example.demo.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

@RestController
public class HealthController {

    @GetMapping("/health")
    public ResponseEntity<Map<String, Object>> healthCheck() throws UnknownHostException {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "OK");
        response.put("message", "User Service is healthy");
        response.put("ipAddress", InetAddress.getLocalHost().getHostAddress());
        response.put("timestamp", LocalDateTime.now());

        return ResponseEntity.ok(response);
    }

}
