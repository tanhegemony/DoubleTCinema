/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.TicketEntity;
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
public interface TicketRepository extends CrudRepository<TicketEntity, Long>{
    //admin
    @Query("SELECT t FROM TicketEntity t")
    Page<TicketEntity> findTickets(Pageable Pageable);
    
    @Query(value = "SELECT * FROM tickets where ticket_name like ?1 " , nativeQuery = true)
     Page<TicketEntity> findTicketByName(String ticketName,Pageable Pageable);
     
    TicketEntity findByTicketName(String ticketName);
}
