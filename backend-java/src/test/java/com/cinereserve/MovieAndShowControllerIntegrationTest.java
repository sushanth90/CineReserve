package com.cinereserve;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@Transactional
class MovieAndShowControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("GET /api/movies: returns all movies in database")
    void testGetAllMovies() throws Exception {
        mockMvc.perform(get("/api/movies")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(greaterThanOrEqualTo(1))))
                .andExpect(jsonPath("$[0].title", notNullValue()))
                .andExpect(jsonPath("$[0].genre", notNullValue()));
    }

    @Test
    @DisplayName("GET /api/movies/: returns movies when trailing slash is used")
    void testGetAllMoviesTrailingSlash() throws Exception {
        mockMvc.perform(get("/api/movies/")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(greaterThanOrEqualTo(1))));
    }

    @Test
    @DisplayName("GET /api/shows: returns showtimes")
    void testGetAllShows() throws Exception {
        mockMvc.perform(get("/api/shows")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(greaterThanOrEqualTo(1))))
                .andExpect(jsonPath("$[0].movieId", notNullValue()))
                .andExpect(jsonPath("$[0].cinemaId", notNullValue()))
                .andExpect(jsonPath("$[0].date", notNullValue()))
                .andExpect(jsonPath("$[0].time", notNullValue()));
    }

    @Test
    @DisplayName("GET /api/cinemas: returns cinema halls")
    void testGetAllCinemas() throws Exception {
        mockMvc.perform(get("/api/cinemas")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", hasSize(greaterThanOrEqualTo(1))))
                .andExpect(jsonPath("$[0].name", notNullValue()))
                .andExpect(jsonPath("$[0].location", notNullValue()));
    }
}
