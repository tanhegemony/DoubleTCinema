/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.model;

import com.ivt.spring_final_doubletcinema.entities.FoodEntity;
import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;

/**
 *
 * @author ngoct
 */
public class BuyFoodAtCinema {
    private FoodEntity food;
    private int quantityFood;
    private double subtotalFood;
    private InvoiceEntity invoice;

    public BuyFoodAtCinema() {
    }

    public BuyFoodAtCinema(FoodEntity food, int quantityFood, double subtotalFood, InvoiceEntity invoice) {
        this.food = food;
        this.quantityFood = quantityFood;
        this.subtotalFood = subtotalFood;
        this.invoice = invoice;
    }

    public double getSubtotalFood() {
        return subtotalFood;
    }

    public void setSubtotalFood(double subtotalFood) {
        this.subtotalFood = subtotalFood;
    }

    public FoodEntity getFood() {
        return food;
    }

    public void setFood(FoodEntity food) {
        this.food = food;
    }

    public int getQuantityFood() {
        return quantityFood;
    }

    public void setQuantityFood(int quantityFood) {
        this.quantityFood = quantityFood;
    }

    public InvoiceEntity getInvoice() {
        return invoice;
    }

    public void setInvoice(InvoiceEntity invoice) {
        this.invoice = invoice;
    }
    
    
}
