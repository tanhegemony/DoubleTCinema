/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.BookingSeatEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface BookingSeatRepository extends CrudRepository<BookingSeatEntity, Long> {

    @Query(value = "select * from booking_seat as bs join booking as b "
            + " on b.id = bs.bookingId "
            + " join booking_detail as bd "
            + " on bd.bookingId = b.id "
            + " where b.booking_date like ?1 and bd.movieId = ?2 and bd.cinemaId = ?3 "
            + " and bd.cinemaRoomId = ?4 and bd.show_time = ?5", nativeQuery = true)
    List<BookingSeatEntity> findBookingSeatBooked(String bookingDate, long movieId, long cinemaId, 
             long cinemaRoomId, String showTime);
    
    //admin
    List<BookingSeatEntity>  findByBookingId(long id);
    
    List<BookingSeatEntity> findBySeatNumber(String seatNumber);
}
