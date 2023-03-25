/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingTicketEntity;
import com.ivt.spring_final_doubletcinema.entities.TicketEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingTicketService;
import com.ivt.spring_final_doubletcinema.service.TicketService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author ngoct
 */
@Controller
@RequestMapping("/admin/")
public class ManageTicketController {
    
    @Autowired
    private AccountService accountService;
    
    @Autowired
    private TicketService ticketService;
    
    @Autowired
    private BookingTicketService bookingTicketService;
    
    public AccountEntity getAccountByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String customerEmail = principal.toString();
        if (principal instanceof UserDetails) {
            customerEmail = ((UserDetails) principal).getUsername();
        }
        AccountEntity account = accountService.findByCustomerEmail(customerEmail);
        model.addAttribute("accountLogin", account);
        return account;
    }
    
    public List<TicketEntity> checkExistTickets(Page<TicketEntity> tickets){
        List<TicketEntity> ticketList = new ArrayList<>();
        for (TicketEntity t : tickets) {
            List<BookingTicketEntity> bookingTickets = bookingTicketService.findBookingsTicketByTicketId(t.getId());
            if (bookingTickets.size() > 0) {
                t.setCheckExistTickets(true);
                ticketList.add(t);
            } else {
                t.setCheckExistTickets(false);
                ticketList.add(t);
            }
        }
        return ticketList;
    }
    
    @RequestMapping("/tickets")
    public String viewTicket(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "tickets");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<TicketEntity> tickets = ticketService.getTicketsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (tickets != null) {
            List<TicketEntity> ticketList = checkExistTickets(tickets);
            int totalPages = tickets.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("tickets", ticketList);
        }
        return "/admin/ticket";
    }

    @RequestMapping(value = "/searchTickets", method = RequestMethod.GET)
    public String searchTicket(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_tickets");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<TicketEntity> tickets = null;
        if(searchValue.equals("")){
            tickets = ticketService.getTicketsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        }else{
            tickets = ticketService.findByTicketName("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        }
        if (tickets != null) {
            List<TicketEntity> ticketList = checkExistTickets(tickets);
            int totalPages = tickets.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("tickets", ticketList);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/ticket";
    }
    
    @RequestMapping("addTicket")
    public String addTicket(Model model){
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_ticket");
        return "/admin/form/form_ticket";
    }

    @RequestMapping("editTicket/{id}")
    public String editTicket(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        TicketEntity ticket = ticketService.findTicketById(id);
        if (ticket.getId() > 0) {
            model.addAttribute("action", "update_ticket");
            model.addAttribute("ticket", ticket);
        } else {
            model.addAttribute("action", "add_ticket");
        }
        return "/admin/form/form_ticket";
    }

    @RequestMapping(value = "/resultSaveTicket", method = RequestMethod.POST)
    public String resultTicket(
            @Valid @ModelAttribute("ticket") TicketEntity ticket,
            BindingResult result,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (ticket.getId() > 0) {
                model.addAttribute("action", "update_ticket");
            } else {
                model.addAttribute("action", "add_ticket");
            }
            return "/admin/form/form_ticket";
        } else {
            if (ticket.getId() <= 0) {
                TicketEntity findTicket = ticketService.findTicketByName(ticket.getTicketName());
                if (findTicket != null && findTicket.getId() > 0) {
                    model.addAttribute("messageTicket", "TicketType is existed!");
                    model.addAttribute("action", "add_ticket");
                    return "/admin/form/form_ticket";
                } else {
                    ticketService.saveOrUpdateTicket(ticket);
                }
            } else {
                ticketService.saveOrUpdateTicket(ticket);
            }
        }
        return "redirect:/admin/tickets";
    }

    @RequestMapping("deleteTicket/{id}")
    public String deleteTicket(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        ticketService.deleteTicket(id);
        return "redirect:/admin/tickets";
    }
}
