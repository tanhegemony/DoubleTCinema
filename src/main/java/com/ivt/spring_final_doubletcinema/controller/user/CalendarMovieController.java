/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.model.AllCinemaMoviesInOneDateDisplay;
import com.ivt.spring_final_doubletcinema.model.CinemaMovieDisplay;
import com.ivt.spring_final_doubletcinema.model.ListCalendarDateDisplay;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.utils.UserPageUtils;
import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author ngoct
 */
@Controller
public class CalendarMovieController {

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    private AccountService accountService;

    @Autowired
    private MovieService movieService;

    @Autowired
    private CinemaMovieService cinemaMovieService;

    @Autowired
    private CinemaService cinemaService;

    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    SimpleDateFormat stimef = new SimpleDateFormat("HH:mm:ss");
    SimpleDateFormat sdfOther = new SimpleDateFormat("E, YYYY-MM-dd");

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

    @RequestMapping("calendar_movie")
    public String calendarMovie(
            @RequestParam(name = "nameFilmFollow", required = false) String nameFilmFollow,
            @RequestParam(name = "cinemaId", required = false) String cinemaId,
            @RequestParam(name = "showDate", required = false) String showDate,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        model.addAttribute("action", "calendarMovie");
        
        UserPageUtils.resetAllSessionInSearchTicketFast(session);
        String contentNavCalendar = request.getParameter("contentNavCalendar");
        if (contentNavCalendar == null) {
            contentNavCalendar = "calendarFilmFollow";
        }
        if (contentNavCalendar.equals("calendarFilmFollow")) {
            List<CinemaMovieEntity> movies = cinemaMovieService.findCinemaMoviesByDateAndPresentTime(
                    sdf.format(new Date()), stimef.format(new Date()));
            model.addAttribute("movies", movies);
            List<CinemaEntity> cinemas = cinemaService.getCinemas();
            List<CinemaMovieDisplay> cinemaMoviesDisplay = new ArrayList<>();
            List<AllCinemaMoviesInOneDateDisplay> allCinemaMovies = new ArrayList<>();
            if (movies != null) {
                for (int i = 0; i < movies.size(); i++) {
                    cinemaMoviesDisplay = new ArrayList<>();
                    for (int j = 0; j < cinemas.size(); j++) {
                        List<CinemaMovieEntity> showTimes = cinemaMovieService.getListShowTimeByNameAndCinemaAndDateAndPresentTime(
                                movies.get(i).getMovie().getNameByEnglish(), cinemas.get(j).getId(), sdf.format(new Date()), stimef.format(new Date()));
                        CinemaMovieDisplay cinemaMovieDisplay
                                = new CinemaMovieDisplay(movies.get(i).getMovie(),
                                        cinemas.get(j), sdf.format(new Date()), showTimes);
                        cinemaMoviesDisplay.add(cinemaMovieDisplay);
                    }
                    AllCinemaMoviesInOneDateDisplay cinemaMovies = new AllCinemaMoviesInOneDateDisplay(movies.get(i).getMovie(), cinemaMoviesDisplay);
                    allCinemaMovies.add(cinemaMovies);
                }
            }
            model.addAttribute("allCinemaMovies", allCinemaMovies);
            model.addAttribute("cinemaMoviesDisplay", cinemaMoviesDisplay);

        } else if (contentNavCalendar.equals("calendarCinemaFollow")) {
            List<CinemaEntity> cinemas = cinemaService.getCinemas();
            model.addAttribute("cinemas", cinemas);
            if (cinemaId == null) {
                cinemaId = "1";
            }
            List<CinemaMovieEntity> cinemaMoviesCinemaId = cinemaMovieService.findCinemaMovieByCinemaAndDate(Long.parseLong(cinemaId), sdf.format(new Date()));
            List<CinemaMovieDisplay> cinemaMoviesDisplay = new ArrayList<>();
            if (cinemaMoviesCinemaId != null) {
                for (CinemaMovieEntity cmci : cinemaMoviesCinemaId) {
                    List<CinemaMovieEntity> showTimes = cinemaMovieService.
                            getListShowTimeByNameAndCinemaAndDateAndPresentTime(
                                    cmci.getMovie().getNameByEnglish(), cmci.getCinema().getId(), sdf.format(new Date()), stimef.format(new Date()));
                    if (showTimes.size() > 0) {
                        CinemaMovieDisplay cinemaMovieDisplay
                                = new CinemaMovieDisplay(cmci.getMovie(), cmci.getCinema(), sdf.format(new Date()), showTimes);
                        cinemaMoviesDisplay.add(cinemaMovieDisplay);
                    }

                }
            }
            model.addAttribute("cinemaId", cinemaId);
            model.addAttribute("cinemaMoviesDisplay", cinemaMoviesDisplay);
        } else if (contentNavCalendar.equals("calendarDayFollow")) {
            if (showDate == null) {
                showDate = sdf.format(new Date());
            }

            Calendar cal = Calendar.getInstance();
            List<ListCalendarDateDisplay> calendarDates = new ArrayList<>();
            calendarDates.add(new ListCalendarDateDisplay(sdfOther.format(new Date()), sdf.format(new Date())));
            for (int i = 1; i <= 5; i++) {
                cal.add(Calendar.DATE, 1);
                ListCalendarDateDisplay calendarDate
                        = new ListCalendarDateDisplay(sdfOther.format(cal.getTime()), sdf.format(cal.getTime()));
                calendarDates.add(calendarDate);
            }
            model.addAttribute("showDate", showDate);
            model.addAttribute("calendarDates", calendarDates);

            List<CinemaMovieEntity> movies
                    = cinemaMovieService.findCinemaMovieByDateAndPresentTime(showDate, stimef.format(new Date()));
            List<CinemaMovieDisplay> cinemaMoviesDisplay = new ArrayList<>();
            List<AllCinemaMoviesInOneDateDisplay> allCinemaMovies = new ArrayList<>();
            if (movies != null) {
                for (CinemaMovieEntity m : movies) {
                    cinemaMoviesDisplay = new ArrayList<>();
                    for (CinemaEntity c : cinemaService.getCinemas()) {
                        List<CinemaMovieEntity> showTimes = null;
                        if (showDate.equals(sdf.format(new Date()))) {
                            showTimes
                                    = cinemaMovieService.getListShowTimeByNameAndCinemaAndDateAndPresentTime(
                                            m.getMovie().getNameByEnglish(), c.getId(), showDate, stimef.format(new Date()));
                        } else if (!showDate.equals(sdf.format(new Date()))) {
                            showTimes
                                    = cinemaMovieService.getListShowTimeByNameAndCinemaAndDate(
                                            m.getMovie().getNameByEnglish(), showDate, c.getId());
                        }
                        if (showTimes.size() > 0) {
                            CinemaMovieDisplay cinemaMovieDisplay
                                    = new CinemaMovieDisplay(m.getMovie(), c, showDate, showTimes);
                            cinemaMoviesDisplay.add(cinemaMovieDisplay);
                        }
                    }
                    AllCinemaMoviesInOneDateDisplay allCinemaMovie
                            = new AllCinemaMoviesInOneDateDisplay(m.getMovie(), cinemaMoviesDisplay);
                    allCinemaMovies.add(allCinemaMovie);

                }
            }
            request.setAttribute("showDate", showDate);
            model.addAttribute("allCinemaMovies", allCinemaMovies);
        }
        session.setAttribute("contentNavCalendar", contentNavCalendar);
        return "/user/calendar_movie";
    }
}
