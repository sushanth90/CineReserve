package com.cinereserve.service;

import com.cinereserve.dto.ShowDto;
import com.cinereserve.entity.Show;
import com.cinereserve.exception.ResourceNotFoundException;
import com.cinereserve.repository.ShowRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ShowService {

    private static final Logger log = LoggerFactory.getLogger(ShowService.class);

    private final ShowRepository showRepository;

    public ShowService(ShowRepository showRepository) {
        this.showRepository = showRepository;
    }

    @Transactional(readOnly = true)
    public List<ShowDto> getAllShows(Integer movieId, Integer cinemaId, String date) {
        log.info("Fetching shows with filters - movieId: {}, cinemaId: {}, date: {}", movieId, cinemaId, date);

        List<Show> shows = showRepository.findAll();

        return shows.stream()
                .filter(show -> movieId == null || show.getMovieId().equals(movieId))
                .filter(show -> cinemaId == null || show.getCinemaId().equals(cinemaId))
                .filter(show -> date == null || date.isBlank() || show.getDate().equalsIgnoreCase(date.trim()))
                .map(this::toDto)
                .toList();
    }

    @Transactional(readOnly = true)
    public ShowDto getShowById(Integer id) {
        log.info("Fetching show with ID: {}", id);
        Show show = showRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Show not found with ID: " + id));
        return toDto(show);
    }

    private ShowDto toDto(Show show) {
        return ShowDto.builder()
                .id(show.getId())
                .movieId(show.getMovieId())
                .cinemaId(show.getCinemaId())
                .date(show.getDate())
                .time(show.getTime())
                .format(show.getFormat())
                .build();
    }
}
