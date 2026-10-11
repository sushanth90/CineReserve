package com.cinereserve.repository;

import com.cinereserve.entity.Seat;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface SeatRepository extends JpaRepository<Seat, Integer> {
    Optional<Seat> findByCinemaIdAndSeatNumber(Integer cinemaId, String seatNumber);
    List<Seat> findByCinemaId(Integer cinemaId);
    List<Seat> findByIdIn(List<Integer> ids);
}
