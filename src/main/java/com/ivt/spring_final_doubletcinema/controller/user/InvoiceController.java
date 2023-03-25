/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountBankingEntity;
import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingDetailEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingFoodEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingSeatEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingTicketEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
import com.ivt.spring_final_doubletcinema.entities.FoodEntity;
import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.entities.PromotionEntity;
import com.ivt.spring_final_doubletcinema.entities.RoleAccountEntity;
import com.ivt.spring_final_doubletcinema.entities.SeatEntity;
import com.ivt.spring_final_doubletcinema.entities.TicketEntity;
import com.ivt.spring_final_doubletcinema.enums.AccountBankingStatus;
import com.ivt.spring_final_doubletcinema.enums.BookingStatus;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.enums.PaymentTypes;
import com.ivt.spring_final_doubletcinema.enums.RoleAccount;
import com.ivt.spring_final_doubletcinema.service.AccountBankingService;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingDetailService;
import com.ivt.spring_final_doubletcinema.service.BookingFoodService;
import com.ivt.spring_final_doubletcinema.service.BookingSeatService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.BookingTicketService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.InvoiceService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author ngoct
 */
@Controller
@RequestMapping("/user/")
public class InvoiceController {

    @Autowired
    private MovieService movieService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private AccountBankingService accountBankingService;

    @Autowired
    private BookingSeatService bookingSeatService;

    @Autowired
    private BookingTicketService bookingTicketService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private CinemaService cinemaService;

    @Autowired
    private BookingDetailService bookingDetailService;

    @Autowired
    private BookingFoodService bookingFoodService;

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    HttpSession session;

    // send mail
    @Autowired
    JavaMailSender mailSender;

    @Autowired
    HttpServletRequest request;

    SimpleDateFormat dfyear = new SimpleDateFormat("yy");
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    SimpleDateFormat stimef = new SimpleDateFormat("HH:mm:ss");
    SimpleDateFormat parseStringtoDate = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfStandard = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
    SimpleDateFormat sdfStandard1 = new SimpleDateFormat("yy-MM");

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

