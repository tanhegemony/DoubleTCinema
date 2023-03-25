/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.BookingFoodEntity;
import com.ivt.spring_final_doubletcinema.repository.BookingFoodRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class BookingFoodService {
    @Autowired
    private BookingFoodRepository bookingFoodRepository;
    
    public List<BookingFoodEntity> findFoodByBookingFood(long foodId){
        List<BookingFoodEntity> bookingFoods = bookingFoodRepository.findByFoodId(foodId);
        if(bookingFoods.size()>0 && bookingFoods != null){
            return bookingFoods;
        }
        return new ArrayList<>();
    }
    
    // show booking food by booking 
    public List<BookingFoodEntity> findByBookingId(long bookingId){
        List<BookingFoodEntity> bookingFoods = bookingFoodRepository.findByBookingId(bookingId);
        if(bookingFoods.size()>0 && bookingFoods != null){
            return bookingFoods;
        }
        return new ArrayList<>();
    }
    
    public void saveListBookingFoods(List<BookingFoodEntity> bookingFoods){
        bookingFoodRepository.saveAll(bookingFoods);
    }
}
