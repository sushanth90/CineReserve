package com.cinereserve.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class MovieDto {
    private Integer id;
    private String title;
    private String genre;
    private String rating;
    private String duration;
    private String description;
    private String image;
    private List<String> languages;
    private List<String> cinemas;
}
