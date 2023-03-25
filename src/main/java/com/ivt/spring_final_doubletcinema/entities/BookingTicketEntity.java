/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author ngoct
 */
@Entity
@Table(name = "booking_ticket")
public class BookingTicketEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "quantity_ticket")
    private int quantityTicket;
    
    @ManyToOne()
    @JoinColumn(name = "bookingId")
    private BookingEntity booking;
    
    @ManyToOne()
    @JoinColumn(name = "ticketId")
    private TicketEntity ticket;

    public BookingTicketEntity() {
    }

    public BookingTicketEntity(int quantityTicket, BookingEntity booking, TicketEntity ticket) {
        this.quantityTicket = quantityTicket;
        this.booking = booking;
        this.ticket = ticket;
    }

    public int getQuantityTicket() {
        return quantityTicket;
    }

    public void setQuantityTicket(int quantityTicket) {
        this.quantityTicket = quantityTicket;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public BookingEntity getBooking() {
        return booking;
    }

    public void setBooking(BookingEntity booking) {
        this.booking = booking;
    }

    public TicketEntity getTicket() {
        return ticket;
    }

    public void setTicket(TicketEntity ticket) {
        this.ticket = ticket;
    }
    
    
    
}
