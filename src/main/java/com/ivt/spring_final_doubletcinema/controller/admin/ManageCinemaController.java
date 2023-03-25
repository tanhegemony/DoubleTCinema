/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CategoryService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import java.util.ArrayList;
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
public class ManageCinemaController {

    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private CinemaMovieService cinemaMovieService;
    
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
    
    public List<CinemaEntity> checkExistCinemaMovies(Page<CinemaEntity> cinemas) {
        List<CinemaEntity> cinemaList = new ArrayList<>();
        for (CinemaEntity c : cinemas) {
            List<CinemaMovieEntity> cinemaMovies = cinemaMovieService.findByCinemaId(c.getId());
            if (cinemaMovies.size() > 0) {
                c.setCheckExistCinemaMovies(true);
                cinemaList.add(c);
            } else {
                c.setCheckExistCinemaMovies(false);
                cinemaList.add(c);
            }
        }
        return cinemaList;
    }

    @RequestMapping("/cinemas")
    public String viewCinema(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "cinemas");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<CinemaEntity> cinemas = cinemaService.getCinemaPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (cinemas != null) {
            List<CinemaEntity> cinemaList = checkExistCinemaMovies(cinemas);
            int totalPages = cinemas.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("cinemas", cinemaList);
        }
        return "/admin/cinema";
    }

    @RequestMapping(value = "/searchCinemas", method = RequestMethod.GET)
    public String searchCinema(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_cinemas");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CinemaEntity> cinemas = null;
        if (searchValue.equals("")) {
            cinemas = cinemaService.getCinemaPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        } else {
            cinemas = cinemaService.findCinemaByName(searchValue, currentPage - 1, pageSize, Sort.by("id").descending());
        }
        if (cinemas != null) {
            List<CinemaEntity> cinemaList = checkExistCinemaMovies(cinemas);
            int totalPages = cinemas.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("cinemas", cinemaList);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/cinema";
    }

    @RequestMapping("deleteCinema/{id}")
    public String deleteCinema(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        cinemaService.deleteCinema(id);
        return "redirect:/admin/cinemas";
    }

    @RequestMapping("editCinema/{id}")
    public String updateCinema(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        CinemaEntity cinema = cinemaService.findById(id);
        if (cinema.getId() > 0) {
            model.addAttribute("action", "update_cinema");
        } else {
            model.addAttribute("action", "add_cinema");
        }
        model.addAttribute("cinema", cinema);
        return "/admin/form/form_cinema";

    }

    @RequestMapping("addCinema")
    public String addCinema(
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_cinema");
        return "/admin/form/form_cinema";

    }

    @RequestMapping(value = {"resultSaveCinema"}, method = RequestMethod.POST)
    public String saveCinema(
            @Valid @ModelAttribute("cinema") CinemaEntity cinema,
            BindingResult result,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (cinema.getId() > 0) {
                model.addAttribute("action", "update_cinema");
            } else {
                model.addAttribute("action", "add_cinema");
            }
            return "/admin/form/form_cinema";
        } else {
            CinemaEntity findCinema = cinemaService.findByCinemaName(cinema.getNameCinema());
            if (findCinema.getId() > 0 && cinema.getId() <= 0) {
                model.addAttribute("messageCinemaName", "CinemaName is existed!");
                model.addAttribute("action", "add_cinema");
                return "/admin/form/form_cinema";
            } else {
                if (cinema.getGoogleMap().indexOf("https://goo.gl/maps/") == -1) {
                    model.addAttribute("messageGoogleMap", "Website Address Google Map is not in the correct format!");
                    if (cinema.getId() > 0) {
                        model.addAttribute("action", "update_cinema");
                    } else {
                        model.addAttribute("action", "add_cinema");
                    }
                    return "/admin/form/form_cinema";
                }else{
                    cinemaService.saveOrUpdateCinema(cinema);
                    return "redirect:/admin/cinemas";
                }
            }
        }
    }
}
