/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.TicketEntity;
import com.ivt.spring_final_doubletcinema.repository.TicketRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

/**
 *
 * @author tanhegemony
 */
@Service
public class TicketService {
    @Autowired
    private TicketRepository ticketRepository;
    
    public List<TicketEntity> getTickets(){
        List<TicketEntity> tickets = (List<TicketEntity>) ticketRepository.findAll();
        if(!CollectionUtils.isEmpty(tickets)){
            return tickets;
        }
        return null;
    }
    
    //admin
    public Page<TicketEntity> getTicketsPagination(int currentPage, int pageSize, Sort sort){
        Page<TicketEntity>  tickets = ticketRepository.findTickets(PageRequest.of(currentPage, pageSize, sort));
       if(!tickets.isEmpty()){
           return tickets;
       }
       return null;
        
        }
    
    public Page<TicketEntity> findByTicketName(String searchValue ,  int currentPage, int pagesize, Sort sort ){
        Page<TicketEntity> tickets = ticketRepository.findTicketByName(searchValue,  PageRequest.of(currentPage, pagesize, sort));
        if(!tickets.isEmpty()){
            return tickets;
            
        }
        return null;
    }
    
    public TicketEntity findTicketByName(String ticketName) {
        TicketEntity ticket = ticketRepository.findByTicketName(ticketName);
        if(ticket != null){
            return ticket;
        }
        return new TicketEntity();
    }
    
    public TicketEntity findTicketById(long id) {
        Optional<TicketEntity> ticketOpt = ticketRepository.findById(id);

        if (ticketOpt != null && ticketOpt.isPresent()) {
            return ticketOpt.get();
        }
        return new TicketEntity();
    }
    
   public void saveOrUpdateTicket(TicketEntity ticket){
       ticketRepository.save(ticket);
   }
    
    public void deleteTicket(long id){
        ticketRepository.deleteById(id);
    }
}
