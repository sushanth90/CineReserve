package com.cinereserve.service;

import com.cinereserve.dto.MovieDto;
import com.cinereserve.entity.Movie;
import com.cinereserve.exception.ResourceNotFoundException;
import com.cinereserve.repository.MovieRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MovieService {

    private static final Logger log = LoggerFactory.getLogger(MovieService.class);

    private final MovieRepository movieRepository;

    public MovieService(MovieRepository movieRepository) {
        this.movieRepository = movieRepository;
    }

    @Transactional(readOnly = true)
    public List<MovieDto> getAllMovies() {
        log.info("Fetching all movies");
        return movieRepository.findAll().stream()
                .map(this::toDto)
                .toList();
    }

    @Transactional(readOnly = true)
    public MovieDto getMovieById(Integer id) {
        log.info("Fetching movie with ID: {}", id);
        Movie movie = movieRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Movie not found with ID: " + id));
        return toDto(movie);
    }

    @Transactional(readOnly = true)
    public MovieDto getMovieByTitle(String title) {
        log.info("Fetching movie with title: {}", title);
        Movie movie = movieRepository.findByTitleIgnoreCase(title.trim())
                .orElseThrow(() -> new ResourceNotFoundException("Movie not found with title: " + title));
        return toDto(movie);
    }

    @Transactional(readOnly = true)
    public List<MovieDto> getMoviesByGenre(String genre) {
        log.info("Fetching movies with genre: {}", genre);
        return movieRepository.findByGenreIgnoreCase(genre.trim()).stream()
                .map(this::toDto)
                .toList();
    }

    private MovieDto toDto(Movie movie) {
        return MovieDto.builder()
                .id(movie.getId())
                .title(movie.getTitle())
                .genre(movie.getGenre())
                .rating(movie.getRating())
                .duration(movie.getDuration())
                .description(movie.getDescription())
                .image(movie.getImage())
                .languages(movie.getLanguages())
                .cinemas(movie.getCinemas())
                .build();
    }
}
