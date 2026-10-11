package com.cinereserve.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MyBookingDto {
    private Integer id;
    private String bookingId;
    private Integer userId;
    private Integer movieId;
    private Integer cinemaId;
    private Integer showId;
    private Integer seatId;
    private Double totalAmount;
    private String status;
    private String seatNumber;
    private String movieName;
    private String cinemaName;
    private String showDate;
    private String showTime;
}
