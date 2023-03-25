/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.controller.admin.ManageAccountBankingController;
import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingDetailService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.service.ReviewService;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author tanhegemony
 */
@Controller
public class HomeUserController {

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    private MovieService movieService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private CinemaMovieService cinemaMovieService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private BookingDetailService bookingDetailService;

    // handle part datetime
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    SimpleDateFormat stimef = new SimpleDateFormat("HH:mm:ss");

    // show film in menu
    public void viewFilmInHeaderInHomePage(Model model) {
        model.addAttribute("top4Coming", movieService.viewTop4ByFilmItem(FilmItem.PHIM_DANG_CHIEU));
        model.addAttribute("top4ComingSoon", movieService.viewTop4ByFilmItem(FilmItem.PHIM_SAP_CHIEU));
    }

    // get account login
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

    public void updateMovieFilmItem() throws IOException {
        URL location = ManageAccountBankingController.class.getProtectionDomain().getCodeSource().getLocation();
        String saveDirectory = location.getFile().substring(1, location.getPath().lastIndexOf("WEB-INF")) + "/resources/images/movies/";
        File dirComming = new File(saveDirectory + "/coming/");
        File[] childrenComings = dirComming.listFiles();
        List<MovieEntity> movies = movieService.getMovies();
        boolean existFileInFolder = false;
        for (MovieEntity movie : movies) {
            if (movie.getFilmItem().equals(FilmItem.PHIM_SAP_CHIEU) && movie.getPremiere().before(new Date())) {
                movie.setFilmItem(FilmItem.PHIM_DANG_CHIEU);
                movieService.saveOrUpdateMovie(movie);
                for (File childrenComing : childrenComings) {
                    if (childrenComing.toString().substring(childrenComing.toString().indexOf("\\coming\\") + 8).equals(movie.getImageMovie())) {
                        existFileInFolder = true;
                        break;
                    }
                }
                if (existFileInFolder == false) {
                    Files.copy(Paths.get(saveDirectory + "/coming soon/" + movie.getImageMovie()), Paths.get(saveDirectory + "/coming/" + movie.getImageMovie()));
                }
            }
        }

    }

    @RequestMapping(value = {"/*", "/home"})
    public String viewHomeUser(Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        session.setAttribute("action", "home");
        updateMovieFilmItem();
        //start search fast ticket
        String contentNav = request.getParameter("contentNav");
        if (contentNav == null) {
            contentNav = "";
        }
        model.addAttribute("contentNav", contentNav);
        //display movie by premiere in July
        model.addAttribute("searchFastTicketMovies",
                movieService.searchFastTicketMovie("2022-06-01", "2022-07-31"));
        //display list cinemas
        model.addAttribute("cinemas", cinemaService.getCinemas());

        String movieId = "";
        String cinemaId = "";
        Date startDate = new Date();
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, 5);
        Date endDate = cal.getTime();
        model.addAttribute("startDate", sdf.format(startDate));
        model.addAttribute("endDate", sdf.format(endDate));
        String showDate = sdf.format(startDate);
        String presentTime = stimef.format(startDate);

