package com.cinereserve.controller;

import com.cinereserve.dto.MovieDto;
import com.cinereserve.service.MovieService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/movies")
public class MovieController {

    private final MovieService movieService;

    public MovieController(MovieService movieService) {
        this.movieService = movieService;
    }

    @GetMapping({"", "/"})
    public ResponseEntity<List<MovieDto>> getAllMovies(
            @RequestParam(required = false) String genre) {
        if (genre != null && !genre.isBlank() && !"All".equalsIgnoreCase(genre)) {
            return ResponseEntity.ok(movieService.getMoviesByGenre(genre));
        }
        return ResponseEntity.ok(movieService.getAllMovies());
    }

    @GetMapping("/{id}")
    public ResponseEntity<MovieDto> getMovieById(@PathVariable Integer id) {
        return ResponseEntity.ok(movieService.getMovieById(id));
    }
}
