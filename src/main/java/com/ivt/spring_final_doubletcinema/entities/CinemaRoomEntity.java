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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import org.springframework.format.annotation.NumberFormat;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "cinema_room")
public class CinemaRoomEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "cinema_room_name", length = 50)
    private String cinemaRoomName;

    @Column(name = "row_cinema_room")
    private int rowCinemaRoom;

    @Column(name = "column_cinema_room")
    private int columnCinemaRoom;

    @ManyToOne()
    @JoinColumn(name = "cinemaId")
    private CinemaEntity cinema;
    
    @OneToMany(mappedBy = "cinemaRoom", cascade = CascadeType.ALL)
    private List<CinemaMovieEntity> cinemaMovies;

    @OneToMany(mappedBy = "cinemaRoom", cascade = CascadeType.ALL)
    private List<SeatCinemaRoomEntity> seatsCinemaRoom; 

    @OneToMany(mappedBy = "cinemaRoom", cascade = CascadeType.ALL)
    private List<BookingDetailEntity> bookingDetails;

    @Transient
    private boolean checkExistCinemaMovies = false;
    
    public boolean isCheckExistCinemaMovies() {
        return checkExistCinemaMovies;
    }

    public void setCheckExistCinemaMovies(boolean checkExistCinemaMovies) {
        this.checkExistCinemaMovies = checkExistCinemaMovies;
    }
    
    
    public List<BookingDetailEntity> getBookingDetails() {
        return bookingDetails;
    }

    public void setBookingDetails(List<BookingDetailEntity> bookingDetails) {
        this.bookingDetails = bookingDetails;
    }

    public CinemaEntity getCinema() {
        return cinema;
    }

    public void setCinema(CinemaEntity cinema) {
        this.cinema = cinema;
    }

    public List<SeatCinemaRoomEntity> getSeatsCinemaRoom() {
        return seatsCinemaRoom;
    }

    public void setSeatsCinemaRoom(List<SeatCinemaRoomEntity> seatsCinemaRoom) {
        this.seatsCinemaRoom = seatsCinemaRoom;
    }
    
    public List<CinemaMovieEntity> getCinemaMovies() {
        return cinemaMovies;
    }

    public void setCinemaMovies(List<CinemaMovieEntity> cinemaMovies) {
        this.cinemaMovies = cinemaMovies;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCinemaRoomName() {
        return cinemaRoomName;
    }

    public void setCinemaRoomName(String cinemaRoomName) {
        this.cinemaRoomName = cinemaRoomName;
    }

    public int getRowCinemaRoom() {
        return rowCinemaRoom;
    }

    public void setRowCinemaRoom(int rowCinemaRoom) {
        this.rowCinemaRoom = rowCinemaRoom;
    }

    public int getColumnCinemaRoom() {
        return columnCinemaRoom;
    }

    public void setColumnCinemaRoom(int columnCinemaRoom) {
        this.columnCinemaRoom = columnCinemaRoom;
    }

}
