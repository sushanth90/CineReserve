package com.cinereserve.repository;

import com.cinereserve.entity.Booking;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface BookingRepository extends JpaRepository<Booking, Integer> {
    List<Booking> findByShowId(Integer showId);
    List<Booking> findByShowIdAndSeatId(Integer showId, Integer seatId);
    boolean existsByShowIdAndSeatIdAndStatus(Integer showId, Integer seatId, String status);

    Optional<Booking> findByBookingId(String bookingId);

    @Query("SELECT b FROM Booking b WHERE b.bookingId = :bookingId OR b.bookingId LIKE CONCAT(:bookingId, '-%')")
    List<Booking> findByBookingIdOrPrefix(@Param("bookingId") String bookingId);

    List<Booking> findByUserId(Integer userId);
    List<Booking> findByUserIdOrderByIdDesc(Integer userId);
}
