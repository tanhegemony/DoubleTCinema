/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingSeatEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.entities.FoodEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.entities.SeatEntity;
import com.ivt.spring_final_doubletcinema.entities.TicketEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingSeatService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.CinemaRoomService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.FoodService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.service.SeatService;
import com.ivt.spring_final_doubletcinema.service.TicketService;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 *
 * @author ngoct
 */
@Controller
public class BookingController {
    
    @Autowired
    private AccountService accountService;
    
    @Autowired
    private MovieService movieService;
    
    @Autowired
    private CinemaService cinemaService;
    
    @Autowired
    private CinemaMovieService cinemaMovieService;
    
    @Autowired
    private SeatService seatService;
    
    @Autowired
    private BookingSeatService bookingSeatService;
    
    @Autowired
    private FoodService foodService;

    @Autowired
    private TicketService ticketService;
    
    @Autowired
    private CinemaRoomService cinemaRoomService;
    
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
    
    @RequestMapping("booking")
    public String viewBooking(
            @RequestParam(name = "movieId", required = false) String movieIdUrl,
            @RequestParam(name = "cinemaId", required = false) String cinemaIdUrl,
            @RequestParam(name = "showDate", required = false) String showDateUrl,
            @RequestParam(name = "showTime", required = false) String showTimeUrl,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        model.addAttribute("action", "booking");
        // check seat
        if (session.getAttribute("selectedSeats") != null) {
            session.setAttribute("selectedSeats", new ArrayList<>());
        }

        // thông tin
        // of search fast
        String movieId = movieIdUrl;
        String cinemaId = cinemaIdUrl;
        String showDate = showDateUrl;
        String showTime = showTimeUrl;

        session.setAttribute("movieId", movieId);
        session.setAttribute("cinemaId", cinemaId);
        session.setAttribute("showDate", showDate);
        session.setAttribute("showTime", showTime);

        MovieEntity movie = movieService.findByMovieId(Long.parseLong(movieId));
        CinemaEntity cinema = cinemaService.findByCinemaId(Long.parseLong(cinemaId));
        CinemaMovieEntity cinemaMovie
                = cinemaMovieService.findCinemaMovieByMovieIdAndCinemaIdAndDateAndTime(
                        Long.parseLong(movieId), Long.parseLong(cinemaId), showDate, showTime);
        // check seat not book
        List<SeatEntity> seats = seatService.findSeatsByCinemaRoomId(cinemaMovie.getCinemaRoom().getId());
        if (seats != null) {
            List<BookingSeatEntity> bookingSeats
                    = bookingSeatService.findBookingSeatBooked(sdf.format(new Date()) + "%",
                            Long.parseLong(movieId), Long.parseLong(cinemaId), cinemaMovie.getCinemaRoom().getId(), showTime);
            if (bookingSeats.size() > 0) {
                for (SeatEntity seat : seats) {
                    for (BookingSeatEntity bs : bookingSeats) {
                        if (seat.getSeatNumber().equals(bs.getSeatNumber())) {
                            seat.setBooked(true);
                            break;
                        }
                    }
                }
            }
        }
        List<SeatEntity> seatsBooked = new ArrayList<>();
        for (SeatEntity seat : seats) {
            if (seat.isBooked() == true) {
                seatsBooked.add(seat);
            }
        }

        // buy food and ticket
        List<TicketEntity> tickets = ticketService.getTickets();
        List<FoodEntity> foods = foodService.getFoods();
        String quantity_ticket[] = request.getParameterValues("quantity_booking_ticket");
        String quantity_food[] = request.getParameterValues("quantity_booking_food");
        double totalPriceTicket = 0.0;
        double totalPriceFood = 0.0;
        int quantityTicket = 0;
        int quantityFood = 0;
        boolean ticketCouple = false;
        boolean foodCouple = false;
        List<TicketEntity> selectedTickets = new ArrayList<>();
        for (int i = 0; i < tickets.size(); i++) {
            if (quantity_ticket == null) {
                tickets.get(i).setQuantity(0);
            } else {
                tickets.get(i).setQuantity(Integer.parseInt(quantity_ticket[i]));
            }
            if (tickets.get(i).getQuantity() < 0) {
                tickets.get(i).setQuantity(0);
            }
            if (tickets.get(i).getQuantity() > (seats.size() - seatsBooked.size())) {
                tickets.get(i).setQuantity(seats.size() - seatsBooked.size());
            }
            if (tickets.get(i).getQuantity() > 0) {
                selectedTickets.add(tickets.get(i));
            }
            if (tickets.get(2).getQuantity() > 0) {
                ticketCouple = true;
            }
            quantityTicket += tickets.get(i).getQuantity();
            totalPriceTicket += tickets.get(i).getQuantity() * tickets.get(i).getTicketPrice();
        }
        List<FoodEntity> selectedFoods = new ArrayList<>();
        for (int i = 0; i < foods.size(); i++) {
            if (quantity_food == null) {
                foods.get(i).setQuantity(0);
            } else {
                foods.get(i).setQuantity(Integer.parseInt(quantity_food[i]));
            }
            if (foods.get(i).getQuantity() < 0) {
                foods.get(i).setQuantity(0);
            }
            if (foods.get(i).getQuantity() > 10) {
                foods.get(i).setQuantity(10);
            }
            if (foods.get(i).getQuantity() > 0) {
                selectedFoods.add(foods.get(i));
            }
            if (foods.get(0).getQuantity() > 0) {
                foodCouple = true;
            }

            quantityFood += foods.get(i).getQuantity();
            totalPriceFood += foods.get(i).getQuantity() * foods.get(i).getPriceFood();
        }
        if (foodCouple == true) {
            quantityFood = quantityFood - foods.get(0).getQuantity() + (foods.get(0).getQuantity() * 2);
        }
        session.setAttribute("tickets", tickets);
        session.setAttribute("foods", foods);

        session.setAttribute("selectedFoods", selectedFoods);

        session.setAttribute("selectedTickets", selectedTickets);

        session.setAttribute("totalPriceTicket", totalPriceTicket);
        session.setAttribute("totalPriceFood", totalPriceFood);

        session.setAttribute("quantityTicket", quantityTicket);
        session.setAttribute("quantityFood", quantityFood);
        session.setAttribute("ticketCouple", ticketCouple);

        double totalBooking = totalPriceTicket + totalPriceFood;
        session.setAttribute("totalBooking", totalBooking);
        model.addAttribute("seatsBooked", seatsBooked);
        model.addAttribute("seats", seats);
        session.setAttribute("movie", movie);
        session.setAttribute("cinema", cinema);
        session.setAttribute("cinemaMovie", cinemaMovie);
        return "/user/booking";
    }

