/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.TransactionCinemaEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.TransactionCinemaService;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author ngoct
 */
@Controller
@RequestMapping("/admin/")
public class ManageTransactionCinemaController {
    
    @Autowired
    private AccountService accountService;
    
    @Autowired
    private TransactionCinemaService transactionCinemaService;
    
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
    
    @RequestMapping("/transactionsCinema")
    public String viewTransactionsCinema(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model){
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "transactions_cinema");
        
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<TransactionCinemaEntity> transactionsCinema = transactionCinemaService.getTransactionsCinemaPagination(currentPage - 1, pageSize, Sort.by("transactionDate").descending());
        if (transactionsCinema != null) {
            int totalPages = transactionsCinema.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("transactionsCinema", transactionsCinema);
        }
        return "/admin/transaction_cinema";
        
    }
    
    @RequestMapping(value = "searchTransactionsCinema", method = RequestMethod.GET)
    public String searchMovie(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        model.addAttribute("action", "search_transactions_cinema");
        AccountEntity accountLogin = getAccountByUserLogin(model);
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<TransactionCinemaEntity> transactionsCinema = null;
        if (searchValue.equals("")) {
            transactionsCinema = transactionCinemaService.getTransactionsCinemaPagination(currentPage - 1, pageSize, Sort.by("transactionDate").descending());
        } else {
            transactionsCinema = transactionCinemaService.findTransactionsCinemaByCustomerPagination("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("transaction_date").descending());
        }
        if (transactionsCinema != null) {
            int totalPages = transactionsCinema.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("transactionsCinema", transactionsCinema);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/transaction_cinema";
    }
}
