/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import com.ivt.spring_final_doubletcinema.enums.AccountBankingStatus;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import org.hibernate.validator.constraints.Length;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "accountBanking")
public class AccountBankingEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "card_number", length = 50)
    @NotEmpty(message = "CardNumber không được để trống!")
    @Length(min = 12, max = 12, message = "CardNumber phải đủ 12 số")
    private String cardNumber;
    
    @Column(name = "card_name", length = 50)
    @NotEmpty(message = "CardName không được để trống!")
    private String cardName;
    
    private double balance;
    
    @Column(name = "email_banking", length = 50, unique = true)
    @NotEmpty(message = "Email Banking không được để trống!")
    private String emailBanking;
    
    @Column(name = "month_expiry_date", length = 2)
    @Min(value = 01, message = "MonthExpiryDate about 01 to 12!")
    @Max(value = 12, message = "MonthExpiryDate about 01 to 12!")
    private int monthExpiryDate;
    
    @Column(name = "year_expiry_date", length = 2)
    private int yearExpiryDate;
    
    @Column(name = "cvv_code", length = 5)
    @NotEmpty(message = "CVVCode không được để trống!")
    @Length(min = 3, max = 3, message = "CVVCode phải đủ 3 số!")
    private String cvvCode;
    
    @Column(length = 50)
    @Enumerated(EnumType.STRING)
    private AccountBankingStatus status;

    @OneToOne()
    @JoinColumn(name = "customerId")
    private CustomerEntity customer;

    public CustomerEntity getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerEntity customer) {
        this.customer = customer;
    }
    
    public String getCardName() {
        return cardName;
    }

    public void setCardName(String cardName) {
        this.cardName = cardName;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCardNumber() {
        return cardNumber;
    }

    public void setCardNumber(String cardNumber) {
        this.cardNumber = cardNumber;
    }

    public double getBalance() {
        return balance;
    }

    public void setBalance(double balance) {
        this.balance = balance;
    }

    public String getEmailBanking() {
        return emailBanking;
    }

    public void setEmailBanking(String emailBanking) {
        this.emailBanking = emailBanking;
    }

    public int getMonthExpiryDate() {
        return monthExpiryDate;
    }

    public void setMonthExpiryDate(int monthExpiryDate) {
        this.monthExpiryDate = monthExpiryDate;
    }

    public int getYearExpiryDate() {
        return yearExpiryDate;
    }

    public void setYearExpiryDate(int yearExpiryDate) {
        this.yearExpiryDate = yearExpiryDate;
    }

    

    public String getCvvCode() {
        return cvvCode;
    }

    public void setCvvCode(String cvvCode) {
        this.cvvCode = cvvCode;
    }

    public AccountBankingStatus getStatus() {
        return status;
    }

    public void setStatus(AccountBankingStatus status) {
        this.status = status;
    }

    
}
