package com.cinereserve.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ShowDto {
    private Integer id;
    private Integer movieId;
    private Integer cinemaId;
    private String date;
    private String time;
    private String format;
}
