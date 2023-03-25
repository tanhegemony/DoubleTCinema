/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.VoteReviewMovieEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.VoteReviewMovieService;
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
public class ManageVoteReviewMovieController {
    
    @Autowired
    private AccountService accountService;
    
     @Autowired
    private VoteReviewMovieService voteReviewMovieService;
    
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
    
    @RequestMapping("/votesReviewMovie")
    public String viewVotesReviewMovie(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "votes_review_movie");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<VoteReviewMovieEntity> votesReviewMovie = voteReviewMovieService.getVotesReviewMoviePagination(currentPage - 1, pageSize, Sort.by("starNumber").ascending());
        if (votesReviewMovie != null) {
            int totalPages = votesReviewMovie.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("votesReviewMovie", votesReviewMovie);
        }
        return "/admin/vote_review_movie";
    }

    @RequestMapping(value = "searchVotesReviewMovie", method = RequestMethod.GET)
    public String searchVotesReviewMovie(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_votes_review_movie");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<VoteReviewMovieEntity> votesReviewMovie = null;
        if(searchValue.equals("")){
            votesReviewMovie = voteReviewMovieService.getVotesReviewMoviePagination(currentPage - 1, pageSize, Sort.by("starNumber").ascending());
        }else{
            votesReviewMovie = voteReviewMovieService.findVoteMoviesByReviewAndCustomerAndStarNumber("%" + searchValue + "%", searchValue,currentPage - 1, pageSize, Sort.by("star_number").ascending());
        }
        if (votesReviewMovie != null) {
            int totalPages = votesReviewMovie.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("votesReviewMovie", votesReviewMovie);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/vote_review_movie";
    }
    
    @RequestMapping("displayVoteReviewMovie/{id}")
    public String displayVoteReviewMovie(
            @PathVariable("id") long id,
            Model model){
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "display_vote_review_movie");
        VoteReviewMovieEntity voteReviewMovie = voteReviewMovieService.findVoteReviewMovieById(id);
        if(voteReviewMovie.isDisplay() == true){
            voteReviewMovie.setDisplay(false);
        }else if(voteReviewMovie.isDisplay() == false){
            voteReviewMovie.setDisplay(true);
        }
        voteReviewMovieService.saveVoteReviewMovie(voteReviewMovie);
        return "redirect:/admin/votesReviewMovie";
    }
    
}
