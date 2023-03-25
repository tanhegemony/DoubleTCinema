/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.InvoiceService;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
public class ManageBookingController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private InvoiceService invoiceService;

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

    //bookings
    @RequestMapping("/bookings")
    public String viewBookings(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "bookings");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<BookingEntity> bookings = bookingService.getBookingPagination(currentPage - 1, pageSize, Sort.by("bookingDate").descending());
        if (bookings != null) {
            int totalPages = bookings.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("bookings", bookings);
        }
        return "/admin/booking";

    }
//    search booking

    @RequestMapping(value = "/searchBookings", method = RequestMethod.GET)
    public String searchBooking(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_bookings");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<BookingEntity> bookings = bookingService.searchBookings("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        if (bookings != null) {
            int totalPages = bookings.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("bookings", bookings);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/booking";
    }

    @RequestMapping("deleteBooking/{id}")
    public String deleteDetail(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        BookingEntity booking = bookingService.findBookingById(id);
        if (booking.getId() > 0) {
            bookingService.deleteBooking(id);
        }
        return "redirect:/admin/bookings";
    }

    @RequestMapping("viewBookingDetail/{id}")
    public String viewBookingDetail(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "view_booking_detail");
        BookingEntity booking = bookingService.getBookingById(id);
        model.addAttribute("booking", booking);
        return "/admin/view_booking_detail_of_booking";
    }

    @RequestMapping("viewInvoiceOfBooking/{id}")
    public String viewInvoiceOfBooking(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "view_invoice_of_booking");
        List<InvoiceEntity> invoices = invoiceService.findInvoicesByBookingId(id);
        model.addAttribute("id", id);
        model.addAttribute("invoices", invoices);
        return "/admin/view_invoice_of_booking";

    }
}
