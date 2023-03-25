/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import com.ivt.spring_final_doubletcinema.enums.PaymentTypes;
import java.util.Date;
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
import javax.persistence.Table;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "invoices")
public class InvoiceEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @ManyToOne()
    @JoinColumn(name = "bookingId")
    private BookingEntity booking;
    
    private String accountBankingName;
    
    private String accountBankingEmail;
    
    private double amount;
    
    @Column(name = "invoice_date")
    private Date invoiceDate = new Date();
    
    @Column(length = 50)
    private String status;

    @Column(name = "payment_type")
    @Enumerated(EnumType.STRING)
    private PaymentTypes paymentType;
    
    @Column(name = "staff_name")
    private String staffName;
    
    @Column(name = "staff_phone")
    private String staffPhone;

    public PaymentTypes getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(PaymentTypes paymentType) {
        this.paymentType = paymentType;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getStaffPhone() {
        return staffPhone;
    }

    public void setStaffPhone(String staffPhone) {
        this.staffPhone = staffPhone;
    }
    
    public String getAccountBankingName() {
        return accountBankingName;
    }

    public void setAccountBankingName(String accountBankingName) {
        this.accountBankingName = accountBankingName;
    }

    public String getAccountBankingEmail() {
        return accountBankingEmail;
    }

    public void setAccountBankingEmail(String accountBankingEmail) {
        this.accountBankingEmail = accountBankingEmail;
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

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public Date getInvoiceDate() {
        return invoiceDate;
    }

    public void setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    
}
