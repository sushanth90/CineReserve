package com.cinereserve.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.OffsetDateTime;

@Entity
@Table(name = "\"Booking\"")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Booking {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "\"id\"")
    private Integer id;

    @Column(name = "\"bookingId\"", nullable = false, unique = true)
    private String bookingId;

    @Column(name = "\"userId\"")
    private Integer userId;

    @Column(name = "\"movieId\"", nullable = false)
    private Integer movieId;

    @Column(name = "\"cinemaId\"", nullable = false)
    private Integer cinemaId;

    @Column(name = "\"showId\"", nullable = false)
    private Integer showId;

    @Column(name = "\"seatId\"", nullable = false)
    private Integer seatId;

    @Column(name = "\"totalAmount\"", nullable = false)
    private Double totalAmount;

    @Column(name = "\"status\"", nullable = false)
    @Builder.Default
    private String status = "CONFIRMED";

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "\"userId\"", insertable = false, updatable = false)
    private User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "\"movieId\"", insertable = false, updatable = false)
    private Movie movie;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "\"cinemaId\"", insertable = false, updatable = false)
    private Cinema cinema;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "\"showId\"", insertable = false, updatable = false)
    private Show show;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "\"seatId\"", insertable = false, updatable = false)
    private Seat seat;

    @CreationTimestamp
    @Column(name = "\"createdAt\"", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "\"updatedAt\"")
    private OffsetDateTime updatedAt;
}
