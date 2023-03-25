/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.CustomerService;
import java.text.ParseException;
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
public class ManageCustomerController {

    @Autowired
    private CustomerService customerService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private BookingService bookingService;

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

    @RequestMapping("/customers")
    public String viewCustomer(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "customers");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<CustomerEntity> customers = customerService.getCustomerPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (customers != null) {
            int totalPages = customers.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("customers", customers);

        }
        return "/admin/customer";
    }

    @RequestMapping(value = "searchCustomers", method = RequestMethod.GET)
    public String searchCustomer(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_customers");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CustomerEntity> customers = customerService.searchCustomerPagination("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        if (customers != null) {
            int totalPages = customers.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("customers", customers);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/customer";

    }

    @RequestMapping("viewBookingsOfCustomer/{customerId}")
    public String viewBookingsOfCustomer(
            @PathVariable("customerId") long customerId,
            Model model) throws ParseException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "view_bookings_of_customer");
        List<BookingEntity> bookings = bookingService.getListBookingByCustomerId(customerId, Sort.by("bookingDate").descending());
        CustomerEntity customer = customerService.findCustomerById(customerId);
        if (customer.getId() > 0) {
            model.addAttribute("customer", customer);
            if (bookings != null) {
                model.addAttribute("bookings", bookings);
            }
        }
        model.addAttribute("customerId", customerId);
        return "/admin/view_bookings_customer";
    }

    @RequestMapping("editCustomer/{id}")
    public String updateCustomer(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "update_customer");
        CustomerEntity customer = customerService.findCustomerById(id);
        if (customer.getId() > 0) {
            model.addAttribute("customer", customer);
        }
        return "/admin/form/form_customer";
    }

    @RequestMapping(value = "/resultSaveCustomer", method = RequestMethod.POST)
    public String resultSaveCustomer(
            @Valid @ModelAttribute("customer") CustomerEntity customer,
            BindingResult result,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "update_customer");
        if (result.hasErrors()) {
            model.addAttribute("customer", customer);
            return "/admin/form/form_customer";
        } else {
            customerService.saveOrUpdateCustomer(customer);
            return "redirect:/admin/customers";
        }
    }

    @RequestMapping("/deleteCustomer/{id}")
    public String deleteCustomer(
            @PathVariable("id") long id,
             Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        CustomerEntity customer = customerService.findCustomerById(id);
        if (customer.getId() > 0) {
            customerService.deleteCustomer(id);
            accountService.deleteAccount(customer.getAccount().getId());
        }
        return "redirect:/admin/customers";
    }
}
