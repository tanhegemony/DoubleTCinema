/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "booking_detail")
public class BookingDetailEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @ManyToOne
    @JoinColumn(name = "movieId")
    private MovieEntity movie;
    
    @ManyToOne
    @JoinColumn(name = "cinemaId")
    private CinemaEntity cinema;
    
    @ManyToOne
    @JoinColumn(name = "cinemaRoomId")
    private CinemaRoomEntity cinemaRoom;
    
    @Column(name = "show_date")
    @Temporal(TemporalType.DATE)
    private Date showDate;
    
    @Column(name = "show_time")
    @Temporal(TemporalType.TIME)
    private Date showTime;
    
    @Transient
    private Date fullShowTime;
    
    @Column(name = "quantity_ticket")
    private int quantityTicket;
    
    
    private double totalPriceTicket;

    private double totalPriceFood;

    
    public double getTotalPriceFood() {
        return totalPriceFood;
    }

    public void setTotalPriceFood(double totalPriceFood) {
        this.totalPriceFood = totalPriceFood;
    }
    
    @OneToOne()
    @JoinColumn(name = "bookingId")
    private BookingEntity booking;

    public Date getFullShowTime() {
        return fullShowTime;
    }

    public void setFullShowTime(Date fullShowTime) {
        this.fullShowTime = fullShowTime;
    }
    
    public BookingEntity getBooking() {
        return booking;
    }

    public void setBooking(BookingEntity booking) {
        this.booking = booking;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public MovieEntity getMovie() {
        return movie;
    }

    public void setMovie(MovieEntity movie) {
        this.movie = movie;
    }

    public CinemaEntity getCinema() {
        return cinema;
    }

    public void setCinema(CinemaEntity cinema) {
        this.cinema = cinema;
    }

    public CinemaRoomEntity getCinemaRoom() {
        return cinemaRoom;
    }

    public void setCinemaRoom(CinemaRoomEntity cinemaRoom) {
        this.cinemaRoom = cinemaRoom;
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

    public int getQuantityTicket() {
        return quantityTicket;
    }

    public void setQuantityTicket(int quantityTicket) {
        this.quantityTicket = quantityTicket;
    }


    public double getTotalPriceTicket() {
        return totalPriceTicket;
    }

    public void setTotalPriceTicket(double totalPriceTicket) {
        this.totalPriceTicket = totalPriceTicket;
    }
    

    
    
    
}
