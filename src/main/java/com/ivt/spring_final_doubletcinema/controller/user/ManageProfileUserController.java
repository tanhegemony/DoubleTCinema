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
import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
import com.ivt.spring_final_doubletcinema.enums.AccountBankingStatus;
import com.ivt.spring_final_doubletcinema.enums.BookingStatus;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.enums.Gender;
import com.ivt.spring_final_doubletcinema.service.AccountBankingService;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingDetailService;
import com.ivt.spring_final_doubletcinema.service.BookingFoodService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.CustomerService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.sql.Timestamp;
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
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
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
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author ngoct
 */
@Controller
public class ManageProfileUserController {

    @Autowired
    HttpSession session;

    @Autowired
    HttpServletRequest request;

    @Autowired
    private AccountService accountService;

    @Autowired
    private MovieService movieService;

    @Autowired
    private CustomerService customerService;

    @Autowired
    private BookingService bookingService;

    @Autowired
    private AccountBankingService accountBankingService;
    
    @Autowired
    private BookingDetailService bookingDetailService;
    
    @Autowired
    private BookingFoodService bookingFoodService;

    // send mail
    @Autowired
    JavaMailSender mailSender;

    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
    SimpleDateFormat parseStringtoDate = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat sdfStandard2 = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

    Calendar cal = Calendar.getInstance();
    SimpleDateFormat dfyear = new SimpleDateFormat("yy");
    SimpleDateFormat dfmonth = new SimpleDateFormat("MM");

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

    @RequestMapping("manage_user")
    public String manageUser(
            @RequestParam(value = "contentNavManageUser", required = false) String contentNavManageUser,
            @RequestParam(value = "startDate", required = false) String startDate,
            @RequestParam(value = "toDate", required = false) String toDate,
            @RequestParam(value = "sortStatus", required = false) String sortStatus,
            @RequestParam(value = "sortBy", required = false) String sortBy,
            @RequestParam(value = "deposit", required = false) boolean deposit,
            Model model) throws ParseException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        model.addAttribute("action", "manageUser");
        boolean viewDetail = false;
        if (contentNavManageUser == null) {
            contentNavManageUser = "manageCustomer";
        }
        if (contentNavManageUser.equals("manageCustomer")) {
            CustomerEntity customer = customerService.findCustomerByAccountId(accountLogin.getId());
            if (customer != null && customer.getId() > 0) {
                model.addAttribute("customer", customer);
                if (customer.getBirthDate() != null) {
                    model.addAttribute("birthDate", sdf.format(customer.getBirthDate()));
                }
            }
            Date maxDate = new Date();
            model.addAttribute("displayUpdateAccountBySendMail", false);
            model.addAttribute("maxDate", sdf.format(maxDate));
            model.addAttribute("genders", Gender.values());

        } else if (contentNavManageUser.equals("manageTransactionHistory")) {
            if (viewDetail == false) {
                List<BookingEntity> bookings = new ArrayList<>();
                if (sortBy == null) {
                    sortBy = "bookingDate";
                }
                if ((startDate == null || startDate.equals("") || startDate != null || !startDate.equals(""))
                        && (toDate == null || toDate.equals("")) && sortBy != null
                        && (sortStatus == null || sortStatus.equals(""))) {
                    bookings = bookingService.getListBookingByCustomerId(accountLogin.getCustomer().getId(), Sort.by(sortBy).descending());
                } else if ((startDate != null && !startDate.equals(""))
                        && (toDate != null && !toDate.equals("")) && sortBy != null
                        && (sortStatus == null || sortStatus.equals(""))) {
                    Date toDateConvert = handleToDate(toDate);
                    bookings = bookingService.getListBookingByCustomerIdAndBookingDate(accountLogin.getCustomer().getId(), parseStringtoDate.parse(startDate), toDateConvert, Sort.by(sortBy).descending());
                } else if ((startDate == null || startDate.equals("") || startDate != null || !startDate.equals(""))
                        && (toDate == null || toDate.equals("")) && sortBy != null
                        && (sortStatus != null || !sortStatus.equals(""))) {
                    bookings = bookingService.getListBookingByCustomerIdAndStatus(
                            accountLogin.getCustomer().getId(), BookingStatus.valueOf(sortStatus), Sort.by(sortBy).descending());
                } else if ((startDate != null && !startDate.equals(""))
                        && (toDate != null && !toDate.equals("")) && sortBy != null
                        && (sortStatus != null || !sortStatus.equals(""))) {
                    Date toDateConvert = handleToDate(toDate);
                    bookings = bookingService.getListBookingByCustomerIdAndBookingDateAndStatus(
                            accountLogin.getCustomer().getId(), parseStringtoDate.parse(startDate),
                            toDateConvert, BookingStatus.valueOf(sortStatus),
                            Sort.by(sortBy).descending());
                }
                model.addAttribute("currentTime", Timestamp.valueOf(sdfStandard2.format(new Date())));
                model.addAttribute("bookings", bookings);
                model.addAttribute("bookingStatus", BookingStatus.values());
                model.addAttribute("startDate", startDate);
                model.addAttribute("toDate", toDate);
                model.addAttribute("sortStatus", sortStatus);
                model.addAttribute("sortBy", sortBy);
            }
        } else if (contentNavManageUser.equals("manageAccountBanking")) {
            AccountBankingEntity accountBanking = accountBankingService.findByCustomerId(accountLogin.getCustomer().getId());
            if (accountBanking.getId() > 0) {
                StringBuilder sb = new StringBuilder(accountBanking.getCardNumber());
                sb = sb.insert(4, " ");
                sb = sb.insert(9, " ");
                model.addAttribute("cardNumber", sb.toString());
            }
            Date date = new Date();
            date = cal.getTime();
            model.addAttribute("yearCurrent", dfyear.format(date));
            model.addAttribute("deposit", deposit);
            model.addAttribute("accountBanking", accountBanking);
        }
        model.addAttribute("viewDetail", viewDetail);
        model.addAttribute("account", accountLogin);

