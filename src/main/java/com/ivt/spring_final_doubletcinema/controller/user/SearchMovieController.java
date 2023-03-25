/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.utils.UserPageUtils;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
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
public class SearchMovieController {
    
    @Autowired
    private MovieService movieService;
    
    @Autowired
    private AccountService accountService;
    
    @Autowired
    HttpSession session;
    
    public AccountEntity getAccountByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String customerEmail = principal.toString();
        if (principal instanceof UserDetails) {
            customerEmail = ((UserDetails) principal).getUsername();
        }
        AccountEntity account = accountService.findByCustomerEmail(customerEmail);

        model.addAttribute("account", account);
        model.addAttribute("username", customerEmail);
        return account;
    }
    
    // show film in menu
    public void viewFilmInHeaderInHomePage(Model model) {
        model.addAttribute("top4Coming", movieService.viewTop4ByFilmItem(FilmItem.PHIM_DANG_CHIEU));
        model.addAttribute("top4ComingSoon", movieService.viewTop4ByFilmItem(FilmItem.PHIM_SAP_CHIEU));
    }
    
    @RequestMapping(value = "search_movie", method = RequestMethod.GET)
    public String searchMovie(
            @RequestParam(name = "searchValue", required = false) String searchValue,
            @RequestParam(name = "displayName", required = false) FilmItem displayName,
            @RequestParam(name = "sortName", required = false) String sortName,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        
        UserPageUtils.resetAllSessionInSearchTicketFast(session);
        session.setAttribute("action", "search_movie");
        model.addAttribute("filmItems", FilmItem.values());
        if (displayName == null) {
            displayName = null;
        }
        if (sortName == null) {
            sortName = "nameByEnglish";
        }
        List<MovieEntity> movies = null;
        if (displayName != null) {
            movies = movieService.searchMovieByNameOrCastWithDisplayBy("%" + searchValue + "%", displayName, Sort.by(sortName).ascending());
        } else {
            movies = movieService.searchMovieByNameOrCast("%" + searchValue + "%", Sort.by(sortName).ascending());
        }

        if (movies == null) {
            model.addAttribute("message", "Không có movies nào tồn tại!!");
        }

        model.addAttribute("displayName", displayName);
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("movies", movies);
        model.addAttribute("displayName", displayName);
        model.addAttribute("sortName", sortName);
        model.addAttribute("top4Coming", movieService.viewTop4ByFilmItem(FilmItem.PHIM_DANG_CHIEU));

        return "/user/search_movie";
    }
}
