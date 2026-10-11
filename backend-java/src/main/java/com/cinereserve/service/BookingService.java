package com.cinereserve.service;

import com.cinereserve.dto.*;
import com.cinereserve.entity.*;
import com.cinereserve.exception.BadRequestException;
import com.cinereserve.exception.ConflictException;
import com.cinereserve.exception.ResourceNotFoundException;
import com.cinereserve.repository.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.*;
import java.util.concurrent.ThreadLocalRandom;
import java.util.stream.Collectors;

@Service
public class BookingService {

    private static final Logger log = LoggerFactory.getLogger(BookingService.class);

    private final BookingRepository bookingRepository;
    private final MovieRepository movieRepository;
    private final CinemaRepository cinemaRepository;
    private final ShowRepository showRepository;
    private final SeatRepository seatRepository;
    private final UserRepository userRepository;

    public BookingService(BookingRepository bookingRepository,
                          MovieRepository movieRepository,
                          CinemaRepository cinemaRepository,
                          ShowRepository showRepository,
                          SeatRepository seatRepository,
                          UserRepository userRepository) {
        this.bookingRepository = bookingRepository;
        this.movieRepository = movieRepository;
        this.cinemaRepository = cinemaRepository;
        this.showRepository = showRepository;
        this.seatRepository = seatRepository;
        this.userRepository = userRepository;
    }

    @Transactional(readOnly = true)
    public OccupiedSeatsResponse getOccupiedSeats(String movieTitle, String cinemaName, String date, String time) {
        log.info("Fetching occupied seats for movie='{}', cinema='{}', date='{}', time='{}'",
                movieTitle, cinemaName, date, time);

        Movie movie = movieRepository.findByTitleIgnoreCase(movieTitle.trim())
                .orElseThrow(() -> new ResourceNotFoundException("Movie not found: " + movieTitle));

        Cinema cinema = cinemaRepository.findByNameIgnoreCase(cinemaName.trim())
                .orElseThrow(() -> new ResourceNotFoundException("Cinema not found: " + cinemaName));

        Show show = showRepository.findByMovieIdAndCinemaIdAndDateAndTime(
                movie.getId(), cinema.getId(), date.trim(), time.trim())
                .orElseThrow(() -> new ResourceNotFoundException("Show not found for the selected movie, cinema, date, and time."));

        List<Booking> bookings = bookingRepository.findByShowId(show.getId());

        List<Integer> occupiedSeatIds = bookings.stream()
                .filter(b -> "CONFIRMED".equalsIgnoreCase(b.getStatus()))
                .map(Booking::getSeatId)
                .toList();

        if (occupiedSeatIds.isEmpty()) {
            return new OccupiedSeatsResponse(Collections.emptyList());
        }

        List<Seat> seats = seatRepository.findByIdIn(occupiedSeatIds);
        List<String> occupiedSeatNumbers = seats.stream()
                .map(Seat::getSeatNumber)
                .distinct()
                .sorted()
                .toList();

        return new OccupiedSeatsResponse(occupiedSeatNumbers);
    }

