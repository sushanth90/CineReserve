package com.cinereserve.dto;

import com.fasterxml.jackson.annotation.JsonSetter;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class BookingRequest {

    private String bookingId;

    private Integer userId;

    @NotBlank(message = "Movie title is required.")
    private String movie;

    @NotBlank(message = "Cinema name is required.")
    private String cinema;

    @NotBlank(message = "Show date is required.")
    private String date;

    @NotBlank(message = "Show time is required.")
    private String time;

    @NotEmpty(message = "At least one seat must be selected.")
    @Builder.Default
    private List<String> seats = new ArrayList<>();

    private Double totalAmount;

    @JsonSetter("seats")
    public void setSeatsFromJson(Object value) {
        if (value instanceof List<?> list) {
            this.seats = list.stream().map(Object::toString).toList();
        } else if (value instanceof String str) {
            this.seats = Arrays.stream(str.split(","))
                    .map(String::trim)
                    .filter(s -> !s.isEmpty())
                    .toList();
        }
    }
}
