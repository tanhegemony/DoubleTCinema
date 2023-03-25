/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.BookingFoodEntity;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface BookingFoodRepository extends CrudRepository<BookingFoodEntity, Long>{
    List<BookingFoodEntity> findByBookingId(long bookingId);
    
    List<BookingFoodEntity> findByFoodId(long foodId);
}
