package com.cinereserve;

import com.cinereserve.entity.*;
import com.cinereserve.repository.*;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional
class EntityRepositoryIntegrationTest {

    @Autowired
    private MovieRepository movieRepository;

    @Autowired
    private CinemaRepository cinemaRepository;

    @Autowired
    private SeatRepository seatRepository;

    @Autowired
    private ShowRepository showRepository;

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private UserRepository userRepository;

    @Test
    @DisplayName("Verify Movie entity and repository correctly maps existing records and JSON columns")
    void testMovieRepositoryMapping() {
        List<Movie> movies = movieRepository.findAll();
        assertFalse(movies.isEmpty(), "Movies should not be empty");
        assertEquals(16, movies.size(), "Should have exactly 16 movies");

        Optional<Movie> doctorStrangeOpt = movieRepository.findByTitleIgnoreCase("Doctor Strange");
        assertTrue(doctorStrangeOpt.isPresent(), "Doctor Strange should exist");
        Movie doctorStrange = doctorStrangeOpt.get();
        assertEquals("Action", doctorStrange.getGenre());
        assertNotNull(doctorStrange.getLanguages(), "Languages JSON should be deserialized");
        assertTrue(doctorStrange.getLanguages().contains("English"));
    }

    @Test
    @DisplayName("Verify Cinema, Seat, and Show mappings")
    void testCinemaSeatShowMapping() {
        List<Cinema> cinemas = cinemaRepository.findAll();
        assertEquals(5, cinemas.size(), "Should have 5 cinemas");

        Cinema amb = cinemaRepository.findByName("AMB Cinemas").orElse(null);
        assertNotNull(amb, "AMB Cinemas should exist");
        assertEquals("Gachibowli, Hyderabad", amb.getLocation());

        List<Seat> seats = seatRepository.findByCinemaId(amb.getId());
        assertFalse(seats.isEmpty(), "Seats should exist for AMB Cinemas");
        assertEquals(56, seats.size(), "Should have 56 seats for AMB Cinemas");

        Optional<Seat> seatA1 = seatRepository.findByCinemaIdAndSeatNumber(amb.getId(), "A1");
        assertTrue(seatA1.isPresent(), "Seat A1 should exist for AMB Cinemas");

        List<Show> shows = showRepository.findByCinemaId(amb.getId());
        assertFalse(shows.isEmpty(), "Shows should exist for AMB Cinemas");
    }

    @Test
    @DisplayName("Verify Booking and User repository mappings")
    void testBookingAndUserMapping() {
        List<User> users = userRepository.findAll();
        assertFalse(users.isEmpty(), "Users should exist");
        assertTrue(userRepository.existsByEmailIgnoreCase("sushanth123@gmail.com"));

        List<Booking> bookings = bookingRepository.findAll();
        assertFalse(bookings.isEmpty(), "Bookings should exist");

        Booking firstBooking = bookings.get(0);
        assertNotNull(firstBooking.getBookingId(), "Booking ID must exist");
        assertNotNull(firstBooking.getStatus(), "Status must exist");
    }
}
