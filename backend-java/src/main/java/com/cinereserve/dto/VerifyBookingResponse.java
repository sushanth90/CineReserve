package com.cinereserve.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
@JsonInclude(JsonInclude.Include.NON_NULL)
public class VerifyBookingResponse {
    private boolean verified;
    private String message;
    private String bookingId;
    private Integer seats;
    private String movieName;
    private String cinemaName;
    private String cinemaLocation;
    private String showDate;
    private String showTime;
    private String format;
    private String seatNumbers;
    private String seatNumber;
    private Double totalAmount;
    private String status;
}
