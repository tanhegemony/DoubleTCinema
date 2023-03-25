/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingFoodEntity;
import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.InvoiceService;
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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/admin")
public class DashboardController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private InvoiceService invoiceService;

    @Autowired
    HttpSession session;

    SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy-MM");
    SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy");
    Calendar cal = Calendar.getInstance();
    Calendar calCalculation = Calendar.getInstance();
    Date date = new Date();

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

    public void show(Model model) {
        // tháng hiện tại
        cal.setTime(date);

        Date paymentDatePresent = cal.getTime();
        // tháng trước
        cal.add(Calendar.MONTH, -1);
        
        Date yesterday = cal.getTime();
        model.addAttribute("yesterday", yesterday);
        // tổng thu nhập trong 1 tháng
        List<InvoiceEntity> payment1s = invoiceService.findByInvoiceByDate(sdf2.format(paymentDatePresent) + "%");
        double subtotalPaymentMonth = 0;
        for (InvoiceEntity sub : payment1s) {
            subtotalPaymentMonth += sub.getAmount();
        }
        model.addAttribute("subtotalPaymentMonth", subtotalPaymentMonth);

        // so sánh tháng trước
        List<InvoiceEntity> payment2s = invoiceService.findByInvoiceByDate(sdf2.format(yesterday) + "%");
        double subtotalPaymentBeforeMonth = 0;
        for (InvoiceEntity pe : payment2s) {
            subtotalPaymentBeforeMonth += pe.getAmount();
        }
        double resultComparePayment = subtotalPaymentMonth - subtotalPaymentBeforeMonth;
        model.addAttribute("resultComparePayment", resultComparePayment);

        // Số người đăng ký mới trong 1 tháng
        List<AccountEntity> account1s = accountService.findAccountByCreateDate(sdf2.format(paymentDatePresent) + "%");
        int newAccountNumber = 0;
        for (AccountEntity ac : account1s) {
            if (ac.getId() > 0) {
                newAccountNumber += 1;
            }
        }
        model.addAttribute("newAccountNumber", newAccountNumber);
        // so sánh tháng trước
        List<AccountEntity> account2s = accountService.findAccountByCreateDate(sdf2.format(yesterday) + "%");
        int newAccountNumberBeforeMonth = 0;
        for (AccountEntity ac : account2s) {
            if (ac.getId() > 0) {
                newAccountNumberBeforeMonth += 1;
            }
        }
        double resultCompareAccount = newAccountNumber - newAccountNumberBeforeMonth;
        model.addAttribute("resultCompareAccount", resultCompareAccount);

        // Tổng thu nhập/số vé bán và tổng thức ăn thức uống bán trong 1 tháng
        List<BookingEntity> booking1s = bookingService.findBookingMonth(sdf2.format(paymentDatePresent) + "%");
        int subtotalBuyTicket = 0;
        double subtotalPaymentBuyTicket = 0.0;
        for (BookingEntity b : booking1s) {
            subtotalBuyTicket += b.getBookingDetail().getQuantityTicket();
            subtotalPaymentBuyTicket += b.getBookingDetail().getTotalPriceTicket();
        }
        model.addAttribute("subtotalPaymentBuyTicket", subtotalPaymentBuyTicket);
        model.addAttribute("subtotalBuyTicket", subtotalBuyTicket);
        double subtotalBuyFood = 0;
        double subtotalPaymentBuyFood = 0.0;
        for (BookingEntity b : booking1s) {
            for (BookingFoodEntity bf : b.getBookingFoods()) {
                subtotalBuyFood += bf.getQuantityFood();

            }
            subtotalPaymentBuyFood += b.getBookingDetail().getTotalPriceFood();
        }
        model.addAttribute("subtotalPaymentBuyFood", subtotalPaymentBuyFood);
        model.addAttribute("subtotalBuyFood", subtotalBuyFood);
        // so sánh tháng trước
        List<BookingEntity> booking2s = bookingService.findBookingMonth(sdf2.format(yesterday) + "%");
        int subtotalBuyTicketBeforeMonth = 0;
        double subtotalBookingBuyTicketBeforeMonth = 0.0;
        for (BookingEntity b : booking2s) {
            // tổng số vé bán được tháng trước
            subtotalBuyTicketBeforeMonth += b.getBookingDetail().getQuantityTicket();
            // tổng thu nhập vé bán tháng trước
            subtotalBookingBuyTicketBeforeMonth += b.getBookingDetail().getTotalPriceTicket();
        }
        double resultCompareQuantityBuyTicket = subtotalBuyTicket - subtotalBuyTicketBeforeMonth;
        model.addAttribute("resultCompareQuantityBuyTicket", resultCompareQuantityBuyTicket);
        double resultCompareBookingBuyTicket = subtotalPaymentBuyTicket - subtotalBookingBuyTicketBeforeMonth;
        model.addAttribute("resultCompareBookingBuyTicket", resultCompareBookingBuyTicket);

        double subtotalBuyFoodBeforeMonth = 0;
        double subtotalBookingBuyFoodBeforeMonth = 0.0;
        for (BookingEntity b : booking2s) {
            for (BookingFoodEntity bf : b.getBookingFoods()) {
                // tổng số thức ăn bán được tháng trước
                subtotalBuyFoodBeforeMonth += bf.getQuantityFood();

            }
            // tổng thu nhập thức uống bán tháng trước
            subtotalBookingBuyFoodBeforeMonth += b.getBookingDetail().getTotalPriceFood();
        }
        double resultCompareQuantityBuyFood = subtotalBuyFood - subtotalBuyFoodBeforeMonth;
        model.addAttribute("resultCompareQuantityBuyFood", resultCompareQuantityBuyFood);
        double resultCompareBookingBuyFood = subtotalPaymentBuyFood - subtotalBookingBuyFoodBeforeMonth;
        model.addAttribute("resultCompareBookingBuyFood", resultCompareBookingBuyFood);
    }

    @RequestMapping(value = {"/", "/home"})
    public String viewHome(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "home_admin");
        
        model.addAttribute("now", date);
        calCalculation.setTime(date);
        model.addAttribute("yearPresent", sdf1.format(calCalculation.getTime()));
        model.addAttribute("datePresent", calCalculation.getTime());
        calCalculation.add(Calendar.YEAR, -1);
        model.addAttribute("yearOneBefore", sdf1.format(calCalculation.getTime()));
        model.addAttribute("dateOneBefore", calCalculation.getTime());
        calCalculation.add(Calendar.YEAR, -1);
        model.addAttribute("yearTwoBefore", sdf1.format(calCalculation.getTime()));
        model.addAttribute("dateTwoBefore", calCalculation.getTime());
        
        show(model);
        List<InvoiceEntity> bookingsChart = new ArrayList<>();
        List<Double> paymentChart = new ArrayList<>();
        double yeartotalAmount = 0;
        for (int i = 0; i <= 11; i++) {
            double subtotalChart = 0.0;
            cal.setTime(new Date());
            cal.set(Calendar.MONTH, i);
            Date bookingSubtotalChart = cal.getTime();
            bookingsChart = invoiceService.findByInvoiceByDate(sdf2.format(bookingSubtotalChart) + "%");
            for (InvoiceEntity p : bookingsChart) {
                subtotalChart += p.getAmount();
            }
            paymentChart.add(subtotalChart);
            for (InvoiceEntity pey : bookingsChart) {
                yeartotalAmount += pey.getAmount();
            }
        }
        model.addAttribute("paymentChart", paymentChart);
        model.addAttribute("yeartotalAmount", yeartotalAmount);
        return "/admin/home";
    }

    @RequestMapping("/changeYearPaymentChart/{yearNumber}")
    public String changeYearPaymentChart(Model model,
            @PathVariable(name = "yearNumber") String yearNumber,
            HttpServletRequest request) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "home_admin");
        
        model.addAttribute("now", date);
        calCalculation.setTime(date);
        model.addAttribute("yearPresent", sdf1.format(calCalculation.getTime()));
        model.addAttribute("datePresent", calCalculation.getTime());
        calCalculation.add(Calendar.YEAR, -1);
        model.addAttribute("yearOneBefore", sdf1.format(calCalculation.getTime()));
        model.addAttribute("dateOneBefore", calCalculation.getTime());
        calCalculation.add(Calendar.YEAR, -1);
        model.addAttribute("yearTwoBefore", sdf1.format(calCalculation.getTime()));
        model.addAttribute("dateTwoBefore", calCalculation.getTime());
        
        if (yearNumber.equals(sdf1.format(new Date()))) {
            show(model);
        } else {
            // năm trước
            cal.set(Calendar.YEAR, Integer.parseInt(yearNumber));
            cal.add(Calendar.YEAR, -1);
            Date beforeYear = cal.getTime();
            model.addAttribute("beforeYear", beforeYear);
            // tổng thu nhập trong yearNumber
            List<InvoiceEntity> payment1s = invoiceService.findByInvoiceByDate(yearNumber + "%");
            double subtotalPaymentMonth = 0;
            for (InvoiceEntity sub : payment1s) {
                subtotalPaymentMonth += sub.getAmount();
            }
            model.addAttribute("subtotalPaymentMonth", subtotalPaymentMonth);

            // so sánh năm trước
            List<InvoiceEntity> payment2s = invoiceService.findByInvoiceByDate(sdf1.format(beforeYear) + "%");
            double subtotalPaymentBeforeMonth = 0;
            for (InvoiceEntity pe : payment2s) {
                subtotalPaymentBeforeMonth += pe.getAmount();
            }
            double resultComparePayment = subtotalPaymentMonth - subtotalPaymentBeforeMonth;
            model.addAttribute("resultComparePayment", resultComparePayment);

            // Số người đăng ký mới trong yearNumber
            List<AccountEntity> account1s = accountService.findAccountByCreateDate(yearNumber + "%");
            int newAccountNumber = 0;
            for (AccountEntity ac : account1s) {
                if (ac.getId() > 0) {
                    newAccountNumber += 1;
                }
            }
            model.addAttribute("newAccountNumber", newAccountNumber);
            // so sánh năm trước
            List<AccountEntity> account2s = accountService.findAccountByCreateDate(sdf1.format(beforeYear) + "%");
            int newAccountNumberBeforeMonth = 0;
            for (AccountEntity ac : account2s) {
                if (ac.getId() > 0) {
                    newAccountNumberBeforeMonth += 1;
                }
            }
            double resultCompareAccount = newAccountNumber - newAccountNumberBeforeMonth;
            model.addAttribute("resultCompareAccount", resultCompareAccount);

            // Tổng thu nhập/số vé bán và tổng thức ăn thức uống bán trong yearNumber
            List<BookingEntity> booking1s = bookingService.findBookingMonth(yearNumber + "%");
            int subtotalBuyTicket = 0;
            double subtotalPaymentBuyTicket = 0.0;
            for (BookingEntity b : booking1s) {
                subtotalBuyTicket += b.getBookingDetail().getQuantityTicket();
                subtotalPaymentBuyTicket += b.getBookingDetail().getTotalPriceTicket();
            }
            model.addAttribute("subtotalPaymentBuyTicket", subtotalPaymentBuyTicket);
            model.addAttribute("subtotalBuyTicket", subtotalBuyTicket);
            double subtotalBuyFood = 0;
            double subtotalPaymentBuyFood = 0.0;
            for (BookingEntity b : booking1s) {
                for (BookingFoodEntity bf : b.getBookingFoods()) {
                    subtotalBuyFood += bf.getQuantityFood();

                }
                subtotalPaymentBuyFood += b.getBookingDetail().getTotalPriceFood();
            }
            model.addAttribute("subtotalPaymentBuyFood", subtotalPaymentBuyFood);
            model.addAttribute("subtotalBuyFood", subtotalBuyFood);
            // so sánh năm trước
            List<BookingEntity> booking2s = bookingService.findBookingMonth(sdf1.format(beforeYear) + "%");
            int subtotalBuyTicketBeforeMonth = 0;
            double subtotalBookingBuyTicketBeforeMonth = 0.0;
            for (BookingEntity b : booking2s) {
                // tổng số vé bán được tháng trước
                subtotalBuyTicketBeforeMonth += b.getBookingDetail().getQuantityTicket();
                // tổng thu nhập vé bán tháng trước
                subtotalBookingBuyTicketBeforeMonth += b.getBookingDetail().getTotalPriceTicket();
            }
            double resultCompareQuantityBuyTicket = subtotalBuyTicket - subtotalBuyTicketBeforeMonth;
            model.addAttribute("resultCompareQuantityBuyTicket", resultCompareQuantityBuyTicket);
            double resultCompareBookingBuyTicket = subtotalPaymentBuyTicket - subtotalBookingBuyTicketBeforeMonth;
            model.addAttribute("resultCompareBookingBuyTicket", resultCompareBookingBuyTicket);

            double subtotalBuyFoodBeforeMonth = 0;
            double subtotalBookingBuyFoodBeforeMonth = 0.0;
            for (BookingEntity b : booking2s) {
                for (BookingFoodEntity bf : b.getBookingFoods()) {
                    // tổng số thức ăn bán được tháng trước
                    subtotalBuyFoodBeforeMonth += bf.getQuantityFood();

                }
                // tổng thu nhập thức uống bán tháng trước
                subtotalBookingBuyFoodBeforeMonth += b.getBookingDetail().getTotalPriceFood();
            }
            double resultCompareQuantityBuyFood = subtotalBuyFood - subtotalBuyFoodBeforeMonth;
            model.addAttribute("resultCompareQuantityBuyFood", resultCompareQuantityBuyFood);
            double resultCompareBookingBuyFood = subtotalPaymentBuyFood - subtotalBookingBuyFoodBeforeMonth;
            model.addAttribute("resultCompareBookingBuyFood", resultCompareBookingBuyFood);
        }
        List<InvoiceEntity> bookingsChart = new ArrayList<>();
        List<Double> paymentChart = new ArrayList<>();
        double yeartotalAmount = 0;
        for (int i = 0; i <= 11; i++) {
            double subtotalChart = 0.0;
            cal.setTime(new Date());
            cal.set(Calendar.MONTH, i);
            cal.set(Calendar.YEAR, Integer.parseInt(yearNumber));
            Date bookingSubtotalChart = cal.getTime();
            bookingsChart = invoiceService.findByInvoiceByDate(sdf2.format(bookingSubtotalChart) + "%");
            for (InvoiceEntity p : bookingsChart) {
                subtotalChart += p.getAmount();
            }
            paymentChart.add(subtotalChart);
            for (InvoiceEntity pey : bookingsChart) {
                yeartotalAmount += pey.getAmount();
            }
        }
        model.addAttribute("nowYear", sdf1.format(new Date()));
        model.addAttribute("yearNumber", yearNumber);
        model.addAttribute("paymentChart", paymentChart);
        model.addAttribute("yeartotalAmount", yeartotalAmount);
        return "/admin/home";
    }
}
