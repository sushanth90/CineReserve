package com.cinereserve.service;

import com.cinereserve.dto.CinemaDto;
import com.cinereserve.entity.Cinema;
import com.cinereserve.exception.ResourceNotFoundException;
import com.cinereserve.repository.CinemaRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class CinemaService {

    private static final Logger log = LoggerFactory.getLogger(CinemaService.class);

    private final CinemaRepository cinemaRepository;

    public CinemaService(CinemaRepository cinemaRepository) {
        this.cinemaRepository = cinemaRepository;
    }

    @Transactional(readOnly = true)
    public List<CinemaDto> getAllCinemas() {
        log.info("Fetching all cinemas");
        return cinemaRepository.findAll().stream()
                .map(this::toDto)
                .toList();
    }

    @Transactional(readOnly = true)
    public CinemaDto getCinemaById(Integer id) {
        log.info("Fetching cinema with ID: {}", id);
        Cinema cinema = cinemaRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Cinema not found with ID: " + id));
        return toDto(cinema);
    }

    @Transactional(readOnly = true)
    public CinemaDto getCinemaByName(String name) {
        log.info("Fetching cinema with name: {}", name);
        Cinema cinema = cinemaRepository.findByNameIgnoreCase(name.trim())
                .orElseThrow(() -> new ResourceNotFoundException("Cinema not found with name: " + name));
        return toDto(cinema);
    }

    private CinemaDto toDto(Cinema cinema) {
        return CinemaDto.builder()
                .id(cinema.getId())
                .name(cinema.getName())
                .location(cinema.getLocation())
                .build();
    }
}
