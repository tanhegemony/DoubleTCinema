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
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import org.hibernate.validator.constraints.Range;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "tickets")
public class TicketEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "ticket_name", length = 50, nullable = false, unique = true)
    @NotEmpty(message = "TicketTypeName is not empty!")
    private String ticketName;
    
    @Column(name = "ticket_price")
    @Range(min = 0, message = "TicketTypePrice must be greater than or equal to 0!")
    private double ticketPrice;

    @Transient
    private int quantity;
    
    @Transient
    private boolean checkExistTickets = false;

    public boolean isCheckExistTickets() {
        return checkExistTickets;
    }

    public void setCheckExistTickets(boolean checkExistTickets) {
        this.checkExistTickets = checkExistTickets;
    }
    
    @OneToMany(mappedBy = "ticket", cascade = CascadeType.ALL)
    private List<BookingTicketEntity> bookingTickets;

    public List<BookingTicketEntity> getBookingTickets() {
        return bookingTickets;
    }

    public void setBookingTickets(List<BookingTicketEntity> bookingTickets) {
        this.bookingTickets = bookingTickets;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getTicketName() {
        return ticketName;
    }

    public void setTicketName(String ticketName) {
        this.ticketName = ticketName;
    }

    public double getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }
    
    
}
