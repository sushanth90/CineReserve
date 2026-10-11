package com.cinereserve.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.JdbcTypeCode;
import org.hibernate.annotations.UpdateTimestamp;
import org.hibernate.type.SqlTypes;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "\"Movie\"")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "\"id\"")
    private Integer id;

    @Column(name = "\"title\"", nullable = false)
    private String title;

    @Column(name = "\"genre\"", nullable = false)
    private String genre;

    @Column(name = "\"rating\"")
    private String rating;

    @Column(name = "\"duration\"")
    private String duration;

    @Column(name = "\"description\"")
    private String description;

    @Column(name = "\"image\"")
    private String image;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "\"languages\"", columnDefinition = "json")
    private List<String> languages;

    @JdbcTypeCode(SqlTypes.JSON)
    @Column(name = "\"cinemas\"", columnDefinition = "json")
    private List<String> cinemas;

    @CreationTimestamp
    @Column(name = "\"createdAt\"", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "\"updatedAt\"")
    private OffsetDateTime updatedAt;

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @Builder.Default
    private List<Show> shows = new ArrayList<>();

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @Builder.Default
    private List<Booking> bookings = new ArrayList<>();
}
