package com.cinereserve.entity;

import jakarta.persistence.*;
import lombok.*;
import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "\"Show\"")
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Show {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "\"id\"")
    private Integer id;

    @Column(name = "\"movieId\"", nullable = false)
    private Integer movieId;

    @Column(name = "\"cinemaId\"", nullable = false)
    private Integer cinemaId;

    @Column(name = "\"date\"", nullable = false)
    private String date;

    @Column(name = "\"time\"", nullable = false)
    private String time;

    @Column(name = "\"format\"", nullable = false)
    private String format;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "\"movieId\"", insertable = false, updatable = false)
    private Movie movie;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "\"cinemaId\"", insertable = false, updatable = false)
    private Cinema cinema;

    @CreationTimestamp
    @Column(name = "\"createdAt\"", nullable = false, updatable = false)
    private OffsetDateTime createdAt;

    @UpdateTimestamp
    @Column(name = "\"updatedAt\"")
    private OffsetDateTime updatedAt;

    @OneToMany(mappedBy = "show", cascade = CascadeType.ALL, fetch = FetchType.LAZY)
    @Builder.Default
    private List<Booking> bookings = new ArrayList<>();
}
