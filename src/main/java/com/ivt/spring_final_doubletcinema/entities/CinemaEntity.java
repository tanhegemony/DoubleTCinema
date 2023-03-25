/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "cinema")
public class CinemaEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "name_cinema", length = 50, nullable = false, unique = true)
    @NotEmpty(message = "CinemaName is not empty!")
    private String nameCinema;
    
    @Column(name = "cinema_address", length = 255)
    @NotEmpty(message = "CinemaAddress is not empty!")
    private String cinemaAddress;
    
    @Column(name = "google_map", length = 255)
    @NotEmpty(message = "GoogleMap is not empty!")
    private String googleMap;
    
     @Transient
    private boolean checkExistCinemaMovies = false;

    @OneToMany(mappedBy = "cinema", cascade = CascadeType.ALL)
    private List<TransactionCinemaEntity> transactionsCinema;

    public List<TransactionCinemaEntity> getTransactionsCinema() {
        return transactionsCinema;
    }

    public void setTransactionsCinema(List<TransactionCinemaEntity> transactionsCinema) {
        this.transactionsCinema = transactionsCinema;
    }
     
    public boolean isCheckExistCinemaMovies() {
        return checkExistCinemaMovies;
    }

    public void setCheckExistCinemaMovies(boolean checkExistCinemaMovies) {
        this.checkExistCinemaMovies = checkExistCinemaMovies;
    }
    
    @OneToMany(mappedBy = "cinema", cascade = CascadeType.ALL)
    private List<CinemaRoomEntity> cinemaRooms;
    
    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    @Valid
    private List<CinemaMovieEntity> cinemaMovies;

    @OneToMany(mappedBy = "cinema", cascade = CascadeType.ALL)
    private List<BookingDetailEntity> bookingDetails;

    public List<CinemaRoomEntity> getCinemaRooms() {
        return cinemaRooms;
    }

    public void setCinemaRooms(List<CinemaRoomEntity> cinemaRooms) {
        this.cinemaRooms = cinemaRooms;
    }
    
    public String getCinemaAddress() {
        return cinemaAddress;
    }

    public void setCinemaAddress(String cinemaAddress) {
        this.cinemaAddress = cinemaAddress;
    }

    public String getGoogleMap() {
        return googleMap;
    }

    public void setGoogleMap(String googleMap) {
        this.googleMap = googleMap;
    }

    public List<BookingDetailEntity> getBookingDetails() {
        return bookingDetails;
    }

    public void setBookingDetails(List<BookingDetailEntity> bookingDetails) {
        this.bookingDetails = bookingDetails;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNameCinema() {
        return nameCinema;
    }

    public void setNameCinema(String nameCinema) {
        this.nameCinema = nameCinema;
    }

    public List<CinemaMovieEntity> getCinemaMovies() {
        return cinemaMovies;
    }

    public void setCinemaMovies(List<CinemaMovieEntity> cinemaMovies) {
        this.cinemaMovies = cinemaMovies;
    }
    
    
}
