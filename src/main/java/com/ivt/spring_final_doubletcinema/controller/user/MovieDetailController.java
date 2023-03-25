/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CategoryEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.entities.ViewedMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.VoteMovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.model.CinemaMovieDisplay;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CategoryService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.service.ViewedMovieService;
import com.ivt.spring_final_doubletcinema.service.VoteMovieService;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author ngoct
 */
@Controller
public class MovieDetailController {

    @Autowired
    private MovieService movieService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private VoteMovieService voteMovieService;

    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private CinemaMovieService cinemaMovieService;

    @Autowired
    private ViewedMovieService viewedMovieService;

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    SimpleDateFormat stimef = new SimpleDateFormat("HH:mm:ss");

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

    @RequestMapping("movieDetail/{id}")
    public String viewMovieDetail(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        //        define action
        session.setAttribute("action", "movieDetail");
        //        header view film
        viewFilmInHeaderInHomePage(model);
//        display movie detail
        MovieEntity movie = movieService.findByMovieId(id);
        if (movie.getId() > 0) {
            String JSESSION = session.getId();

            if (accountLogin.getId() > 0 && !JSESSION.equals("")) {
                ViewedMovieEntity findViewedMovieByAccountIDAndJSessionAndMovieId = viewedMovieService.findVMByAccountIdAndJSessionAndMovieId(accountLogin.getId(), JSESSION, movie.getId());
                if(findViewedMovieByAccountIDAndJSessionAndMovieId.getId() <= 0){
                    movie.setViewedNumber(movie.getViewedNumber() + 1);
                    movieService.saveOrUpdateMovie(movie);
                    
                    ViewedMovieEntity viewedMovie = new ViewedMovieEntity();
                    viewedMovie.setAccount(accountLogin);
                    viewedMovie.setJSession(JSESSION);
                    viewedMovie.setMovie(movie);
                    viewedMovieService.saveViewedMovie(viewedMovie);
                }
            } else if (accountLogin.getId() <= 0 && !JSESSION.equals("")) {
                ViewedMovieEntity findViewedMovieByJSessionAndMovieId = viewedMovieService.findVMByJSessionAndMovieId(JSESSION, movie.getId());
                if (findViewedMovieByJSessionAndMovieId.getId() <= 0) {
                    movie.setViewedNumber(movie.getViewedNumber() + 1);
                    movieService.saveOrUpdateMovie(movie);
                    
                    ViewedMovieEntity viewedMovie = new ViewedMovieEntity();
                    viewedMovie.setJSession(JSESSION);
                    viewedMovie.setMovie(movie);
                    viewedMovieService.saveViewedMovie(viewedMovie);
                }
            }
        }
        List<CategoryEntity> categories = categoryService.getCategoryByMovieId(id);
        model.addAttribute("categories", categories);
        session.setAttribute("movieId", id);
        session.setAttribute("movie", movie);

//        handle vote movie
        int starVote = voteMovieService.averageStarVote(id);
        model.addAttribute("starVote", starVote);

        List<VoteMovieEntity> votes = voteMovieService.getListVoteByMovieId(id);
        model.addAttribute("votes", votes);

//        start  handle calendar movie
        Date startDate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 5);
        Date endDate = cal.getTime();
        model.addAttribute("startDate", sdf.format(startDate));
        model.addAttribute("endDate", sdf.format(endDate));

        model.addAttribute("cinemas", cinemaService.getCinemas());

        String cinemaId = (String) session.getAttribute("cinemaId");
        String showDate = (String) session.getAttribute("showDate");
        String presentTime = stimef.format(startDate);

        List<CinemaMovieEntity> cinemaMovies = new ArrayList<>();
        List<CinemaMovieDisplay> cinemaMoviesDisplay = new ArrayList<>();
        if (showDate == null) {
            showDate = sdf.format(startDate);
        }
        if (cinemaId == null || cinemaId.equals("0") || cinemaId.equals("")) {
            cinemaMovies = cinemaMovieService.findCinemaMovieByNameAndDate(movie.getNameByEnglish(), showDate);
        } else {
            cinemaMovies = cinemaMovieService.findCinemaMovieByMovieAndCinemaAndShowDate(movie.getId(),
                    Long.parseLong(cinemaId), showDate);
        }
        if (cinemaMovies.size() > 0) {
            List<CinemaMovieEntity> showTimes = null;
            for (CinemaMovieEntity cinemaMovie : cinemaMovies) {
                if (showDate.equals(sdf.format(new Date()))) {
                    showTimes
                            = cinemaMovieService.getListShowTimeByNameAndCinemaAndDateAndPresentTime(
                                    cinemaMovie.getMovie().getNameByEnglish(),
                                    cinemaMovie.getCinema().getId(),
                                    showDate, presentTime);
                } else if (!showDate.equals(sdf.format(new Date()))) {
                    showTimes
                            = cinemaMovieService.getListShowTimeByNameAndCinemaAndDate(
                                    cinemaMovie.getMovie().getNameByEnglish(),
                                    showDate, cinemaMovie.getCinema().getId());
                }
                if (showTimes.size() > 0) {
                    CinemaMovieDisplay cinemaMovieDisplay
                            = new CinemaMovieDisplay(cinemaMovie.getMovie(), cinemaMovie.getCinema(),
                                    showDate, showTimes);

                    cinemaMoviesDisplay.add(cinemaMovieDisplay);
                } else {
                    model.addAttribute("message", "KHÔNG CÓ LỊCH CHIẾU TẠI RẠP NÀY CỦA NGÀY");
                }

            }
        } else if (cinemaMovies.size() <= 0) {
            model.addAttribute("message", "KHÔNG CÓ LỊCH CHIẾU CỦA NGÀY");
        }

        model.addAttribute("cinemaMoviesDisplay", cinemaMoviesDisplay);
//        end  handle calendar movie

        // handle one day one movie one account only one vote
        boolean existVote = false;
        VoteMovieEntity findVoteMovie = voteMovieService.findByAccountIdAndVoteDateStartingAndMovieId(
                accountLogin.getId(), sdf.format(new Date()) + "%", movie.getId());
        if (findVoteMovie != null && findVoteMovie.getId() > 0) {
            existVote = true;
        }
        model.addAttribute("existVote", existVote);

//        display movie coming
        model.addAttribute("top6Coming", movieService.viewTop6ByFilmItem(FilmItem.PHIM_DANG_CHIEU));

        return "/user/movie_detail";
    }

    @RequestMapping(value = "/saveCinemaMovieInSession", method = RequestMethod.POST)
    public String saveCinemaMovieInSession(
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        String showDate = request.getParameter("showDate");
        String cinemaId = request.getParameter("cinemaId");
        session.setAttribute("showDate", showDate);
        session.setAttribute("cinemaId", cinemaId);
        return "redirect:movieDetail/" + session.getAttribute("movieId");
    }

    @RequestMapping(value = "addVoteMovie", method = RequestMethod.POST)
    public String addVoteMovie(
            @ModelAttribute("voteMovie") VoteMovieEntity voteMovie,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        voteMovie.setAccount(accountLogin);
        voteMovie.setDisplay(true);
        MovieEntity movie = new MovieEntity();
        movie.setId((long) session.getAttribute("movieId"));
        voteMovie.setMovie(movie);
        Date today = new Date();
        Timestamp voteDate = new Timestamp(today.getTime());
        voteMovie.setVoteDate(voteDate);
        voteMovieService.saveVoteMovie(voteMovie);

        return "redirect:movieDetail/" + session.getAttribute("movieId");
    }
}
