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
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "seat")
public class SeatEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(name = "seat_number", length = 50)
    @NotEmpty(message = "SeatNumber is not empty!")
    private String seatNumber;
    
    @Transient
    private boolean checkExistSeats = false;

    public boolean isCheckExistSeats() {
        return checkExistSeats;
    }

    public void setCheckExistSeats(boolean checkExistSeats) {
        this.checkExistSeats = checkExistSeats;
    }
    
    @OneToMany(mappedBy = "seat", cascade = CascadeType.ALL)
    private List<SeatCinemaRoomEntity> seatsCinemaRoom; 

    public List<SeatCinemaRoomEntity> getSeatsCinemaRoom() {
        return seatsCinemaRoom;
    }

    public void setSeatsCinemaRoom(List<SeatCinemaRoomEntity> seatsCinemaRoom) {
        this.seatsCinemaRoom = seatsCinemaRoom;
    }
    
    @Transient
    private boolean selected = false;

    @Transient
    private boolean canNotSelected = false;
    
    @Transient
    private boolean booked = false;
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public boolean isSelected() {
        return selected;
    }

    public void setSelected(boolean selected) {
        this.selected = selected;
    }

    public boolean isCanNotSelected() {
        return canNotSelected;
    }

    public void setCanNotSelected(boolean canNotSelected) {
        this.canNotSelected = canNotSelected;
    }

    public boolean isBooked() {
        return booked;
    }

    public void setBooked(boolean booked) {
        this.booked = booked;
    }
    
    @Override
    public String toString() {
        return seatNumber;
    }
    
}
