/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.BookingTicketEntity;
import java.util.List;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author ngoct
 */
@Repository
public interface BookingTicketRepository extends CrudRepository<BookingTicketEntity, Long>{
    List<BookingTicketEntity> findByTicketId(long ticketId); 
}
