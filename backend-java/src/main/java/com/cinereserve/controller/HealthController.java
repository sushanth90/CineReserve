package com.cinereserve.controller;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class HealthController {

    private final JdbcTemplate jdbcTemplate;

    public HealthController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @GetMapping("/")
    public Map<String, Object> root() {
        return Map.of(
            "status", "UP",
            "service", "CineReserve Java Spring Boot Backend",
            "message", "CineReserve Backend is running!"
        );
    }

    @GetMapping("/api/health")
    public Map<String, String> health() {
        return Map.of("status", "UP");
    }

    @GetMapping("/api/health/db")
    public Map<String, Object> databaseHealth() {
        Map<String, Object> response = new HashMap<>();
        try {
            String dbVersion = jdbcTemplate.queryForObject("SELECT version()", String.class);
            response.put("status", "UP");
            response.put("database", "PostgreSQL");
            response.put("version", dbVersion);

            Map<String, Integer> tableCounts = new HashMap<>();
            List<String> tables = List.of("User", "Movie", "Cinema", "Seat", "Show", "Booking");
            for (String table : tables) {
                Integer count = jdbcTemplate.queryForObject(
                    "SELECT count(*) FROM \"" + table + "\"", 
                    Integer.class
                );
                tableCounts.put(table, count);
            }
            response.put("tableCounts", tableCounts);
        } catch (Exception e) {
            response.put("status", "DOWN");
            response.put("error", e.getMessage());
        }
        return response;
    }
}
