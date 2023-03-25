/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "cinema_movie")
public class CinemaMovieEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @ManyToOne
    @JoinColumn(name = "cinemaId")
    @NotNull()
    private CinemaEntity cinema;
    
    @ManyToOne
    @JoinColumn(name = "movieId")
    @NotNull()
    private MovieEntity movie;
    
    @Column(name = "show_date")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date showDate;
     
    @Column(name = "show_time")
    @Temporal(TemporalType.TIME)
    @DateTimeFormat(pattern = "HH:mm")
    private Date showTime;
    
    @ManyToOne
    @JoinColumn(name = "cinemaRoomId")
    private CinemaRoomEntity cinemaRoom;
    
    @Transient
    private boolean checkExistBookingsCinemaMovie = false;

    public boolean isCheckExistBookingsCinemaMovie() {
        return checkExistBookingsCinemaMovie;
    }

    public void setCheckExistBookingsCinemaMovie(boolean checkExistBookingsCinemaMovie) {
        this.checkExistBookingsCinemaMovie = checkExistBookingsCinemaMovie;
    }
    
    public CinemaRoomEntity getCinemaRoom() {
        return cinemaRoom;
    }

    public void setCinemaRoom(CinemaRoomEntity cinemaRoom) {
        this.cinemaRoom = cinemaRoom;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public CinemaEntity getCinema() {
        return cinema;
    }

    public void setCinema(CinemaEntity cinema) {
        this.cinema = cinema;
    }

    public MovieEntity getMovie() {
        return movie;
    }

    public void setMovie(MovieEntity movie) {
        this.movie = movie;
    }

    public Date getShowDate() {
        return showDate;
    }

    public void setShowDate(Date showDate) {
        this.showDate = showDate;
    }

    public Date getShowTime() {
        return showTime;
    }

    public void setShowTime(Date showTime) {
        this.showTime = showTime;
    }

    @Override
    public String toString() {
        return "CinemaMovieEntity{" + "id=" + id + "\n" +
                ", cinema=" + cinema.getNameCinema() + "\n" 
                + ", movie=" + movie.getId() + "\n"
                + ", showDate=" + showDate + "\n"
                + ", showTime=" + showTime + "\n"
                + ", cinemaRoom=" + cinemaRoom + '}';
    }
    
    
}
