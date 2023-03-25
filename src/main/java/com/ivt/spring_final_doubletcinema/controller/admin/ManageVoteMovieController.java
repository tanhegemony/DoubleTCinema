/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.VoteMovieEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.VoteMovieService;
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
public class ManageVoteMovieController {
    
    @Autowired
    private AccountService accountService;
    
     @Autowired
    private VoteMovieService voteMovieService;
    
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
    
    @RequestMapping("/votes")
    public String viewVotes(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "votes");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<VoteMovieEntity> votes = voteMovieService.getVotesPagination(currentPage - 1, pageSize, Sort.by("starNumber").ascending());
        if (votes != null) {
            int totalPages = votes.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("votes", votes);
        }
        return "/admin/vote_movie";
    }

    @RequestMapping(value = "searchVotes", method = RequestMethod.GET)
    public String searchVotes(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_votes");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<VoteMovieEntity> votes = null;
        if(searchValue.equals("")){
            votes = voteMovieService.getVotesPagination(currentPage - 1, pageSize, Sort.by("starNumber").ascending());
        }else{
            votes = voteMovieService.findVoteMoviesByMovieAndCustomerAndStarNumber("%" + searchValue + "%", searchValue,currentPage - 1, pageSize, Sort.by("star_number").ascending());
        }
        if (votes != null) {
            int totalPages = votes.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("votes", votes);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/vote_movie";
    }
    
    @RequestMapping("displayVoteMovie/{id}")
    public String displayVoteMovie(
            @PathVariable("id") long id,
            Model model){
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "display_vote");
        VoteMovieEntity voteMovie = voteMovieService.findVoteMovieById(id);
        if(voteMovie.isDisplay() == true){
            voteMovie.setDisplay(false);
        }else if(voteMovie.isDisplay() == false){
            voteMovie.setDisplay(true);
        }
        voteMovieService.saveVoteMovie(voteMovie);
        return "redirect:/admin/votes";
    }
    
}
