/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CategoryService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.utils.UserPageUtils;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author ngoct
 */
@Controller
public class MovieByItemController {

    @Autowired
    private MovieService movieService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    private AccountService accountService;

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

    @RequestMapping("movie_by_item")
    public String viewMovieByItem(
            @RequestParam(name = "sortName", required = false) String sortName,
            @RequestParam(name = "filterCategory", required = false) String filterCategory,
            @RequestParam(name = "filterNation", required = false) String filterNation,
            Model model) throws ParseException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        session.setAttribute("action", "movie_by_item");
        if (session.getAttribute("action") == "movie_by_item") {
            UserPageUtils.resetAllSessionInSearchTicketFast(session);
        }
        model.addAttribute("filmItems", FilmItem.values());
        model.addAttribute("categories", categoryService.getCategories());
        String contentNavMovieItem = request.getParameter("contentNavMovieItem");
        if (contentNavMovieItem == "" || contentNavMovieItem == null) {
            contentNavMovieItem = "PHIM_DANG_CHIEU";
        }
        if (sortName == "" || sortName == null) {
            sortName = "nameByEnglish";
        }
        List<MovieEntity> movies = new ArrayList<>();
        List<MovieEntity> removeListMovie = new ArrayList<>();
        if (filterCategory == null && filterNation == null) {
            movies = movieService.viewByFilmItem(FilmItem.valueOf(contentNavMovieItem), Sort.by(sortName).ascending());

        } else {
            movies = movieService.filterMovie(FilmItem.valueOf(contentNavMovieItem), filterCategory, filterNation, Sort.by(sortName).ascending());
        }

        if (movies == null || movies.size() <= 0) {
            if((filterCategory == null || filterCategory.equals("")) && (filterNation == null || filterNation.equals(""))){
                model.addAttribute("message", "Không có movies nào tồn tại"); 
            }else{
                model.addAttribute("message", "Không có movies nào tồn tại với "); 
            }
        } else {
            if (contentNavMovieItem.equals("PHIM_SAP_CHIEU")) {
                for (int i = 0; i < movies.size(); i++) {
                    if (movies.get(i).getPremiere().before(new Date())) {
                        removeListMovie.add(movies.get(i));
                    }
                }
                if (removeListMovie != null) {
                    for (MovieEntity rm : removeListMovie) {
                        movies.remove(rm);
                    }
                }
            }
        }
        model.addAttribute("contentNavMovieItem", contentNavMovieItem);
        model.addAttribute("sortName", sortName);
        model.addAttribute("filterCategory", filterCategory);
        model.addAttribute("filterNation", filterNation);
        model.addAttribute("movies", movies);

        return "/user/movie_by_item";
    }
}
