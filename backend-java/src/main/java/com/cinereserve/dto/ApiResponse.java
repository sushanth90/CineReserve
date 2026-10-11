package com.cinereserve.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ApiResponse {
    private String message;
    private boolean success;

    public static ApiResponse success(String message) {
        return new ApiResponse(message, true);
    }

    public static ApiResponse error(String message) {
        return new ApiResponse(message, false);
    }
}