        if (contentNav.equals("filmFollow")) {
            session.setAttribute("cinemaIdDayFollow", "");
            session.setAttribute("showDateDayFollow", sdf.format(startDate));

            session.setAttribute("cinemaIdCinemaFollow", "");
            session.setAttribute("showDateCinemaFollow", sdf.format(startDate));

            movieId = (String) session.getAttribute("movieIdFilmFollow");
            cinemaId = (String) session.getAttribute("cinemaIdFilmFollow");
            showDate = (String) session.getAttribute("showDateFilmFollow");
            model.addAttribute("movieIdFilmFollow", movieId);
            model.addAttribute("cinemaIdFilmFollow", cinemaId);
            model.addAttribute("showDateFilmFollow", showDate);
        } else if (contentNav.equals("dayFollow")) {
            session.setAttribute("movieIdFilmFollow", "");
            session.setAttribute("showDateFilmFollow", sdf.format(startDate));

            session.setAttribute("cinemaIdCinemaFollow", "");
            session.setAttribute("showDateCinemaFollow", sdf.format(startDate));

            showDate = (String) session.getAttribute("showDateDayFollow");
            cinemaId = (String) session.getAttribute("cinemaIdDayFollow");
            if (cinemaId != null && !cinemaId.equals("")) {
                List<MovieEntity> movies = movieService.findMoviesByShowDateAndCinema(showDate, cinemaId);
                model.addAttribute("movies", movies);
            } else {
                cinemaId = "";
            }
            movieId = (String) session.getAttribute("movieIdDayFollow");

            model.addAttribute("movieIdDayFollow", movieId);
            model.addAttribute("cinemaIdDayFollow", cinemaId);
            model.addAttribute("showDateDayFollow", showDate);
        } else if (contentNav.equals("cinemaFollow")) {
            session.setAttribute("movieIdFilmFollow", "");
            session.setAttribute("showDateFilmFollow", sdf.format(startDate));

            session.setAttribute("cinemaIdDayFollow", "");
            session.setAttribute("showDateDayFollow", sdf.format(startDate));

            cinemaId = (String) session.getAttribute("cinemaIdCinemaFollow");
            if (cinemaId != null && !cinemaId.equals("")) {
                List<MovieEntity> movies = movieService.findMoviesByCinema(cinemaId);
                model.addAttribute("movies", movies);
            } else {
                cinemaId = "";
            }
            movieId = (String) session.getAttribute("movieIdCinemaFollow");
            showDate = (String) session.getAttribute("showDateCinemaFollow");

            model.addAttribute("movieIdCinemaFollow", movieId);
            model.addAttribute("cinemaIdCinemaFollow", cinemaId);
            model.addAttribute("showDateCinemaFollow", showDate);
        }
        if (movieId != null && !movieId.equals("") && !cinemaId.equals("")) {
            List<CinemaMovieEntity> cinemaMovies
                    = cinemaMovieService.getTimeByCinemaIdAndMovieIdAndShowDateAndPresentTime(
                            Long.parseLong(movieId), Long.parseLong(cinemaId), showDate, presentTime);
            model.addAttribute("cinemaMovies", cinemaMovies);
        }
//          end search fast ticket
        model.addAttribute("top6Coming", movieService.viewTop6ByFilmItem(FilmItem.PHIM_DANG_CHIEU));
        model.addAttribute("top6ComingSoon", movieService.viewTop6ByFilmItem(FilmItem.PHIM_SAP_CHIEU));
        model.addAttribute("reviews", reviewService.getReviews());
        return "/user/home_user";
    }

    @RequestMapping(value = "saveInfoSearchInSession", method = RequestMethod.POST)
    public String saveInfoSearchTicketInSession(
            Model model) throws ParseException {
        String contentNav = request.getParameter("contentNav");
        if (contentNav == null) {
            contentNav = "";
        }
        model.addAttribute("contentNav", contentNav);
        if (contentNav.equals("filmFollow")) {
            String movieId = request.getParameter("movieIdFilmFollow");
            session.setAttribute("movieIdFilmFollow", movieId);
            String cinemaId = request.getParameter("cinemaIdFilmFollow");
            session.setAttribute("cinemaIdFilmFollow", cinemaId);
            String showDate = request.getParameter("showDateFilmFollow");
            session.setAttribute("showDateFilmFollow", showDate);
            String showTime = request.getParameter("showTimeFilmFollow");
            session.setAttribute("showTimeFilmFollow", showTime);
        } else if (contentNav.equals("dayFollow")) {
            String movieId = request.getParameter("movieIdDayFollow");
            session.setAttribute("movieIdDayFollow", movieId);
            String cinemaId = request.getParameter("cinemaIdDayFollow");
            session.setAttribute("cinemaIdDayFollow", cinemaId);
            String showDate = request.getParameter("showDateDayFollow");
            session.setAttribute("showDateDayFollow", showDate);
            String showTime = request.getParameter("showTimeDayFollow");
            session.setAttribute("showTimeDayFollow", showTime);
        } else if (contentNav.equals("cinemaFollow")) {
            String movieId = request.getParameter("movieIdCinemaFollow");
            session.setAttribute("movieIdCinemaFollow", movieId);
            String cinemaId = request.getParameter("cinemaIdCinemaFollow");
            session.setAttribute("cinemaIdCinemaFollow", cinemaId);
            String showDate = request.getParameter("showDateCinemaFollow");
            session.setAttribute("showDateCinemaFollow", showDate);
            String showTime = request.getParameter("showTimeCinemaFollow");
            session.setAttribute("showTimeCinemaFollow", showTime);
        }
        session.setMaxInactiveInterval(5 * 60);
        session.setAttribute("quantity_booking_ticket", "0");
        session.setAttribute("quantity_booking_food", "0");
        return "redirect:home";
    }
}
