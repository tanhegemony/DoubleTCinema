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
import org.springframework.format.annotation.NumberFormat;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "food")
public class FoodEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "name_food", length = 50, unique = true)
    @NotEmpty(message = "NameFood is not empty!")
    private String nameFood;
    
    @Column(name = "price_food")
    @Range(min = 0)
    @NumberFormat(pattern = "#.###.###")
    private double priceFood;

    @Transient
    private int quantity;
    
    @Transient
    private boolean checkExistBookingFoods = false;

    public boolean isCheckExistBookingFoods() {
        return checkExistBookingFoods;
    }

    public void setCheckExistBookingFoods(boolean checkExistBookingFoods) {
        this.checkExistBookingFoods = checkExistBookingFoods;
    }
    
    @OneToMany(mappedBy = "food", cascade = CascadeType.ALL)
    private List<BookingFoodEntity> bookingFoods;

    public List<BookingFoodEntity> getBookingFoods() {
        return bookingFoods;
    }

    public void setBookingFoods(List<BookingFoodEntity> bookingFoods) {
        this.bookingFoods = bookingFoods;
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

    public String getNameFood() {
        return nameFood;
    }

    public void setNameFood(String nameFood) {
        this.nameFood = nameFood;
    }

    public double getPriceFood() {
        return priceFood;
    }

    public void setPriceFood(double priceFood) {
        this.priceFood = priceFood;
    }
    
    
}
