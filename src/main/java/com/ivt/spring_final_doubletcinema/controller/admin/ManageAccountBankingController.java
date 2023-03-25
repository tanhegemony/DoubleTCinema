/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountBankingEntity;
import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.TransactionCinemaEntity;
import com.ivt.spring_final_doubletcinema.enums.AccountBankingStatus;
import com.ivt.spring_final_doubletcinema.enums.TransactionType;
import com.ivt.spring_final_doubletcinema.service.AccountBankingService;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CinemaService;
import com.ivt.spring_final_doubletcinema.service.TransactionCinemaService;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Optional;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
 * @author TanHegemony
 */
@Controller
@RequestMapping("/admin")
public class ManageAccountBankingController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private AccountBankingService accountBankingService;

    @Autowired
    private TransactionCinemaService transactionCinemaService;

    @Autowired
    private CinemaService cinemaService;

    @Autowired
    HttpSession session;

    // send mail
    @Autowired
    JavaMailSender mailSender;

    SimpleDateFormat sdfStandard = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

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

    @RequestMapping("/accountsBanking")
    public String viewAccountBanking(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "accounts_banking");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<AccountBankingEntity> accountsBanking = accountBankingService.getAccountBankingPagination(currentPage - 1, pageSize, Sort.by("status").ascending());
        if (accountsBanking != null) {
            int totalPages = accountsBanking.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("accountsBanking", accountsBanking);
        }
        session.setAttribute("reload", "");
        return "/admin/account_banking";
    }

    @RequestMapping(value = "/searchAccountsBanking", method = RequestMethod.GET)
    public String searchAccountBanking(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_accounts_banking");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<AccountBankingEntity> accountsBanking = null;
        if (searchValue.equals("")) {
            accountsBanking = accountBankingService.getAccountBankingPagination(currentPage - 1, pageSize, Sort.by("status").ascending());
        } else {
            accountsBanking = accountBankingService.findByAccountBankingByName("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("status").ascending());
        }
        if (accountsBanking != null) {
            int totalPages = accountsBanking.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("accountsBanking", accountsBanking);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        session.setAttribute("reload", "");
        return "/admin/account_banking";
    }

    @RequestMapping("deposit/{id}")
    public String deposit(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        AccountBankingEntity accountBanking = accountBankingService.findById(id);
        model.addAttribute("action", "deposit");
        session.setAttribute("accountBanking", accountBanking);
        model.addAttribute("depositBalance", "");
        session.setAttribute("reload", "");
        return "/admin/form/form_deposit_account_banking";
    }

    @RequestMapping(value = "/resultDeposit", method = RequestMethod.POST)
    public String resultDeposit(HttpServletRequest request, Model model) throws MessagingException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        String accountBankingIdString = request.getParameter("abId");
        String depositBalanceString = request.getParameter("depositBalance");
        model.addAttribute("depositBalance", depositBalanceString);
        if(depositBalanceString.contains(".")){
            depositBalanceString = depositBalanceString.replace(".", ",");
        }
        
        if (!StringUtils.isNumeric(depositBalanceString.replace(",", "")) || depositBalanceString.replace(",", "").equals("0")) {
            model.addAttribute("messageDeposit", "DepositBalance must be a number greater than 0!");
            model.addAttribute("action", "deposit");
            session.setAttribute("reload", "");
            return "/admin/form/form_deposit_account_banking";
        } else {
            double deposit = Double.parseDouble(depositBalanceString.replace(",", ""));
            String reload = "";
            if (session.getAttribute("reload") == null || session.getAttribute("reload").equals("")) {
                reload = (String) session.getAttribute("reload");
            } else {
                reload = String.valueOf(session.getAttribute("reload"));
            }
            if (reload == null || reload.equals("")) {
                reload = "0";
                long reloadL = Long.parseLong(reload);
                long accountBankingId = Long.parseLong(accountBankingIdString);
                AccountBankingEntity accountBanking = accountBankingService.findById(accountBankingId);

                TransactionCinemaEntity transactionCinema = new TransactionCinemaEntity();
                transactionCinema.setAccount(accountLogin);
                transactionCinema.setDepositBalance(deposit);
                transactionCinema.setStaffName(accountLogin.getCustomer().getCustomerName());
                transactionCinema.setTransactionDate(new Date());
                transactionCinema.setTransactionType(TransactionType.DEPOSIT);
                transactionCinema.setCustomer(accountBanking.getCustomer());
                transactionCinemaService.saveTransactionCinema(transactionCinema);

                accountBanking.setBalance(accountBanking.getBalance() + deposit);
                accountBankingService.saveOrUpdateAccountBanking(accountBanking);

                String subject = "Deposit successfully at DOUBLE T CINEMA";
                String content = "<h1>Congratulation! You have just successfully deposited!</h1>"
                        + "<h3>Deposit Balance: " + deposit + "</h3>"
                        + "<h3>Remaining balance in the account: " + accountBanking.getBalance() + "</h3>"
                        + "<h3>Transaction date: " + sdfStandard.format(new Date()) + "</h3>"
                        + "<h3>Transactional staff: " + accountLogin.getCustomer().getCustomerName() + "</h3>"
                        + "<a href='http://localhost:8083/Spring_Final_DoubleTCinema/home'>"
                        + "<h4>Buy tickets now!! Love it</h4></a>";
                sendEmail("natsutan94@gmail.com", accountBanking.getCustomer().getCustomerEmail(), subject, content);
                reloadL++;
                session.setAttribute("reload", reloadL);
                model.addAttribute("transactionCinema", transactionCinema);
                model.addAttribute("action", "completeTransaction");
                model.addAttribute("transactionDate", new Date());
                return "/admin/form/form_deposit_account_banking";
            } else {
                model.addAttribute("depositBalance", 0);
                return "redirect:/admin/accountsBanking";
            }
        }
    }

    @RequestMapping("/updateStatus/{id}")
    public String updateStatusAB(
            @PathVariable("id") long id,
            Model model) {
        AccountBankingEntity accountBanking = accountBankingService.findById(id);
        if (accountBanking.getId() > 0) {
            if (accountBanking.getStatus().equals(AccountBankingStatus.ACTIVE)) {
                accountBanking.setStatus(AccountBankingStatus.UNACTIVE);
            } else if (accountBanking.getStatus().equals(AccountBankingStatus.UNACTIVE)) {
                accountBanking.setStatus(AccountBankingStatus.ACTIVE);
            }
            accountBankingService.saveOrUpdateAccountBanking(accountBanking);
        }
        return "redirect:/admin/accountsBanking";
    }
}
