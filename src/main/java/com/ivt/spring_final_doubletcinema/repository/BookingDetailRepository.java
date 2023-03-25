/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.BookingDetailEntity;
import java.util.Date;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface BookingDetailRepository extends CrudRepository<BookingDetailEntity, Long>{
    
    List<BookingDetailEntity> findByMovieIdAndCinemaIdAndCinemaRoomIdAndShowDateAndShowTime(long movieID, long cinemaId, long cinemaRoomId, Date showDate, Date showTime);
    
    // show list booking detail by booking
    List<BookingDetailEntity> findByBookingId(long bookingId);

}