        model.addAttribute("contentNavManageUser", contentNavManageUser);
        return "/user/manage_user";
    }

    public Date handleToDate(String toDate) throws ParseException {
        Date toDateConvert = parseStringtoDate.parse(toDate);
        Calendar cal = Calendar.getInstance();
        // convert date to calendar
        cal.setTime(toDateConvert);
        // handle 
        cal.add(Calendar.HOUR, 23);
        cal.add(Calendar.MINUTE, 59);
        cal.add(Calendar.SECOND, 59);
        // convert calendar to date
        toDateConvert = cal.getTime();
        return toDateConvert;
    }

    @RequestMapping(value = "result_save_customer", method = RequestMethod.POST)
    public String updateCustomer(
            @Valid @ModelAttribute("customer") CustomerEntity customer,
            BindingResult result,
            Model model) throws IOException, ParseException, MessagingException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        if (result.hasErrors()) {
            model.addAttribute("contentNavManageUser", "manageCustomer");
            model.addAttribute("displayUpdateAccountBySendMail", false);
            Date maxDate = new Date();
            model.addAttribute("birthDate", sdf.format(customer.getBirthDate()));
            model.addAttribute("maxDate", sdf.format(maxDate));
            model.addAttribute("genders", Gender.values());
            model.addAttribute("account", accountLogin);
            return "/user/manage_user";
        } else {
            MultipartFile file = customer.getAccount().getImageAcc();
            URL location = HomeUserController.class.getProtectionDomain().getCodeSource().getLocation();
            String saveDirectory = location.getFile().substring(1, location.getPath().lastIndexOf("WEB-INF")) + "/resources/images/user";
            Path path = Paths.get(saveDirectory);
            if (!Files.exists(path)) {
                Files.createDirectory(path);
            }

            String filename = file.getOriginalFilename();
            if (filename == "" && accountLogin.getImageAccount() != null) {
                filename = accountLogin.getImageAccount();
            } else if (filename == "" && accountLogin.getImageAccount() == "no_image_user.png") {
                filename = "no_image_user.png";
            }
            File filePath = new File(path + "\\" + filename);
            if (filename != "" && !filePath.exists()) {
                file.transferTo(filePath);
            }
            accountLogin.setImageAccount(filename);
            session.setAttribute("account", accountLogin);
            session.setAttribute("customer", customer);
            CustomerEntity findCustomerEmail = customerService.findCustomerByCustomerEmailAndIdNot(customer.getCustomerEmail(), customer.getId());
            if (findCustomerEmail.getId() > 0) {
                model.addAttribute("messageEmail", "Email này đã được sử dụng");
                model.addAttribute("birthDate", sdf.format(customer.getBirthDate()));
                model.addAttribute("displayUpdateAccountBySendMail", false);
                model.addAttribute("genders", Gender.values());
                model.addAttribute("contentNavManageUser", "manageCustomer");
                return "/user/manage_user";
            } else {
                CustomerEntity findCustomerPhone = customerService.findCustomerByCustomerPhoneAndIdNot(customer.getCustomerPhone(), customer.getId());
                if (findCustomerPhone.getId() > 0) {
                    model.addAttribute("messagePhone", "Phone này đã được sử dụng");
                    model.addAttribute("birthDate", sdf.format(customer.getBirthDate()));
                    model.addAttribute("displayUpdateAccountBySendMail", false);
                    model.addAttribute("genders", Gender.values());
                    model.addAttribute("contentNavManageUser", "manageCustomer");
                    return "/user/manage_user";
                } else {
                    String randomNumeric = RandomStringUtils.randomNumeric(6);
                    String subject = "Xác nhận thông tin cập nhật khách hàng tại DoubleTCinema";
                    String content = "<h1>Bạn vui lòng nhập mã số gồm 6 ký tự vào khung xác nhận cập nhật!</h1>"
                            + "<h3>Mã gồm 6 ký tự số: <b>" + randomNumeric + "</b></h3>"
                            + "<h3>Cảm ơn bạn! Love 3000 nè!</h3>";
                    sendEmail("natsutan94@gmail.com", customer.getCustomerEmail(), subject, content);
                    session.setAttribute("randomNumericConfirmUpdate", randomNumeric);
                    model.addAttribute("displayUpdateAccountBySendMail", true);
                    model.addAttribute("contentNavManageUser", "manageCustomer");
                    return "/user/manage_user";
                }

            }

        }
    }

    @RequestMapping(value = "updateAccountBySendEmail", method = RequestMethod.POST)
    public String updateAccountBySendMail(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        
        String codeRandomCheck = request.getParameter("codeRandomCheck");
        if (codeRandomCheck.equals(session.getAttribute("randomNumericConfirmUpdate"))) {
            AccountEntity account = (AccountEntity) session.getAttribute("account");
            accountService.saveAccount(account);
            CustomerEntity customer = (CustomerEntity) session.getAttribute("customer");
            customerService.saveOrUpdateCustomer(customer);
            session.setAttribute("randomNumericConfirmUpdate", 0);
            session.setMaxInactiveInterval(0);
            session.invalidate();
            return "redirect:/home";
        } else {
            model.addAttribute("message", "Mã xác nhận cập nhật tài khoản không chính xác!");
            model.addAttribute("displayUpdateAccountBySendMail", true);
            model.addAttribute("contentNavManageUser", "manageCustomer");
            return "/user/manage_user";
        }
    }

    @RequestMapping("viewBookingDetail/{bookingId}")
    public String viewBookingDetail(
            @PathVariable("bookingId") long bookingId,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        BookingEntity booking = bookingService.findBookingById(bookingId);
        model.addAttribute("booking", booking);

        List<BookingDetailEntity> bookingDetails = bookingDetailService.findByBookingId(bookingId);
        model.addAttribute("bookingDetails", bookingDetails);
        model.addAttribute("contentNavManageUser", "manageTransactionHistory");
        model.addAttribute("viewDetail", true);
        return "/user/manage_user";
    }

    @RequestMapping(value = "addAccountBanking", method = RequestMethod.POST)
    public String addAccountBanking(
            @Valid @ModelAttribute("accountBanking") AccountBankingEntity accountBanking,
            BindingResult result,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);
        Date date = new Date();
        date = cal.getTime();
        if (result.hasErrors()) {
            model.addAttribute("contentNavManageUser", "manageAccountBanking");
            model.addAttribute("yearCurrent", dfyear.format(date));
            model.addAttribute("accountBanking", accountBanking);
            return "/user/manage_user";
        } else {
            AccountBankingEntity ab = accountBankingService.findByEmailBanking(accountBanking.getEmailBanking());
            if (ab.getId() > 0) {
                model.addAttribute("messageEmail", "Email đã được sử dụng!");
                model.addAttribute("yearCurrent", dfyear.format(date));
                model.addAttribute("contentNavManageUser", "manageAccountBanking");
                return "/user/manage_user";
            } else {
                if (accountBanking.getYearExpiryDate() < Integer.parseInt(dfyear.format(date))) {
                    model.addAttribute("messageExpiryDate", "Ngày hết hạn phải lớn hơn hoặc bằng ngày hiện tại!");
                    model.addAttribute("yearCurrent", dfyear.format(date));
                    model.addAttribute("contentNavManageUser", "manageAccountBanking");
                    return "/user/manage_user";
                } else if (accountBanking.getYearExpiryDate() == Integer.parseInt(dfyear.format(date))
                        && accountBanking.getMonthExpiryDate() < Integer.parseInt(dfmonth.format(date))) {
                    model.addAttribute("contentNavManageUser", "manageAccountBanking");
                    model.addAttribute("yearCurrent", dfyear.format(date));
                    model.addAttribute("messageExpiryDate", "Ngày hết hạn phải lớn hơn hoặc bằng ngày hiện tại!");
                    return "/user/manage_user";
                } else if (accountBanking.getYearExpiryDate() > Integer.parseInt(dfyear.format(date))) {
                    accountBanking.setStatus(AccountBankingStatus.ACTIVE);
                    accountBanking.setCustomer(accountLogin.getCustomer());
                    accountBanking.setBalance(0.0);
                    accountBankingService.saveOrUpdateAccountBanking(accountBanking);
                }

            }

        }
        return "redirect:/manage_user?contentNavManageUser=manageAccountBanking";
    }

    @RequestMapping("deleteAccountBanking")
    public String deleteAccountBanking(
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        AccountBankingEntity accountBanking = accountBankingService.findByCustomerId(accountLogin.getCustomer().getId());
        accountBankingService.deleteAccountBanking(accountBanking.getId());
        return "redirect:/manage_user?contentNavManageUser=manageAccountBanking";
    }
}
