package com.cinereserve.repository;

import com.cinereserve.entity.Show;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface ShowRepository extends JpaRepository<Show, Integer> {
    Optional<Show> findByMovieIdAndCinemaIdAndDateAndTime(Integer movieId, Integer cinemaId, String date, String time);
    List<Show> findByMovieId(Integer movieId);
    List<Show> findByCinemaId(Integer cinemaId);
    List<Show> findByDate(String date);
}
