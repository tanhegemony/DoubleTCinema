/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.BookingDetailEntity;
import com.ivt.spring_final_doubletcinema.repository.BookingDetailRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author tanhegemony
 */
@Service
public class BookingDetailService {
    @Autowired
    private BookingDetailRepository bookingDetailRepository;
    
    public List<BookingDetailEntity> findByMovieIdAndCinemaIdAndCinemaRoomIdAndShowDateAndShowTime(
            long movieID, long cinemaId, long cinemaRoomId, Date showDate, Date showTime){
        List<BookingDetailEntity> bookingDetails = bookingDetailRepository.
                findByMovieIdAndCinemaIdAndCinemaRoomIdAndShowDateAndShowTime(
                        movieID, cinemaId, cinemaRoomId, showDate, showTime);
        if(bookingDetails != null && bookingDetails.size() > 0){
            return bookingDetails;
        }
        return new ArrayList<>();
    }
    
    public BookingDetailEntity findById(long bookingDetailId){
        Optional<BookingDetailEntity> bookingDetailOpt = bookingDetailRepository.findById(bookingDetailId);
        if(bookingDetailOpt.isPresent() && !bookingDetailOpt.isEmpty()){
            return bookingDetailOpt.get();
        }
        return new BookingDetailEntity();
    }
    
    // show list booking detail by booking
    @Transactional
    public List<BookingDetailEntity> findByBookingId(long bookingId){
        List<BookingDetailEntity> bookingDetails = bookingDetailRepository.findByBookingId(bookingId);
        if(bookingDetails.size() > 0 && bookingDetails != null){
            for(BookingDetailEntity bd: bookingDetails){
                Hibernate.initialize(bd.getBooking().getBookingTickets());
                Hibernate.initialize(bd.getBooking().getBookingFoods());
                Hibernate.initialize(bd.getBooking().getBookingSeats());
            }
            return bookingDetails;
        }
        return new ArrayList<>();
    }

    
    public void saveBookingDetail(BookingDetailEntity bookingDetail){
        bookingDetailRepository.save(bookingDetail);
    }
}
