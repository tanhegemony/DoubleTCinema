/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.SeatEntity;
import com.ivt.spring_final_doubletcinema.repository.SeatRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class SeatService {
    @Autowired
    private SeatRepository seatRepository;
    
    public SeatEntity findSeatBySeatNumber(String seatNumber){
        SeatEntity seat = seatRepository.findBySeatNumber(seatNumber);
        if(seat != null && seat.getId() > 0){
            return seat;
        }
        return new SeatEntity();
    }
    
    public List<SeatEntity> findSeatsByCinemaRoomId(long cinemaRoomId){
        List<SeatEntity> seats = seatRepository.findSeatsByCinemaRoomId(cinemaRoomId);
        if(seats != null && seats.size() > 0){
            return seats;
        }
        return new ArrayList<>();
    }
    
    public SeatEntity findBySeatNumberAndCinemaRoomId(String seatNumber, long cinemaRoomId){
        return seatRepository.findSeatBySeatNumberAndCinemaRoomId(seatNumber, cinemaRoomId);
    }
    
    //admin
    public Page<SeatEntity> getSeatPagination(int currentPage, int pageSize, Sort sort){
        Page<SeatEntity>  seats = seatRepository.findSeat(PageRequest.of(currentPage, pageSize, sort));
       if(!seats.isEmpty()){
           return seats;
       }
       return null;
        
        }
    
    public Page<SeatEntity> findBySeatBySeatNumber(String seatNumber ,  int currentPage, int pagesize, Sort sort ){
        Page<SeatEntity> seat = seatRepository.findSeatByName(seatNumber,  PageRequest.of(currentPage, pagesize, sort));
        if(!seat.isEmpty()){
            return seat;
            
        }
        return null;
    }
    
    public void delete(long id){
     seatRepository.deleteById(id);
    }
    
    public SeatEntity findById(long id) {
        Optional<SeatEntity> seatOpt = seatRepository.findById(id);

        if (seatOpt != null && seatOpt.isPresent()) {
            return seatOpt.get();
        }
        return new SeatEntity();
    }
     public void save(SeatEntity seat){
       if(seat != null){
             seatRepository.save(seat);
           }

     }
     
     public List<SeatEntity> getSeats(){
         List<SeatEntity> seats = (List<SeatEntity>) seatRepository.findAll();
         if(seats != null && seats.size() > 0){
             return seats;
         }
         return new ArrayList<>();
     }
}
