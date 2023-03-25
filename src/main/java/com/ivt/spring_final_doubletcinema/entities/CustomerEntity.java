/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import com.ivt.spring_final_doubletcinema.enums.Gender;
import java.util.ArrayList;
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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Digits;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Pattern;
import org.hibernate.validator.constraints.Length;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "customer")
public class CustomerEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "customer_name", length = 50, nullable = false)
    @NotEmpty(message = "CustomerName is not empty!")
    private String customerName;
    
    @Column(name = "birth_date")
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    @NotNull(message = "Birthdate is not empty!")
    private Date birthDate;
    
    @Column(name = "customer_phone", length = 50, unique = true, nullable = false)
    @NotEmpty(message = "CustomerPhone is not empty!")
    @Pattern(regexp = "^\\d{10,12}$", message = "CustomerPhone must be numeric and between 10 and 12 numbers!")
    private String customerPhone;
    
    @Column(name = "customer_email", length = 50, unique = true, nullable = false)
    @NotEmpty(message = "CustomerEmail is not empty!")
    @Pattern(regexp = "^[a-zA-Z0-9]{1,30}+@[a-zA-Z0-9]{2,10}+\\.[a-zA-Z]{2,10}$", message = "CustomerEmail is not in the correct format!")
    private String customerEmail;
    
    @Column(name = "customer_address", length = 255)
    private String customerAddress;
    
    @Enumerated(EnumType.STRING)
    private Gender gender;
    
    @OneToOne()
    @JoinColumn(name = "accountId")
    private AccountEntity account;

    @OneToMany(mappedBy = "customer", cascade = CascadeType.ALL)
    private List<BookingEntity> bookings;

    @OneToOne(mappedBy = "customer", cascade = CascadeType.ALL)
    private AccountBankingEntity accountBanking;

    public AccountBankingEntity getAccountBanking() {
        return accountBanking;
    }

    public void setAccountBanking(AccountBankingEntity accountBanking) {
        this.accountBanking = accountBanking;
    }
    
    public List<BookingEntity> getBookings() {
        return bookings;
    }

    public void setBookings(List<BookingEntity> bookings) {
        this.bookings = bookings;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public Gender getGender() {
        return gender;
    }

    public void setGender(Gender gender) {
        this.gender = gender;
    }

    public AccountEntity getAccount() {
        return account;
    }

    public void setAccount(AccountEntity account) {
        this.account = account;
    }
    
    
    
}
