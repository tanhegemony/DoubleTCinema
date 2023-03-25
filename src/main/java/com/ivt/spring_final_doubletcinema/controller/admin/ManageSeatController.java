/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingSeatEntity;
import com.ivt.spring_final_doubletcinema.entities.SeatEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingSeatService;
import com.ivt.spring_final_doubletcinema.service.SeatService;
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
public class ManageSeatController {

    @Autowired
    private SeatService seatService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private BookingSeatService bookingSeatService;

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

    public List<SeatEntity> checkExistSeats(Page<SeatEntity> seats) {
        List<SeatEntity> seatList = new ArrayList<>();
        for (SeatEntity s : seats) {
            List<BookingSeatEntity> bookingSeats = bookingSeatService.findSeatsBySeatNumber(s.getSeatNumber());
            if (bookingSeats.size() > 0) {
                s.setCheckExistSeats(true);
                seatList.add(s);
            } else {
                s.setCheckExistSeats(false);
                seatList.add(s);
            }
        }
        return seatList;
    }

    @RequestMapping("/seats")
    public String viewSeats(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "seats");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<SeatEntity> seats = seatService.getSeatPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (seats != null) {
            List<SeatEntity> seatList = checkExistSeats(seats);
            int totalPages = seats.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("seats", seatList);
        }
        return "/admin/seat";
    }

    @RequestMapping(value = "/searchSeats", method = RequestMethod.GET)
    public String searchSeats(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_seats");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<SeatEntity> seats = null;
        if (searchValue.equals("")) {
            seats = seatService.getSeatPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        } else {
            seats = seatService.findBySeatBySeatNumber("%" + searchValue, currentPage - 1, pageSize, Sort.by("id").ascending());
        }
        if (seats != null) {
            List<SeatEntity> seatList = checkExistSeats(seats);
            int totalPages = seats.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("seats", seatList);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/seat";
    }

    @RequestMapping("deleteSeat/{id}")
    public String deleteSeat(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        seatService.delete(id);
        return "redirect:/admin/seats";
    }

    @RequestMapping("addSeat")
    public String addSeat(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_seat");
        return "/admin/form/form_seat";
    }

    @RequestMapping("editSeat/{id}")
    public String updateSeat(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        SeatEntity seat = seatService.findById(id);
        if (seat.getId() > 0) {
            model.addAttribute("action", "update_seat");
            model.addAttribute("seat", seat);
        } else {
            model.addAttribute("action", "add_seat");
        }
        return "/admin/form/form_seat";
    }

    @RequestMapping(value = {"resultSaveSeat"}, method = RequestMethod.POST)
    public String saveSeat(
            @Valid @ModelAttribute("seat") SeatEntity seat,
            BindingResult result,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (seat.getId() > 0) {
                model.addAttribute("action", "update_seat");
                model.addAttribute("seat", seat);
            } else {
                model.addAttribute("action", "add_seat");
            }
            return "/admin/form/form_seat";
        } else {
            if (seat.getId() > 0) {
                SeatEntity findSeat1 = seatService.findById(seat.getId());
                SeatEntity findSeat = seatService.findSeatBySeatNumber(seat.getSeatNumber());
                if (!findSeat1.getSeatNumber().equals(seat.getSeatNumber()) && findSeat != null && findSeat.getId() > 0) {
                    model.addAttribute("messageSeat", "Seat is existed!");
                    model.addAttribute("action", "update_seat");
                    return "/admin/form/form_seat";
                }
                seatService.save(seat);
            } else {
                SeatEntity findSeat = seatService.findSeatBySeatNumber(seat.getSeatNumber());
                if (findSeat != null && findSeat.getId() > 0) {
                    model.addAttribute("messageSeat", "Seat is existed!");
                    model.addAttribute("action", "add_seat");
                    return "/admin/form/form_seat";
                } else {
                    seatService.save(seat);
                }
            }
            return "redirect:/admin/seats";
        }
    }
}