    @RequestMapping("booking_seat")
    public String selectSeat(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        if (session.getAttribute("movieId") == null) {
            return "redirect:/home";
        } else {
            model.addAttribute("action", "select_seat");
            CinemaMovieEntity cinemaMovie = (CinemaMovieEntity) session.getAttribute("cinemaMovie");
            CinemaRoomEntity cinemaRoom = cinemaRoomService.findByCinemaRoomId(cinemaMovie.getCinemaRoom().getId());
            model.addAttribute("cinemaRoom", cinemaRoom);
            List<SeatEntity> seats = seatService.findSeatsByCinemaRoomId(cinemaMovie.getCinemaRoom().getId());
            if (seats != null) {
                List<BookingSeatEntity> bookingSeats
                        = bookingSeatService.findBookingSeatBooked(sdf.format(new Date()) + "%",
                                cinemaMovie.getMovie().getId(), cinemaMovie.getCinema().getId(), cinemaMovie.getCinemaRoom().getId(), stimef.format(cinemaMovie.getShowTime()));
                if (bookingSeats.size() > 0) {
                    for (SeatEntity seat : seats) {
                        for (BookingSeatEntity bs : bookingSeats) {
                            if (seat.getSeatNumber().equals(bs.getSeatNumber())) {
                                seat.setBooked(true);
                                break;
                            }
                        }
                    }
                }
            }

            List<SeatEntity> selectedSeats = (List<SeatEntity>) session.getAttribute("selectedSeats");
            int quantityTicket = (int) session.getAttribute("quantityTicket");
            boolean ticketCouple = (boolean) session.getAttribute("ticketCouple");
            List<TicketEntity> tickets = (List<TicketEntity>) session.getAttribute("tickets");
            if (ticketCouple == true) {
                quantityTicket = quantityTicket - tickets.get(2).getQuantity() + (tickets.get(2).getQuantity() * 2);
            }
            if (selectedSeats != null) {
                for (SeatEntity seat : seats) {
                    for (SeatEntity s : selectedSeats) {
                        if (seat.getSeatNumber().equals(s.getSeatNumber())
                                && seat.isSelected() == false && s.isSelected() == true && s.isCanNotSelected() == false) {
                            seat.setSelected(true);
                            break;
                        }
                    }
                }
                if (selectedSeats.size() == quantityTicket) {
                    for (SeatEntity seat : seats) {
                        if (seat.isSelected() == false && seat.isCanNotSelected() == false) {
                            seat.setCanNotSelected(true);
                        }
                    }
                }
                session.setAttribute("selectedSeatsStr", selectedSeats.toString());
            }
            model.addAttribute("quantityTicket", quantityTicket);
            model.addAttribute("cinemaRoom", cinemaRoom);
            model.addAttribute("selectSeats", selectedSeats);
            model.addAttribute("seats", seats);
        }

        return "/user/select_seat";
    }

    @RequestMapping(value = "select-seat", method = RequestMethod.GET)
    public @ResponseBody
    String selectSeat() {
        List<SeatEntity> selectedSeats = (List<SeatEntity>) session.getAttribute("selectedSeats");
        String seatStr = request.getParameter("seat");
        String cinemaRoomId = request.getParameter("cinemaRoomId");

        if (seatStr != null && cinemaRoomId != null) {
            SeatEntity seat = seatService.findBySeatNumberAndCinemaRoomId(seatStr, Long.parseLong(cinemaRoomId));
            if (seat != null) {
                if (selectedSeats != null && selectedSeats.size() > 0) {
                    boolean exist = false;
                    for (SeatEntity selectedSeat : selectedSeats) {
                        if (selectedSeat.getSeatNumber().equals(seatStr)) {
                            exist = true;
                            selectedSeats.remove(selectedSeat);
                            break;
                        }
                    }
                    if (!exist) {
                        seat.setSelected(true);
                        selectedSeats.add(seat);
                    }
                } else {
                    selectedSeats = new ArrayList<>();
                    seat.setSelected(true);
                    selectedSeats.add(seat);
                }
            }
        }
        session.setAttribute("selectedSeats", selectedSeats);
        return "booking_seat";
    }
}