    // send mail
    public void sendEmail(String from, String to, String subject, String content) throws MessagingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        boolean multipart = true;
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, multipart, "utf-8");
        helper.setFrom(from);
        helper.setTo(to);
        helper.setSubject(subject);
        mimeMessage.setContent(content, "text/html; charset=utf-8");
        mailSender.send(mimeMessage);
    }

    @RequestMapping("viewInvoice")
    public String viewInvoice(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        if (session.getAttribute("usedPromotion") == null) {
            return "redirect:/home";
        } else {
            AccountBankingEntity ab = accountBankingService.findByCustomerId(accountLogin.getCustomer().getId());
            model.addAttribute("ab", ab);
            boolean usedPromotion = (boolean) session.getAttribute("usedPromotion");
            if (usedPromotion == true) {
                session.setAttribute("promotion", new PromotionEntity());
            }
            model.addAttribute("yearCurrent", dfyear.format(new Date()));
            return "/user/invoice";
        }
    }

    @RequestMapping(value = "invoice", method = RequestMethod.POST)
    public String invoice(
            @Valid @ModelAttribute("accountBanking") AccountBankingEntity accountBanking,
            BindingResult result,
            Model model) throws ParseException, MessagingException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        AccountBankingEntity ab = accountBankingService.findByCustomerId(accountLogin.getCustomer().getId());
        // payment accountbanking
        if (result.hasErrors()) {
            model.addAttribute("accountBanking", accountBanking);
            model.addAttribute("yearCurrent", dfyear.format(new Date()));
            model.addAttribute("ab", ab);
            return "/user/invoice";
        } else {
            // check account banking
            AccountBankingEntity accBanking = accountBankingService
                    .findABByCardNumberAndCardNameAndMonthExpiryDateAndYearExpiryDateAndCVVCode(
                            accountBanking.getCardNumber(), accountBanking.getCardName(),
                            accountBanking.getMonthExpiryDate(), accountBanking.getYearExpiryDate(),
                            accountBanking.getCvvCode());
            CustomerEntity customer = (CustomerEntity) session.getAttribute("customer");
            if (accBanking.getCardNumber() == null) {
                model.addAttribute("accountBanking", accountBanking);
                model.addAttribute("yearCurrent", dfyear.format(new Date()));
                model.addAttribute("ab", ab);
                String messageInvoice = request.getRequestURL().substring(0, request.getRequestURL().lastIndexOf(request.getContextPath())) + request.getContextPath();
                model.addAttribute("messageInvoice", "Tài khoản không tồn tại. Liên kết tài khoản tại <a target='_blank' href='" + messageInvoice + "/manage_user?contentNavManageUser=manageAccountBanking'>Quản lý ngân hàng cá nhân</a>");
                return "/user/invoice";
            } else {
                if (accBanking.getStatus().equals(AccountBankingStatus.UNACTIVE)) {
                    model.addAttribute("accountBanking", accountBanking);
                    model.addAttribute("yearCurrent", dfyear.format(new Date()));
                    model.addAttribute("ab", ab);
                    model.addAttribute("messageInvoice", "Tài khoản ngân hàng của bạn không thể sử dụng (không hoạt động)");
                    return "/user/invoice";
                } else {
                    Calendar calendar = Calendar.getInstance();
                    calendar.set(Calendar.MONTH, accBanking.getMonthExpiryDate());
                    calendar.set(Calendar.YEAR, accBanking.getYearExpiryDate());
                    Calendar calendarNow = Calendar.getInstance();
                    if (sdfStandard1.parse(sdfStandard1.format(calendar.getTime())).before(sdfStandard1.parse(sdfStandard1.format(calendarNow.getTime())))) {
                        model.addAttribute("accountBanking", accountBanking);
                        model.addAttribute("yearCurrent", dfyear.format(new Date()));
                        model.addAttribute("ab", ab);
                        model.addAttribute("messageInvoice", "Tài khoản ngân hàng của bạn đã hết hạn!");
                        return "/user/invoice";
                    } else {
                        double subtotal = (double) session.getAttribute("subtotal");
                        if (accBanking.getBalance() >= subtotal) {
                            // define cinema movie to find cinema room 
                            CinemaMovieEntity cinemaMovie = (CinemaMovieEntity) session.getAttribute("cinemaMovie");
                            // check booking seat in database
                            List<SeatEntity> selectedSeats = (List<SeatEntity>) session.getAttribute("selectedSeats");
                            boolean seatBuyed = false;
                            if (selectedSeats != null) {
                                List<BookingSeatEntity> bookingSeatsBooked
                                        = bookingSeatService.findBookingSeatBooked(sdf.format(new Date()) + "%",
                                                cinemaMovie.getMovie().getId(), cinemaMovie.getCinema().getId(), cinemaMovie.getCinemaRoom().getId(), stimef.format(cinemaMovie.getShowTime()));

                                if (bookingSeatsBooked.size() > 0) {
                                    for (SeatEntity seat : selectedSeats) {
                                        for (BookingSeatEntity bs : bookingSeatsBooked) {
                                            if (seat.getSeatNumber().equals(bs.getSeatNumber())) {
                                                seatBuyed = true;
                                                break;
                                            }
                                        }
                                    }

                                }
                            }

                            if (seatBuyed == false) {
                                boolean usedPromotion = (boolean) session.getAttribute("usedPromotion");
                                PromotionEntity promotion = (PromotionEntity) session.getAttribute("promotion");

                                // save booking
                                BookingEntity booking = new BookingEntity();
                                booking.setSubtotal(subtotal);
                                booking.setNote((String) session.getAttribute("note"));
                                if (usedPromotion == false) {
                                    booking.setCode(promotion.getCode());
                                    booking.setDiscount(promotion.getValuePromotion());
                                }
                                booking.setCustomer(customer);
                                booking.setStatus(BookingStatus.Completed);
                                bookingService.saveBooking(booking);

                                //add booking detail
                                String movieId = (String) session.getAttribute("movieId");
                                String cinemaId = (String) session.getAttribute("cinemaId");
                                String showDate = (String) session.getAttribute("showDate");
                                String showTime = (String) session.getAttribute("showTime");
                                boolean ticketCouple = (boolean) session.getAttribute("ticketCouple");
                                int quantityTicket = (int) session.getAttribute("quantityTicket");
                                List<TicketEntity> tickets = (List<TicketEntity>) session.getAttribute("tickets");
                                if (ticketCouple == true) {
                                    quantityTicket = quantityTicket - tickets.get(2).getQuantity() + (tickets.get(2).getQuantity() * 2);
                                }
                                double totalPriceTicket = (double) session.getAttribute("totalPriceTicket");
                                BookingDetailEntity bookingDetail = new BookingDetailEntity();
                                MovieEntity movie = movieService.findByMovieId(Long.parseLong(movieId));
                                bookingDetail.setMovie(movie);
                                CinemaEntity cinema = cinemaService.findByCinemaId(Long.parseLong(cinemaId));
                                bookingDetail.setCinema(cinema);
                                bookingDetail.setCinemaRoom(cinemaMovie.getCinemaRoom());

                                bookingDetail.setShowDate(parseStringtoDate.parse(showDate));
                                bookingDetail.setShowTime(stimef.parse(showTime));
                                bookingDetail.setQuantityTicket(quantityTicket);
                                bookingDetail.setTotalPriceTicket(totalPriceTicket);
                                double totalPriceFood = (double) session.getAttribute("totalPriceFood");
                                bookingDetail.setTotalPriceFood(totalPriceFood);
                                bookingDetail.setBooking(booking);
                                bookingDetailService.saveBookingDetail(bookingDetail);

                                //add booking ticket
                                List<TicketEntity> selectedTickets = (List<TicketEntity>) session.getAttribute("selectedTickets");
                                List<BookingTicketEntity> bookingTickets = new ArrayList<>();
                                if (selectedTickets != null) {
                                    for (int i = 0; i < selectedTickets.size(); i++) {
                                        BookingTicketEntity bookingTicket = new BookingTicketEntity(selectedTickets.get(i).getQuantity(),booking, selectedTickets.get(i));
                                        bookingTickets.add(bookingTicket);
                                    }
                                    bookingTicketService.saveOrUpdateAllBookingTicket(bookingTickets);
                                }

                                // add booking food
                                List<FoodEntity> selectedFoods = (List<FoodEntity>) session.getAttribute("selectedFoods");
                                List<BookingFoodEntity> bookingFoods = new ArrayList<>();
                                if (selectedFoods != null) {
                                    for (int i = 0; i < selectedFoods.size(); i++) {
                                        BookingFoodEntity bookingFood = new BookingFoodEntity(selectedFoods.get(i).getQuantity(), booking, selectedFoods.get(i));
                                        bookingFoods.add(bookingFood);
                                    }
                                    bookingFoodService.saveListBookingFoods(bookingFoods);
                                }

                                // add booking seat
                                List<BookingSeatEntity> bookingSeats = new ArrayList<>();
                                if (selectedSeats != null) {
                                    for (SeatEntity seat : selectedSeats) {
                                        BookingSeatEntity bookingSeat = new BookingSeatEntity(seat.getSeatNumber(), booking);
                                        bookingSeats.add(bookingSeat);
                                    }
                                    bookingSeatService.saveListBookingSeats(bookingSeats);
                                }

                                // update balance account banking
                                if (accBanking.getId() > 0) {
                                    double balance_new = accBanking.getBalance() - subtotal;
                                    accBanking.setId(accBanking.getId());
                                    accBanking.setBalance(balance_new);
                                    accountBankingService.saveOrUpdateAccountBanking(accBanking);
                                }

                                // add invoice
                                InvoiceEntity invoice = new InvoiceEntity();
                                invoice.setAmount(subtotal);
                                invoice.setBooking(booking);
                                invoice.setStatus("PAYMENT_DONE");
                                invoice.setAccountBankingEmail(accBanking.getEmailBanking());
                                invoice.setAccountBankingName(accBanking.getCardName());
                                for(RoleAccountEntity roleAccLogin: accountLogin.getRolesAccount()){
                                    if(accountLogin.getRolesAccount().size() > 1 && (roleAccLogin.getRole().getRoleAccount().equals(RoleAccount.ROLE_MANAGER) || roleAccLogin.getRole().getRoleAccount().equals(RoleAccount.ROLE_RECEPTIONIST))){
                                        invoice.setPaymentType(PaymentTypes.DIRECT);
                                        invoice.setStaffName(accountLogin.getCustomer().getCustomerName());
                                        invoice.setStaffPhone(accountLogin.getCustomer().getCustomerPhone());
                                        break;
                                    }else if((accountLogin.getRolesAccount().size() == 1 && roleAccLogin.getRole().getRoleAccount().equals(RoleAccount.ROLE_USER)) || (accountLogin.getRolesAccount().size() == 2 && roleAccLogin.getRole().getRoleAccount().equals(RoleAccount.ROLE_ADMIN))){
                                        invoice.setPaymentType(PaymentTypes.ONLINE);
                                        break;
                                    }
                                }
                                invoiceService.saveInvoice(invoice);

                                // send mail
                                List<String> bookingSeatsString = new ArrayList<>();
                                for (BookingSeatEntity bs : bookingSeats) {
                                    bookingSeatsString.add(bs.getSeatNumber());
                                }
                                String subject = "Mua vé thành công tại DOUBLET CINEMA";
                                String content = "<h1>Chúc mừng! Bạn đã đặt vé thành công!</h1>"
                                        + "<h3>Ngày mua: " + sdfStandard.format(new Date()) + "</h3>"
                                        + "<h3>" + movie.getNameByEnglish() + "</h3>"
                                        + "<h3>" + movie.getNameByVietnam() + "</h3>"
                                        + "<h3>Rạp: " + cinema.getNameCinema() + " -----> " + cinema.getCinemaAddress() + "</h3>"
                                        + "<h3>Phòng chiếu: " + cinemaMovie.getCinemaRoom().getCinemaRoomName() + "</h3>"
                                        + "<h3>Ngày chiếu: " + showDate + "</h3>"
                                        + "<h3>Giờ chiếu: " + showTime + "</h3>"
                                        + "<h3>Ghế: " + bookingSeatsString + "</h3>"
                                        + "<a href='http://localhost:8080/Spring_Final_DoubleTCinema/manage_user?contentNavManageUser=manageTransactionHistory&startDate=" + sdf.format(new Date()) + "&toDate=" + sdf.format(new Date()) + "&sortStatus=&sortBy=bookingDate'>"
                                        + "<h4>Xem thông tin giao dịch của bạn ngay!! Love nè</h4></a>";
                                sendEmail("natsutan94@gmail.com", customer.getCustomerEmail(), subject, content);
                                return "/user/complete_checkout";
                            } else {
                                session.setAttribute("selectedSeats", new ArrayList<>());
                                return "redirect:/booking_seat";
                            }

                        } else {
                            model.addAttribute("accountBanking", accountBanking);
                            model.addAttribute("yearCurrent", dfyear.format(new Date()));
                            model.addAttribute("ab", ab);
                            model.addAttribute("messageInvoice", "Tài khoản của quý khách không đủ!");
                            return "/user/invoice";
                        }
                    }
                }
            }
        }
    }
}
