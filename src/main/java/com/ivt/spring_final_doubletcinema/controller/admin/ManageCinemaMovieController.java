/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingDetailEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingDetailService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.CinemaRoomService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
public class ManageCinemaMovieController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private CinemaMovieService cinemaMovieService;

    @Autowired
    private MovieService movieService;

    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private CinemaRoomService cinemaRoomService;

    @Autowired
    private BookingDetailService bookingDetailService;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat formatTime = new SimpleDateFormat("HH:mm");
    SimpleDateFormat standardFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

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

    public List<CinemaMovieEntity> checkExistBookingsCinemaMovie(Page<CinemaMovieEntity> cinemaMovies) throws ParseException {
        List<CinemaMovieEntity> cinemaMovieList = new ArrayList<>();
        for (CinemaMovieEntity cm : cinemaMovies) {
            List<BookingDetailEntity> bookingDetails = bookingDetailService.
                    findByMovieIdAndCinemaIdAndCinemaRoomIdAndShowDateAndShowTime(cm.getMovie().getId(),
                            cm.getCinema().getId(), cm.getCinemaRoom().getId(),
                            cm.getShowDate(), cm.getShowTime());
            if (bookingDetails.size() > 0) {
                cm.setCheckExistBookingsCinemaMovie(true);
                cinemaMovieList.add(cm);
            } else {
                cm.setCheckExistBookingsCinemaMovie(false);
                cinemaMovieList.add(cm);
            }
        }
        return cinemaMovieList;
    }

    @RequestMapping("/cinemaMovies")
    public String viewCinemaMovie(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) throws ParseException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "cinema_movies");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CinemaMovieEntity> cinemaMovies = cinemaMovieService.getCinemaMoviePagination(currentPage - 1, pageSize, Sort.by("showDate").descending().and(Sort.by("showTime").descending()));
        if (cinemaMovies != null) {
            List<CinemaMovieEntity> cinemaMovieList = checkExistBookingsCinemaMovie(cinemaMovies);
            int totalPages = cinemaMovies.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("cinemaMovies", cinemaMovieList);
        }
        return "/admin/cinema_movie";
    }

    @RequestMapping(value = "/searchCinemaMovies", method = RequestMethod.GET)
    public String searchCinemamovie(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) throws ParseException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_cinema_movies");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CinemaMovieEntity> cinemaMovies = cinemaMovieService.findCinemaMoviesByMovieAndCinemaAndRoom("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("show_date").descending().and(Sort.by("show_time").descending()));
        if (cinemaMovies != null) {
            List<CinemaMovieEntity> cinemaMovieList = checkExistBookingsCinemaMovie(cinemaMovies);
            int totalPages = cinemaMovies.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("cinemaMovies", cinemaMovieList);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/cinema_movie";
    }

    @RequestMapping("deleteCinemaMovie/{id}")
    public String deleteCinemaMovie(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        cinemaMovieService.deleteCinemaMovie(id);
        return "redirect:/admin/cinemaMovies";
    }

    @RequestMapping("addCinemaMovie")
    public String addCinemaMovie(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_cinema_movie");
        model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").descending()));
        model.addAttribute("cinemas", cinemaService.getCinemas());
        model.addAttribute("cinemaRooms", cinemaRoomService.getCinemaRooms());
        model.addAttribute("dateFormat", sdf.format(new Date()));
        model.addAttribute("timeFormat", formatTime.format(new Date()));
        return "/admin/form/form_cinema_movie";
    }

    @RequestMapping("editCinemaMovie/{id}")
    public String updateCinemaMovie(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        CinemaMovieEntity cinemaMovie = cinemaMovieService.findById(id);
        if (cinemaMovie.getId() > 0) {
            model.addAttribute("action", "update_cinema_movie");
            model.addAttribute("showDateFormat", sdf.format(cinemaMovie.getShowDate()));
            model.addAttribute("showTimeFormat", formatTime.format(cinemaMovie.getShowTime()));
        } else {
            model.addAttribute("action", "add_cinema_movie");
        }
        List<CinemaRoomEntity> cinemaRooms = cinemaRoomService.findByCinemaId(cinemaMovie.getCinema().getId());
        model.addAttribute("cinemaRooms", cinemaRooms);
        model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").descending()));
        model.addAttribute("cinemas", cinemaService.getCinemas());
        model.addAttribute("dateFormat", sdf.format(new Date()));
        model.addAttribute("timeFormat", formatTime.format(new Date()));
        model.addAttribute("cinemaMovie", cinemaMovie);
        return "/admin/form/form_cinema_movie";
    }

    @RequestMapping(value = "/resultSaveCinemaMovie", method = RequestMethod.POST)
    public String addCinemaMovie(
            @Valid @ModelAttribute("cinema_movie") CinemaMovieEntity cinemaMovie,
            BindingResult result,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (result.hasFieldErrors("movie.id")) {
                model.addAttribute("messageMovie", "Please Select Movie!");
            }
            if (result.hasFieldErrors("cinema.id")) {
                model.addAttribute("messageCinema", "Please Select Cinema!");
            } else {
                List<CinemaRoomEntity> cinemaRooms = cinemaRoomService.findByCinemaId(cinemaMovie.getCinema().getId());
                model.addAttribute("cinemaRooms", cinemaRooms);
            }
            if (cinemaMovie.getId() > 0) {
                model.addAttribute("action", "update_cinema_movie");
                model.addAttribute("showDateFormat", sdf.format(cinemaMovie.getShowDate()));
                model.addAttribute("showTimeFormat", formatTime.format(cinemaMovie.getShowTime()));
            } else {
                model.addAttribute("action", "add_cinema_movie");
            }
            model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").descending()));
            model.addAttribute("cinemas", cinemaService.getCinemas());
            model.addAttribute("dateFormat", sdf.format(new Date()));
            model.addAttribute("timeFormat", formatTime.format(new Date()));
            model.addAttribute("cinemaMovie", cinemaMovie);
            return "/admin/form/form_cinema_movie";
        } else {
            if (cinemaMovie.getCinema().getId() > 0) {
                if (cinemaMovie.getCinemaRoom().getId() > 0) {
                    if (cinemaMovie.getShowDate() == null) {
                        model.addAttribute("messageShowDate", "ShowDate is not null!");
                    } else {
                        if (cinemaMovie.getShowTime() == null) {
                            model.addAttribute("messageShowTime", "ShowTime is not null!");
                        } else {
                            CinemaMovieEntity cm = cinemaMovieService.findCinemaMovieByMovieIdAndCinemaIdAndDateAndTime(
                                    cinemaMovie.getMovie().getId(), cinemaMovie.getCinema().getId(), sdf.format(cinemaMovie.getShowDate()), formatTime.format(cinemaMovie.getShowTime()) + ":00");
                            if (cinemaMovie.getId() > 0) {
                                cinemaMovieService.saveOrUpdateCinemaMovie(cinemaMovie);
                                return "redirect:/admin/cinemaMovies";
                            } else {
                                if (cm.getId() > 0) {
                                    model.addAttribute("messageCinemaMovie", "CinemaMovie is existed!");
                                } else {
                                    cinemaMovieService.saveOrUpdateCinemaMovie(cinemaMovie);
                                    return "redirect:/admin/cinemaMovies";
                                }
                            }
                            model.addAttribute("showDateFormat", sdf.format(cinemaMovie.getShowDate()));
                            model.addAttribute("showTimeFormat", formatTime.format(cinemaMovie.getShowTime()));
                        }
                    }
                } else {
                    model.addAttribute("messageCinemaRoom", "Please Select Cinema Room!");
                }
                List<CinemaRoomEntity> cinemaRooms = cinemaRoomService.findByCinemaId(cinemaMovie.getCinema().getId());
                model.addAttribute("cinemaRooms", cinemaRooms);
            }
            model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").descending()));
            model.addAttribute("cinemas", cinemaService.getCinemas());
            model.addAttribute("dateFormat", sdf.format(new Date()));
            model.addAttribute("timeFormat", formatTime.format(new Date()));
            model.addAttribute("cinemaMovie", cinemaMovie);
            if (cinemaMovie.getId() > 0) {
                model.addAttribute("action", "update_cinema_movie");
                if (cinemaMovie.getShowDate() != null) {
                    model.addAttribute("showDateFormat", sdf.format(cinemaMovie.getShowDate()));
                }
                if (cinemaMovie.getShowTime() != null) {
                    model.addAttribute("showTimeFormat", formatTime.format(cinemaMovie.getShowTime()));
                }
            } else {
                model.addAttribute("action", "add_cinema_movie");
            }
            return "/admin/form/form_cinema_movie";

        }
    }
}
