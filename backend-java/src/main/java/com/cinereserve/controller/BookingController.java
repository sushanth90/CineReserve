package com.cinereserve.controller;

import com.cinereserve.dto.*;
import com.cinereserve.service.BookingService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;

@RestController
@RequestMapping("/api/bookings")
public class BookingController {

    private final BookingService bookingService;

    public BookingController(BookingService bookingService) {
        this.bookingService = bookingService;
    }

    @GetMapping("/occupied")
    public ResponseEntity<OccupiedSeatsResponse> getOccupiedSeats(
            @RequestParam String movie,
            @RequestParam String cinema,
            @RequestParam String date,
            @RequestParam String time) {
        return ResponseEntity.ok(bookingService.getOccupiedSeats(movie, cinema, date, time));
    }

    @PostMapping({"", "/"})
    public ResponseEntity<BookingResponse> createBooking(
            @Valid @RequestBody BookingRequest request,
            Principal principal) {
        BookingResponse response = bookingService.createBooking(request, principal);
        return ResponseEntity.status(HttpStatus.CREATED).body(response);
    }

    @PostMapping("/cancel")
    public ResponseEntity<CancelBookingResponse> cancelBooking(
            @Valid @RequestBody CancelBookingRequest request) {
        CancelBookingResponse response = bookingService.cancelBooking(request);
        return ResponseEntity.ok(response);
    }

    @GetMapping("/verify/{bookingId}")
    public ResponseEntity<VerifyBookingResponse> verifyTicket(
            @PathVariable String bookingId) {
        VerifyBookingResponse response = bookingService.verifyTicket(bookingId);
        if (!response.isVerified()) {
            if ("CANCELLED".equalsIgnoreCase(response.getStatus())) {
                return ResponseEntity.status(HttpStatus.CONFLICT).body(response);
            }
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
        }
        return ResponseEntity.ok(response);
    }

    @GetMapping("/my/{userId}")
    public ResponseEntity<List<MyBookingDto>> getUserBookings(
            @PathVariable Integer userId) {
        return ResponseEntity.ok(bookingService.getUserBookings(userId));
    }
}
