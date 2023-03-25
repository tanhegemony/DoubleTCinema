/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.BookingSeatEntity;
import com.ivt.spring_final_doubletcinema.entities.SeatEntity;
import com.ivt.spring_final_doubletcinema.repository.BookingSeatRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class BookingSeatService {
    @Autowired
    private BookingSeatRepository bookingSeatRepository;
    
    public List<BookingSeatEntity> findSeatsBySeatNumber(String seatNumber){
        List<BookingSeatEntity> bookingSeats = bookingSeatRepository.findBySeatNumber(seatNumber);
        if(bookingSeats != null && bookingSeats.size() > 0){
            return bookingSeats;
        }
        return new ArrayList<>();
    }
    
    public List<BookingSeatEntity> findBookingSeatBooked(String bookingDate, long movieId, long cinemaId, 
             long cinemaRoomId, String showTime){
        List<BookingSeatEntity> bookingSeats = bookingSeatRepository.findBookingSeatBooked(
                bookingDate, movieId, cinemaId, cinemaRoomId, showTime);
        if(bookingSeats.size() > 0 && bookingSeats != null){
            return bookingSeats;
        }
        return new ArrayList<>();
    }
    
    public void saveListBookingSeats(List<BookingSeatEntity> bookingSeats){
        bookingSeatRepository.saveAll(bookingSeats);
    }
    
    //admin
    public List<BookingSeatEntity> findByBookingId(long id){
       List<BookingSeatEntity> bookingSeats = bookingSeatRepository.findByBookingId(id);
        if (bookingSeats != null){
          return bookingSeats;
        }
       return new ArrayList<>();
       
       }
}
