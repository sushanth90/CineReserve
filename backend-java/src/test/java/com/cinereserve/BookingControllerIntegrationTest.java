package com.cinereserve;

import com.cinereserve.dto.BookingRequest;
import com.cinereserve.dto.CancelBookingRequest;
import com.cinereserve.entity.Cinema;
import com.cinereserve.entity.Movie;
import com.cinereserve.entity.Show;
import com.cinereserve.repository.CinemaRepository;
import com.cinereserve.repository.MovieRepository;
import com.cinereserve.repository.ShowRepository;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@Transactional
class BookingControllerIntegrationTest {

    @Autowired
    private MockMvc mockMvc;

    @Autowired
    private ObjectMapper objectMapper;

    @Autowired
    private ShowRepository showRepository;

    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private CinemaRepository cinemaRepository;

    @Test
    @DisplayName("Occupied Seats: returns occupied seats list for valid movie, cinema, date, and time")
    void testGetOccupiedSeats() throws Exception {
        List<Show> shows = showRepository.findAll();
        org.junit.jupiter.api.Assumptions.assumeFalse(shows.isEmpty());

        Show show = shows.get(0);
        Movie movie = movieRepository.findById(show.getMovieId()).orElseThrow();
        Cinema cinema = cinemaRepository.findById(show.getCinemaId()).orElseThrow();

        mockMvc.perform(get("/api/bookings/occupied")
                        .param("movie", movie.getTitle())
                        .param("cinema", cinema.getName())
                        .param("date", show.getDate())
                        .param("time", show.getTime())
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.occupiedSeats", notNullValue()));
    }

    @Test
    @DisplayName("Create Booking, Verify, and Cancel workflow")
    void testBookingLifecycle_CreateVerifyCancel() throws Exception {
        List<Show> shows = showRepository.findAll();
        org.junit.jupiter.api.Assumptions.assumeFalse(shows.isEmpty());

        Show show = shows.get(0);
        Movie movie = movieRepository.findById(show.getMovieId()).orElseThrow();
        Cinema cinema = cinemaRepository.findById(show.getCinemaId()).orElseThrow();

        String uniqueBookingRef = "CR998877";

        // 1. Create booking for seat G7
        BookingRequest bookingRequest = BookingRequest.builder()
                .bookingId(uniqueBookingRef)
                .userId(1)
                .movie(movie.getTitle())
                .cinema(cinema.getName())
                .date(show.getDate())
                .time(show.getTime())
                .seats(List.of("G7"))
                .totalAmount(250.0)
                .build();

        mockMvc.perform(post("/api/bookings")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(bookingRequest)))
                .andExpect(status().isCreated())
                .andExpect(jsonPath("$.message", is("Booking saved successfully")))
                .andExpect(jsonPath("$.bookings", hasSize(1)))
                .andExpect(jsonPath("$.bookings[0].bookingId", is(uniqueBookingRef + "-G7")));

        // 2. Prevent duplicate booking for same seat & show (Conflict 409)
        mockMvc.perform(post("/api/bookings")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(bookingRequest)))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.message", containsString("already booked")));

        // 3. Verify ticket
        mockMvc.perform(get("/api/bookings/verify/" + uniqueBookingRef))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.verified", is(true)))
                .andExpect(jsonPath("$.movieName", is(movie.getTitle())))
                .andExpect(jsonPath("$.cinemaName", is(cinema.getName())))
                .andExpect(jsonPath("$.seatNumbers", containsString("G7")));

        // 4. Cancel booking
        CancelBookingRequest cancelRequest = CancelBookingRequest.builder()
                .bookingId(uniqueBookingRef)
                .build();

        mockMvc.perform(post("/api/bookings/cancel")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(objectMapper.writeValueAsString(cancelRequest)))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.message", containsString("Booking cancelled successfully")));

        // 5. Verification after cancel returns 409 Conflict with message
        mockMvc.perform(get("/api/bookings/verify/" + uniqueBookingRef))
                .andExpect(status().isConflict())
                .andExpect(jsonPath("$.verified", is(false)))
                .andExpect(jsonPath("$.message", containsString("cancelled")));
    }

    @Test
    @DisplayName("GET /api/bookings/my/{userId}: returns user booking history")
    void testGetUserBookings() throws Exception {
        mockMvc.perform(get("/api/bookings/my/1")
                        .contentType(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$", notNullValue()));
    }
}
