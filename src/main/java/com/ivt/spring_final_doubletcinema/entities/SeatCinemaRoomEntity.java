/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "seat_cinema_room")
public class SeatCinemaRoomEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @ManyToOne()
    @JoinColumn(name = "seatId")
    private SeatEntity seat;
    
    @ManyToOne()
    @JoinColumn(name = "cinemaRoomId")
    private CinemaRoomEntity cinemaRoom;

    public SeatCinemaRoomEntity() {
    }

    public SeatCinemaRoomEntity(SeatEntity seat, CinemaRoomEntity cinemaRoom) {
        this.seat = seat;
        this.cinemaRoom = cinemaRoom;
    }

    
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public SeatEntity getSeat() {
        return seat;
    }

    public void setSeat(SeatEntity seat) {
        this.seat = seat;
    }

    public CinemaRoomEntity getCinemaRoom() {
        return cinemaRoom;
    }

    public void setCinemaRoom(CinemaRoomEntity cinemaRoom) {
        this.cinemaRoom = cinemaRoom;
    }

    @Override
    public String toString() {
        return "SeatCinemaRoomEntity{" + "seat=" + seat.getSeatNumber() + ", cinemaRoom=" + cinemaRoom.getCinemaRoomName() + '}';
    }
    
    
}
