/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import com.ivt.spring_final_doubletcinema.enums.BookingStatus;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "booking")
public class BookingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(length = 255)
    private String note;
    
    @Column(length = 50)
    @Enumerated(EnumType.STRING)
    private BookingStatus status;
    
    private double subtotal;
    
    @ManyToOne()
    @JoinColumn(name = "customerId")
    private CustomerEntity customer;
    
    @Column(length = 50)
    private String code;
    
    private double discount; 

    @OneToMany(mappedBy = "booking", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<InvoiceEntity> invoices;
    
    @OneToMany(mappedBy = "booking", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BookingFoodEntity> bookingFoods;

    @OneToOne(mappedBy = "booking", cascade = CascadeType.ALL)
    private BookingDetailEntity bookingDetail;
    
    @OneToMany(mappedBy = "booking", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BookingSeatEntity> bookingSeats;
    
    @OneToMany(mappedBy = "booking", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<BookingTicketEntity> bookingTickets;

    public List<BookingTicketEntity> getBookingTickets() {
        return bookingTickets;
    }

    public void setBookingTickets(List<BookingTicketEntity> bookingTickets) {
        this.bookingTickets = bookingTickets;
    }

    public List<BookingSeatEntity> getBookingSeats() {
        return bookingSeats;
    }

    public void setBookingSeats(List<BookingSeatEntity> bookingSeats) {
        this.bookingSeats = bookingSeats;
    }

     @Column(name = "booking_date")
    private Date bookingDate = new Date();

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }
    
     
     
    public BookingDetailEntity getBookingDetail() {
        return bookingDetail;
    }

    public void setBookingDetail(BookingDetailEntity bookingDetail) {
        this.bookingDetail = bookingDetail;
    }
    
    
    public List<BookingFoodEntity> getBookingFoods() {
        return bookingFoods;
    }

    public void setBookingFoods(List<BookingFoodEntity> bookingFoods) {
        this.bookingFoods = bookingFoods;
    }

    public List<InvoiceEntity> getInvoices() {
        return invoices;
    }

    public void setInvoices(List<InvoiceEntity> invoices) {
        this.invoices = invoices;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public BookingStatus getStatus() {
        return status;
    }

    public void setStatus(BookingStatus status) {
        this.status = status;
    }

    public double getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }

    public CustomerEntity getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerEntity customer) {
        this.customer = customer;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public double getDiscount() {
        return discount;
    }

    public void setDiscount(double discount) {
        this.discount = discount;
    }
    
    
}
