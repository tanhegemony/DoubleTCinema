/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.entities.SeatCinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.CinemaRoomService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.SeatCinemaRoomService;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
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
public class ManageCinemaRoomsController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private CinemaRoomService cinemaRoomService;

    @Autowired
    private SeatCinemaRoomService seatCinemaRoomService;

    @Autowired
    private CinemaService cinemaService;

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

    public List<CinemaRoomEntity> checkExistCinemaMovies(Page<CinemaRoomEntity> cinemaRooms) {
        List<CinemaRoomEntity> cinemaRoomList = new ArrayList<>();
        for (CinemaRoomEntity cr : cinemaRooms) {
            List<CinemaMovieEntity> cinemaMovies = cinemaMovieService.findByCinemaRoomId(cr.getId());
            if (cinemaMovies.size() > 0) {
                cr.setCheckExistCinemaMovies(true);
                cinemaRoomList.add(cr);
            } else {
                cr.setCheckExistCinemaMovies(false);
                cinemaRoomList.add(cr);
            }
        }
        return cinemaRoomList;
    }

    @RequestMapping("/cinemaRooms")
    public String viewCinemaRooms(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "cinema_rooms");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CinemaRoomEntity> cinemaRooms = cinemaRoomService.getCinemaRoomsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (cinemaRooms != null) {
            List<CinemaRoomEntity> cinemaRoomList = checkExistCinemaMovies(cinemaRooms);
            int totalPages = cinemaRooms.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("cinemaRooms", cinemaRoomList);
        }
        return "/admin/cinema_room";
    }

    @RequestMapping(value = "searchCinemaRooms", method = RequestMethod.GET)
    public String searchCinemaRooms(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_cinema_rooms");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CinemaRoomEntity> cinemaRooms = null;
        if (searchValue.equals("")) {
            cinemaRooms = cinemaRoomService.getCinemaRoomsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        } else {
            cinemaRooms = cinemaRoomService.findCinemaRoomByNameAndCinemaName("%"+searchValue+"%", currentPage - 1, pageSize, Sort.by("id").descending());
        }
        if (cinemaRooms != null) {
            List<CinemaRoomEntity> cinemaRoomList = checkExistCinemaMovies(cinemaRooms);
            int totalPages = cinemaRooms.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageNumbers", totalPages);
            model.addAttribute("cinemaRooms", cinemaRoomList);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/cinema_room";
    }

    @RequestMapping("addCinemaRoom")
    public String addCinemaRoom(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("cinemas", cinemaService.getCinemas());
        model.addAttribute("action", "add_cinema_room");
        return "/admin/form/form_cinema_room";
    }

    @RequestMapping("editCinemaRoom/{id}")
    public String updateCinemaRoom(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "update_cinema_room");
        CinemaRoomEntity cinemaRoom = cinemaRoomService.findById(id);
        model.addAttribute("cinemas", cinemaService.getCinemas());
        model.addAttribute("cinemaRoom", cinemaRoom);
        return "/admin/form/form_cinema_room";
    }

    @RequestMapping(value = {"resultSaveCinemaRoom"}, method = RequestMethod.POST)
    public String saveOrUpdateRoom(HttpServletRequest request, Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        
        String action = request.getParameter("action");
        String cinemaRoomId = request.getParameter("cinemaRoomId");
        String cinema = request.getParameter("cinema");
        String cinemaRoomName = request.getParameter("cinemaRoomName");
        String rowCinemaRoomString = request.getParameter("rowCinemaRoom");
        String columnCinemaRoomString = request.getParameter("columnCinemaRoom");

        boolean checkParam = cinemaRoomService.checkParam(request, action,
                cinema, cinemaRoomName, rowCinemaRoomString, columnCinemaRoomString,
                model);
        if (checkParam == true) {
            if (Long.parseLong(cinemaRoomId) > 0) {
                // lấy danh sách các seat trong cinemaRoomId tại table
                List<SeatCinemaRoomEntity> seatsCR = seatCinemaRoomService.findSeatCinemaRoomById(Long.parseLong(cinemaRoomId));
                seatCinemaRoomService.deleteSeatCinemaRoom(seatsCR);
                cinemaRoomService.saveOrUpdateCinemaRoom(Long.parseLong(cinemaRoomId),
                        Long.parseLong(cinema), cinemaRoomName, Integer.parseInt(rowCinemaRoomString),
                        Integer.parseInt(columnCinemaRoomString));
                seatCinemaRoomService.addSeatCinemaRoomInManageCinemaRoom(Long.parseLong(cinemaRoomId),
                        cinema, cinemaRoomName, rowCinemaRoomString, columnCinemaRoomString);
                model.addAttribute("action", "update_cinema_room");
            } else {
                cinemaRoomService.saveOrUpdateCinemaRoom(0,
                        Long.parseLong(cinema), cinemaRoomName, Integer.parseInt(rowCinemaRoomString),
                        Integer.parseInt(columnCinemaRoomString));
                CinemaRoomEntity findCinemaRoom = cinemaRoomService.findByNameAndCinemaId(cinemaRoomName, Long.parseLong(cinema));
                seatCinemaRoomService.addSeatCinemaRoomInManageCinemaRoom(findCinemaRoom.getId(),
                        cinema, cinemaRoomName, rowCinemaRoomString, columnCinemaRoomString);

                model.addAttribute("action", "add_cinema_room");
            }
            return "redirect:/admin/cinemaRooms";
        } else {
            if (Long.parseLong(cinemaRoomId) > 0) {
                model.addAttribute("action", "update_cinema_room");
            } else {
                model.addAttribute("action", "add_cinema_room");
            }
            model.addAttribute("cinemaRoomId", cinemaRoomId);
            model.addAttribute("cinema", cinema);
            model.addAttribute("cinemaRoomName", cinemaRoomName);
            model.addAttribute("rowCinemaRoomString", rowCinemaRoomString);
            model.addAttribute("columnCinemaRoomString", columnCinemaRoomString);
            return "/admin/form/form_cinema_room";
        }
    }

    @RequestMapping("deleteCinemaRoom/{id}")
    public String deleteCinemaRoom(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        cinemaRoomService.deleteCinemaRoom(id);
        return "redirect:/admin/cinemaRooms";
    }
}
