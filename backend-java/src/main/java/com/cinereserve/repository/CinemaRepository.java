package com.cinereserve.repository;

import com.cinereserve.entity.Cinema;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface CinemaRepository extends JpaRepository<Cinema, Integer> {
    Optional<Cinema> findByName(String name);
    Optional<Cinema> findByNameIgnoreCase(String name);
}
