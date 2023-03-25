/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
import com.ivt.spring_final_doubletcinema.entities.PromotionEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.CustomerService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.service.PromotionService;
import java.text.ParseException;
import java.util.Date;
import javax.mail.MessagingException;
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
 * @author ngoct
 */
@Controller
public class CheckoutController {

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    private PromotionService promotionService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private MovieService movieService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BookingService bookingService;

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

    @RequestMapping("view_checkout")
    public String viewPageCheckout(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);

        if (session.getAttribute("movieId") == null) {
            return "redirect:/home";
        } else {
            session.setAttribute("action", "checkout");
            CustomerEntity customer = customerService.findCustomerByAccountId(accountLogin.getId());
            session.setAttribute("customer", customer);
            session.setAttribute("usedPromotion", false);
            session.setAttribute("subtotal", session.getAttribute("totalBooking"));
            session.setAttribute("valuePromotion", 0);
        }

        session.setAttribute("promotion", new PromotionEntity());
        session.setAttribute("note", new String());
        return "/user/checkout";
    }

    @RequestMapping(value = "applyPromotion", method = RequestMethod.POST)
    public String applyPromotion(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);

        if (session.getAttribute("movieId") == null) {
            return "redirect:/home";
        } else {
            viewFilmInHeaderInHomePage(model);
            // check customer
            CustomerEntity customer = customerService.findCustomerByAccountId(accountLogin.getId());
            session.setAttribute("customer", customer);
            // apply promotion code
            String promotionCode = request.getParameter("promotionCode");
            double totalBooking = (double) session.getAttribute("totalBooking");
            PromotionEntity promotion = promotionService.findPromotionByCode(promotionCode);
            double subtotal = totalBooking;
            double valuePromotion = 0;
            if (promotion.getId() <= 0) {
                totalBooking = (double) session.getAttribute("totalBooking");
                subtotal = totalBooking;
                model.addAttribute("messagePromotion", "Mã giảm giá không đúng!");
            } else {
                if (promotion.getEffectiveDate().after(new Date())) {
                    totalBooking = (double) session.getAttribute("totalBooking");
                    subtotal = totalBooking;
                    model.addAttribute("messagePromotion", "Mã giảm giá không được áp dụng!");
                } else {
                    if (promotion.getExpiryDate().before(new Date())) {
                        totalBooking = (double) session.getAttribute("totalBooking");
                        subtotal = totalBooking;
                        model.addAttribute("messagePromotion", "Mã giảm giá đã hết hạn!");
                    } else {
                        BookingEntity booking = bookingService.findBookingByCustomerIdAndPromotionCode(customer.getId(), promotionCode);
                        if (booking.getId() > 0) {
                            totalBooking = (double) session.getAttribute("totalBooking");
                            subtotal = totalBooking;
                            session.setAttribute("usedPromotion", true);
                            model.addAttribute("messagePromotion", "Mã giảm giá đã được bạn sử dụng!");
                        } else {
                            if (totalBooking <= promotion.getValuePromotion()) {
                                subtotal = 0;
                                totalBooking = 0;
                            } else {
                                totalBooking = totalBooking - promotion.getValuePromotion();
                                subtotal = totalBooking;
                                valuePromotion = promotion.getValuePromotion();
                            }
                        }
                    }
                }
            }
            session.setAttribute("valuePromotion", valuePromotion);
            session.setAttribute("subtotal", subtotal);
            session.setAttribute("promotion", promotion);

            return "/user/checkout";
        }
    }

    @RequestMapping(value = "checkout", method = RequestMethod.POST)
    public String checkout(
            Model model) throws ParseException, MessagingException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (session.getAttribute("movieId") == null) {
            return "redirect:/home";
        } else {
            String note = request.getParameter("note");
            session.setAttribute("note", note);
        }
        return "redirect:/user/viewInvoice";
    }
}
