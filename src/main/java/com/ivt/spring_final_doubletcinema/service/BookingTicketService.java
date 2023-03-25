/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.BookingTicketEntity;
import com.ivt.spring_final_doubletcinema.repository.BookingTicketRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author ngoct
 */
@Service
public class BookingTicketService {
    
    @Autowired
    private BookingTicketRepository bookingTicketRepository;
    
    public List<BookingTicketEntity> findBookingsTicketByTicketId(long ticketId){
        List<BookingTicketEntity> bookingsTicket = bookingTicketRepository.findByTicketId(ticketId);
        if(bookingsTicket != null && bookingsTicket.size() > 0){
            return bookingsTicket;
        }
        return new ArrayList<>();
    }
    
    public void saveOrUpdateAllBookingTicket(List<BookingTicketEntity> bookingTickets){
        bookingTicketRepository.saveAll(bookingTickets);
    }
    
}
