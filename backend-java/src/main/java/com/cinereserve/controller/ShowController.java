package com.cinereserve.controller;

import com.cinereserve.dto.ShowDto;
import com.cinereserve.service.ShowService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/shows")
public class ShowController {

    private final ShowService showService;

    public ShowController(ShowService showService) {
        this.showService = showService;
    }

    @GetMapping({"", "/"})
    public ResponseEntity<List<ShowDto>> getAllShows(
            @RequestParam(required = false) Integer movieId,
            @RequestParam(required = false) Integer cinemaId,
            @RequestParam(required = false) String date) {
        return ResponseEntity.ok(showService.getAllShows(movieId, cinemaId, date));
    }

    @GetMapping("/{id}")
    public ResponseEntity<ShowDto> getShowById(@PathVariable Integer id) {
        return ResponseEntity.ok(showService.getShowById(id));
    }
}
