/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
import com.ivt.spring_final_doubletcinema.repository.AccountRepository;
import com.ivt.spring_final_doubletcinema.repository.CustomerRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;
import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;

/**
 *
 * @author tanhegemony
 */
@Service
public class AccountService {

    @Autowired
    private AccountRepository accountRepository;

    @Autowired
    private CustomerRepository customerRepository;

    @Autowired
    JavaMailSender mailSender;

    @Autowired
    HttpSession session;

    public void sendMail(String from, String to, String subject, String content) throws MessagingException {
        MimeMessage mimeMessage = mailSender.createMimeMessage();
        boolean multipart = true;
        MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, multipart, "utf-8");
        helper.setFrom(from);
        helper.setTo(to);
        helper.setSubject(subject);
        mimeMessage.setContent(content, "text/html; charset=utf-8");

        mailSender.send(mimeMessage);
    }

    public boolean sendCodeByEmail(Model model, String email) throws MessagingException {
        if (email.equals("")) {
            model.addAttribute("messageEmail", "Email không được để trống");
            return false;
        } else if (email.matches("^[a-zA-Z0-9]{1,30}+@[a-zA-Z0-9]{2,10}+\\.[a-zA-Z]{2,10}$") == false) {
            model.addAttribute("messageEmail", "Email sai định dạng");
            return false;
        } else if (sendMailCustomerEmail(email).getId() <= 0) {
            model.addAttribute("messageEmail", "Email chưa được đăng ký tại hệ thống DoubleT Cinema");
            return false;
        } else {
            String randomConfirmCode = RandomStringUtils.randomNumeric(6);
            session.setAttribute("randomConfirmCode", randomConfirmCode);
            String subject = "Mã xác nhận quên mật khẩu!";
            String content = "<h3>Mã xác nhận gồm 6 chữ số: " + "<b style='font-size=20px;'>" + randomConfirmCode + "</b>" + "</h3>";
            sendMail("natsutan94@gmail.com", email, subject, content);
            model.addAttribute("messageConfirmCode", "ConfirmCode không được để trống!");
            return true;
        }
    }

    public boolean checkSendConfirmPassword(Model model, String confirmCode) throws MessagingException {
        if (confirmCode.equals("")) {
            model.addAttribute("messageConfirmCode", "ConfirmCode không được để trống!");
            return false;
        } else if (StringUtils.isNumeric(confirmCode) == false || confirmCode.length() != 6) {
            model.addAttribute("messageConfirmCode", "ConfirmCode phải là số có 6 chữ số!");
            return false;
        } else if (!confirmCode.equals(session.getAttribute("randomConfirmCode"))) {
            model.addAttribute("messageConfirmCode", "ConfirmCode không chính xác!");
            return false;
        } else {
            session.setAttribute("randomConfirmCode", new String());
            return true;
        }
    }

    public boolean checkSetAgainPassword(Model model, String email, String newPassword, String confirmNewPassword) throws MessagingException {
        if (newPassword.equals("")) {
            model.addAttribute("messageNewPassword", "Mật khẩu mới không được để trống!");
        } else if (newPassword.matches("^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$%^&-+=]).{6,}$") == false) {
            model.addAttribute("messageNewPassword", "Mật khẩu mới không đúng định dạng!");
        } else {
            if (!confirmNewPassword.equals(newPassword)) {
                model.addAttribute("messageConfirmNewPassword", "Nhập lại mật khẩu không chính xác!");
            } else {
                AccountEntity account = sendMailCustomerEmail(email);
                BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
                account.setPassword(encoder.encode(newPassword));
                saveAccount(account);
                String subject = "Đặt lại mật khẩu thành công!";
                String content = "<h3>Đăng nhập tài khoản tại " + "<a href='http://localhost:8080/Spring_Final_DoubleTCinema/login'>DoubleT Cinema</a>" + "</h3>";
                sendMail("natsutan94@gmail.com", email, subject, content);
                return true;
            }
            return false;
        }
        return false;
    }

    public void saveAccount(AccountEntity account) {
        accountRepository.save(account);
    }

    public boolean checkExistAccount(Model model, String customerEmail, String customerPhone) {
        AccountEntity checkEmail = accountRepository.findByCustomerCustomerEmail(customerEmail);
        if (checkEmail != null && checkEmail.getId() > 0) {
            model.addAttribute("messageCustomerEmail", "CustomerEmail is existed!");
            return false;
        } else {
            AccountEntity checkPhone = accountRepository.findByCustomerCustomerPhone(customerPhone);
            if (checkPhone != null && checkPhone.getId() > 0) {
                model.addAttribute("messagePhoneNumber", "PhoneNumber is existed!");
                return false;
            } else {
                return true;
            }
        }
    }

    public AccountEntity findByCustomerPhone(String customerPhone) {
        AccountEntity account = accountRepository.findByCustomerCustomerPhone(customerPhone);
        if (account != null && account.getId() > 0) {
            return account;
        }
        return new AccountEntity();
    }

    @Transactional
    public AccountEntity findByCustomerEmail(String customerEmail) {
        AccountEntity account = accountRepository.findByCustomerCustomerEmail(customerEmail);
        if (account != null && account.getId() > 0) {
            Hibernate.initialize(account.getRolesAccount());
            return account;
        }
        return new AccountEntity();
    }
    
    public AccountEntity sendMailCustomerEmail(String customerEmail) {
        AccountEntity account = accountRepository.findByCustomerCustomerEmail(customerEmail);
        if (account != null && account.getId() > 0) {
            return account;
        }
        return new AccountEntity();
    }

    //admin
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    // search accounts
    @Transactional
    public Page<AccountEntity> searchAccountsPagination(String searchValue, int currentPage, int pageSize, Sort sort) {
        Page<AccountEntity> accounts = accountRepository.searchAccounts(searchValue, searchValue, searchValue, searchValue, PageRequest.of(currentPage, pageSize, sort));
        if (!accounts.isEmpty()) {
            for (AccountEntity account : accounts) {
                Hibernate.initialize(account.getRolesAccount());
                try {
                    if (account.getCustomer().getBookings() != null) {
                        Hibernate.initialize(account.getCustomer().getBookings());
                    }
                } catch (NullPointerException e) {
                    e.printStackTrace();
                }
            }
            return accounts;
        }
        return null;

    }

    // show list have page
    @Transactional
    public Page<AccountEntity> getAccountsPagination(int currentPage, int pageSize, Sort sort) {
        Page<AccountEntity> accounts = accountRepository.findAccounts(PageRequest.of(currentPage, pageSize, sort));
        if (!accounts.isEmpty()) {
            for (AccountEntity account : accounts) {
                Hibernate.initialize(account.getRolesAccount());
                try {
                    if (account.getCustomer().getBookings() != null) {
                        Hibernate.initialize(account.getCustomer().getBookings());
                    }
                } catch (NullPointerException e) {
                    e.printStackTrace();
                }
            }
            return accounts;
        }
        return null;
    }

    public void saveOrUpdateAccount(AccountEntity account) {
        if (account.getId() > 0) {
            account.setPassword(account.getPassword());
            account.setIsLock(account.isIsLock());
        } else {
            //tao ra chuoi 60 ky tu
            account.setPassword(bCryptPasswordEncoder.encode(account.getPassword()));
        }
        account.getCustomer().setAccount(account);
        accountRepository.save(account);
    }

    @Transactional
    public AccountEntity findById(long id) {
        Optional<AccountEntity> accountOpt = accountRepository.findById(id);

        if (accountOpt != null && accountOpt.isPresent()) {
            Hibernate.initialize(accountOpt.get().getRolesAccount());
            return accountOpt.get();
        }
        return new AccountEntity();
    }

    public void deleteAccount(long id) {
        accountRepository.deleteById(id);
    }

    public List<AccountEntity> findAccountByCreateDate(String AccountThis) {
        List<AccountEntity> accounts = accountRepository.findAccountByCreateDate(AccountThis);
        if (accounts != null && accounts.size() > 0) {
            return accounts;
        }
        return new ArrayList<>();

    }

}
