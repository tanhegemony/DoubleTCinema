/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.service.AccountService;
import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author TanHegemony
 */
@Controller
public class ForgotPasswordController {
    
    @Autowired
    HttpServletRequest request;
    
    @Autowired
    HttpSession session;
    
    @Autowired
    private AccountService accountService;
    
    @RequestMapping("forgotPassword")
    public String viewFormForgotPassword(Model model){
        model.addAttribute("enterEmail", true);
        return "/forgot_password";
    }
    
    @RequestMapping(value = "sendCodeByEmail", method = RequestMethod.POST)
    public String sendCodeByEmail(Model model) throws MessagingException{
        String email = request.getParameter("email");
        boolean checkEmail = accountService.sendCodeByEmail(model, email);
        if(checkEmail == true){
             model.addAttribute("enterEmail", false);
            model.addAttribute("sendConfirmCode", true);
        }else{
            model.addAttribute("enterEmail", true);
        }
        session.setAttribute("email", email);
        return "/forgot_password";
    }
    
    @RequestMapping(value = "sendConfirmCode", method = RequestMethod.POST)
    public String sendConfirmCode(Model model) throws MessagingException{
        String confirmCode = request.getParameter("confirmCode");
        boolean checkConfirmCode = accountService.checkSendConfirmPassword(model, confirmCode);
        if(checkConfirmCode == true){
             model.addAttribute("enterEmail", false);
            model.addAttribute("enterNewPassword", true);
        }else{
            model.addAttribute("sendConfirmCode", true);
        }
        model.addAttribute("confirmCode", confirmCode);
        return "/forgot_password";
    }
    
    @RequestMapping(value = "setAgainPassword", method = RequestMethod.POST)
    public String setAgainPassword(Model model) throws MessagingException{
        String newPassword = request.getParameter("newPassword");
        String confirmNewPassword = request.getParameter("confirmNewPassword");
        boolean checkSetAgainPass = accountService.checkSetAgainPassword(model, (String) session.getAttribute("email"), 
                newPassword, confirmNewPassword);
        if(checkSetAgainPass == true){
            session.setAttribute("email", new String());
            session.setAttribute("randomConfirmCode", new String());
            return "redirect:/login";
        }
        model.addAttribute("newPassword", newPassword);
        model.addAttribute("confirmNewPassword", confirmNewPassword);
        model.addAttribute("enterNewPassword", true);
        return "/forgot_password";
    }
}