    @Transactional(isolation = Isolation.REPEATABLE_READ)
    public BookingResponse createBooking(BookingRequest request, Principal principal) {
        log.info("Creating booking for movie='{}', cinema='{}', seats={}",
                request.getMovie(), request.getCinema(), request.getSeats());

        if (request.getSeats() == null || request.getSeats().isEmpty()) {
            throw new BadRequestException("At least one seat must be selected.");
        }

        Movie movie = movieRepository.findByTitleIgnoreCase(request.getMovie().trim())
                .orElseThrow(() -> new ResourceNotFoundException("Movie not found: " + request.getMovie()));

        Cinema cinema = cinemaRepository.findByNameIgnoreCase(request.getCinema().trim())
                .orElseThrow(() -> new ResourceNotFoundException("Cinema not found: " + request.getCinema()));

        Show show = showRepository.findByMovieIdAndCinemaIdAndDateAndTime(
                movie.getId(), cinema.getId(), request.getDate().trim(), request.getTime().trim())
                .orElseThrow(() -> new ResourceNotFoundException("Show not found for selected date and time."));

        // Determine user identity
        Integer userId = null;
        if (principal != null) {
            Optional<User> authUser = userRepository.findByEmailIgnoreCase(principal.getName());
            if (authUser.isPresent()) {
                userId = authUser.get().getId();
            }
        }
        if (userId == null && request.getUserId() != null && request.getUserId() > 0) {
            userId = request.getUserId();
        }

        // Generate base booking reference if not provided
        String baseBookingId = (request.getBookingId() != null && !request.getBookingId().isBlank())
                ? request.getBookingId().trim()
                : "CR" + ThreadLocalRandom.current().nextInt(100000, 999999);

        // Calculate and validate amounts
        int seatCount = request.getSeats().size();
        double totalAmount = request.getTotalAmount() != null && request.getTotalAmount() > 0
                ? request.getTotalAmount()
                : (seatCount * 250.0);

        List<Seat> seatsToBook = new ArrayList<>();
        for (String seatNumber : request.getSeats()) {
            String cleanSeat = seatNumber.trim();
            Seat seat = seatRepository.findByCinemaIdAndSeatNumber(cinema.getId(), cleanSeat)
                    .orElseThrow(() -> new ResourceNotFoundException("Seat " + cleanSeat + " not found in cinema " + cinema.getName()));

            boolean alreadyBooked = bookingRepository.existsByShowIdAndSeatIdAndStatus(show.getId(), seat.getId(), "CONFIRMED");
            if (alreadyBooked) {
                throw new ConflictException("Seat " + cleanSeat + " is already booked.");
            }

            seatsToBook.add(seat);
        }

        List<Booking> createdBookings = new ArrayList<>();
        for (Seat seat : seatsToBook) {
            String itemBookingId = baseBookingId + "-" + seat.getSeatNumber();

            Booking booking = Booking.builder()
                    .bookingId(itemBookingId)
                    .userId(userId)
                    .movieId(movie.getId())
                    .cinemaId(cinema.getId())
                    .showId(show.getId())
                    .seatId(seat.getId())
                    .totalAmount(totalAmount)
                    .status("CONFIRMED")
                    .build();

            createdBookings.add(bookingRepository.save(booking));
        }

        log.info("Successfully booked {} seat(s) under base booking reference: {}", seatCount, baseBookingId);

        List<BookingItemDto> bookingDtos = createdBookings.stream()
                .map(this::toItemDto)
                .toList();

        return BookingResponse.builder()
                .message("Booking saved successfully")
                .bookings(bookingDtos)
                .build();
    }

    @Transactional
    public CancelBookingResponse cancelBooking(CancelBookingRequest request) {
        String bookingId = request.getBookingId().trim();
        log.info("Attempting cancellation for booking reference: {}", bookingId);

        List<Booking> matchingBookings = bookingRepository.findByBookingIdOrPrefix(bookingId);

        if (matchingBookings.isEmpty()) {
            throw new ResourceNotFoundException("Booking not found: " + bookingId);
        }

        boolean allCancelled = matchingBookings.stream()
                .allMatch(b -> "CANCELLED".equalsIgnoreCase(b.getStatus()));

        if (allCancelled) {
            throw new BadRequestException("This booking is already cancelled.");
        }

        for (Booking booking : matchingBookings) {
            booking.setStatus("CANCELLED");
            bookingRepository.save(booking);
        }

        log.info("Cancelled {} booking record(s) for booking reference: {}", matchingBookings.size(), bookingId);

        return CancelBookingResponse.builder()
                .message("Booking cancelled successfully.")
                .bookingId(bookingId)
                .build();
    }

