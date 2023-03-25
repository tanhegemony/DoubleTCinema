/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.SeatEntity;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface SeatRepository extends CrudRepository<SeatEntity, Long>{
    @Query("SELECT s FROM SeatEntity s JOIN FETCH s.seatsCinemaRoom scr WHERE scr.cinemaRoom.id = ?1")
    List<SeatEntity> findSeatsByCinemaRoomId(long cinemaRoomId);
    
    @Query("SELECT s FROM SeatEntity s JOIN FETCH s.seatsCinemaRoom scr WHERE s.seatNumber = ?1 and scr.cinemaRoom.id = ?2")
    SeatEntity findSeatBySeatNumberAndCinemaRoomId(String seatNumber, long cinemaRoomId);
    
    //admin
    @Query("SELECT s FROM SeatEntity s")
    Page<SeatEntity> findSeat(Pageable pageable);
    
    @Query(value = "SELECT * FROM seat where seat_number like ?1" , nativeQuery = true)
    Page<SeatEntity> findSeatByName(String seatNumber , Pageable Pageable);
    
    SeatEntity findBySeatNumber(String seatNumber);
}
