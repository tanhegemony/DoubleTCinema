/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
import com.ivt.spring_final_doubletcinema.entities.RoleAccountEntity;
import com.ivt.spring_final_doubletcinema.entities.RoleEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CustomerService;
import com.ivt.spring_final_doubletcinema.service.RoleService;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

/**
 *
 * @author tanhegemony
 */
@Controller
public class LoginController {

    @Autowired
    HttpServletRequest request;

    @Autowired
    HttpSession session;

    @Autowired
    private AccountService accountService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private RoleService roleService;

    // send mail
    @Autowired
    JavaMailSender mailSender;

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

    @RequestMapping(value = {"/", "/home"}, method = RequestMethod.GET)
    public String viewHomePage(Model model) {
        return "redirect:/home";
    }

    @RequestMapping("/login")
    public String viewLoginPage(Model model,
            @RequestParam(name = "error", required = false) boolean errorLogin) {
        if (errorLogin) {
            model.addAttribute("message", "Tài khoản hoặc mật khẩu không đúng!");
        }
        return "/login";
    }

    @RequestMapping("/logout")
    public String logout(Model model,
            @RequestParam(name = "logoutStatus", required = false) boolean logoutStatus) {
        AccountEntity account = getAccountByUserLogin(model);
        if (logoutStatus == true) {
            accountService.saveAccount(account);
            session.setMaxInactiveInterval(0);
            session.invalidate();
        }
        return "redirect:/home";
    }

    @RequestMapping("/view_register")
    public String viewRegisterPage(Model model) {
        boolean displayCheckAccountBySendMail = false;
        model.addAttribute("displayCheckAccountBySendMail", displayCheckAccountBySendMail);
        return "/register";
    }

    @RequestMapping(value = "/register", method = RequestMethod.POST)
    public String register(Model model) throws MessagingException {
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerPhone = request.getParameter("customerPhone");
        model.addAttribute("customerEmail", customerEmail);
        model.addAttribute("customerPhone", customerPhone);
        model.addAttribute("customerName", customerName);
        // check account 
        AccountEntity findAccount = accountService.findByCustomerEmail(customerEmail);
        if (findAccount.getId() <= 0) {
            AccountEntity account = new AccountEntity();
            CustomerEntity customerCustomerEmail = customerService.findCustomerByCustomerEmail(customerEmail);
            if (customerCustomerEmail.getId() > 0) {
                model.addAttribute("message", "Email này đã được sử dụng!!");
                model.addAttribute("displayCheckAccountBySendMail", false);
                return "/register";
            } else {
                CustomerEntity customerCustomerPhone = customerService.findCustomerByCustomerPhone(customerPhone);
                if (customerCustomerPhone.getId() > 0) {
                    model.addAttribute("message", "Phone này đã được sử dụng!!");
                    model.addAttribute("displayCheckAccountBySendMail", false);
                    return "/register";
                } else {
                    if (customerPhone.length() < 10 || customerPhone.length() > 12) {
                        model.addAttribute("message", "Phone này không đúng định dạng!!");
                        model.addAttribute("displayCheckAccountBySendMail", false);
                        return "/register";
                    } else {
                        String pattern = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&-+=]).{6,}$";
                        if (password.matches(pattern) == false) {
                            model.addAttribute("message", "Password sai định dạng!! Vui lòng kiểm tra lại!!");
                            model.addAttribute("displayCheckAccountBySendMail", false);
                            return "/register";
                        } else {
                            if (password.equals(confirmPassword)) {
                                BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
                                account.setPassword(encoder.encode(password));
                                account.setCreateDate(new Date());
                                account.setIsLock(false);
                                account.setImageAccount("no_image_user.png");
                                
                                List<RoleAccountEntity> roleList = new ArrayList<>();
                                RoleAccountEntity roleA = new RoleAccountEntity();
                                List<RoleEntity> roles = roleService.getRoles();
                                roleA.setRole(roles.get(0));
                                roleA.setAccount(account);
                                roleList.add(roleA);
                                account.setRolesAccount(roleList);
                                session.setAttribute("account", account);

                                CustomerEntity customer = new CustomerEntity();
                                customer.setCustomerName(customerName);
                                customer.setCustomerEmail(customerEmail);
                                customer.setCustomerPhone(customerPhone);
                                customer.setAccount(account);
                                session.setAttribute("customer", customer);
                                String randomNumeric = RandomStringUtils.randomNumeric(6);
                                String subject = "Xác nhận thông tin đăng ký tài khoản tại DoubleTCinema";
                                String content = "<h1>Bạn vui lòng nhập mã số gồm 6 ký tự vào khung xác nhận đăng ký!</h1>"
                                        + "<h3>Mã gồm 6 ký tự số: <b>" + randomNumeric + "</b></h3>"
                                        + "<h3>Cảm ơn bạn! Love 3000 nè!</h3>";
                                sendEmail("natsutan94@gmail.com", customerEmail, subject, content);
                                session.setAttribute("randomNumericConfirmRegister", randomNumeric);
                                session.setMaxInactiveInterval(60);
                                model.addAttribute("displayCheckAccountBySendMail", true);
                            } else {
                                model.addAttribute("message", "Mật khẩu không trùng nhau!");
                                model.addAttribute("displayCheckAccountBySendMail", false);
                                return "/register";
                            }
                        }
                    }
                }
            }

        } else {
            model.addAttribute("message", "Tài khoản đã tồn tại");
            model.addAttribute("displayCheckAccountBySendMail", false);
            return "/register";
        }
        return "/register";
    }

    @RequestMapping(value = "checkAccountBySendEmail", method = RequestMethod.POST)
    public String checkAccountBySendMail(Model model) {
        String codeRandomCheck = request.getParameter("codeRandomCheck");
        if (codeRandomCheck.equals(session.getAttribute("randomNumericConfirmRegister"))) {
            AccountEntity account = (AccountEntity) session.getAttribute("account");
            accountService.saveAccount(account);
            CustomerEntity customer = (CustomerEntity) session.getAttribute("customer");
            if(customer.getBirthDate() == null){
                customer.setBirthDate(new Date(000,00,00));
            }
            customerService.saveOrUpdateCustomer(customer);
            session.setMaxInactiveInterval(0);
            session.invalidate();
            return "redirect:/login";
        } else {
            model.addAttribute("message", "Mã xác nhận đăng ký tài khoản không chính xác!");
            model.addAttribute("displayCheckAccountBySendMail", true);
            return "/register";
        }

    }
}