    @Transactional(readOnly = true)
    public VerifyBookingResponse verifyTicket(String bookingId) {
        log.info("Verifying ticket for booking ID: {}", bookingId);

        if (bookingId == null || bookingId.isBlank()) {
            return VerifyBookingResponse.builder()
                    .verified(false)
                    .message("Invalid ticket: booking ID is missing.")
                    .build();
        }

        List<Booking> matchingBookings = bookingRepository.findByBookingIdOrPrefix(bookingId.trim());

        if (matchingBookings.isEmpty()) {
            return VerifyBookingResponse.builder()
                    .verified(false)
                    .message("Booking not found.")
                    .bookingId(bookingId)
                    .build();
        }

        boolean anyCancelled = matchingBookings.stream()
                .anyMatch(b -> "CANCELLED".equalsIgnoreCase(b.getStatus()));

        if (anyCancelled) {
            return VerifyBookingResponse.builder()
                    .verified(false)
                    .message("This booking has been cancelled.")
                    .bookingId(bookingId)
                    .status("CANCELLED")
                    .build();
        }

        Booking sample = matchingBookings.get(0);
        Movie movie = movieRepository.findById(sample.getMovieId()).orElse(null);
        Cinema cinema = cinemaRepository.findById(sample.getCinemaId()).orElse(null);
        Show show = showRepository.findById(sample.getShowId()).orElse(null);

        List<Integer> seatIds = matchingBookings.stream().map(Booking::getSeatId).toList();
        List<Seat> seats = seatRepository.findByIdIn(seatIds);
        List<String> seatNumbers = seats.stream().map(Seat::getSeatNumber).sorted().toList();
        String seatNumbersStr = String.join(", ", seatNumbers);

        return VerifyBookingResponse.builder()
                .verified(true)
                .message("Booking verified successfully.")
                .bookingId(bookingId)
                .seats(matchingBookings.size())
                .movieName(movie != null ? movie.getTitle() : "Unknown Movie")
                .cinemaName(cinema != null ? cinema.getName() : "Unknown Cinema")
                .cinemaLocation(cinema != null ? cinema.getLocation() : "Unknown Location")
                .showDate(show != null ? show.getDate() : "Unknown Date")
                .showTime(show != null ? show.getTime() : "Unknown Time")
                .format(show != null ? show.getFormat() : "2D")
                .seatNumbers(seatNumbersStr)
                .seatNumber(seatNumbersStr)
                .totalAmount(sample.getTotalAmount())
                .status("CONFIRMED")
                .build();
    }

    @Transactional(readOnly = true)
    public List<MyBookingDto> getUserBookings(Integer userId) {
        log.info("Fetching booking history for user ID: {}", userId);

        if (userId == null || userId <= 0) {
            throw new BadRequestException("Invalid user ID");
        }

        List<Booking> bookings = bookingRepository.findByUserIdOrderByIdDesc(userId);

        Map<Integer, Movie> movieMap = movieRepository.findAll().stream()
                .collect(Collectors.toMap(Movie::getId, m -> m));

        Map<Integer, Cinema> cinemaMap = cinemaRepository.findAll().stream()
                .collect(Collectors.toMap(Cinema::getId, c -> c));

        Map<Integer, Show> showMap = showRepository.findAll().stream()
                .collect(Collectors.toMap(Show::getId, s -> s));

        Map<Integer, Seat> seatMap = seatRepository.findAll().stream()
                .collect(Collectors.toMap(Seat::getId, s -> s));

        return bookings.stream().map(booking -> {
            Movie movie = movieMap.get(booking.getMovieId());
            Cinema cinema = cinemaMap.get(booking.getCinemaId());
            Show show = showMap.get(booking.getShowId());
            Seat seat = seatMap.get(booking.getSeatId());

            return MyBookingDto.builder()
                    .id(booking.getId())
                    .bookingId(booking.getBookingId())
                    .userId(booking.getUserId())
                    .movieId(booking.getMovieId())
                    .cinemaId(booking.getCinemaId())
                    .showId(booking.getShowId())
                    .seatId(booking.getSeatId())
                    .totalAmount(booking.getTotalAmount())
                    .status(booking.getStatus())
                    .seatNumber(seat != null ? seat.getSeatNumber() : "Unknown")
                    .movieName(movie != null ? movie.getTitle() : null)
                    .cinemaName(cinema != null ? cinema.getName() : null)
                    .showDate(show != null ? show.getDate() : null)
                    .showTime(show != null ? show.getTime() : null)
                    .build();
        }).toList();
    }

    private BookingItemDto toItemDto(Booking booking) {
        return BookingItemDto.builder()
                .id(booking.getId())
                .bookingId(booking.getBookingId())
                .userId(booking.getUserId())
                .movieId(booking.getMovieId())
                .cinemaId(booking.getCinemaId())
                .showId(booking.getShowId())
                .seatId(booking.getSeatId())
                .totalAmount(booking.getTotalAmount())
                .status(booking.getStatus())
                .build();
    }
}
