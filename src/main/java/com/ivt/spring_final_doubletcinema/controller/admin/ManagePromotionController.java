/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.entities.PromotionEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingService;
import com.ivt.spring_final_doubletcinema.service.PromotionService;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
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

/**
 *
 * @author ngoct
 */
@Controller
@RequestMapping("/admin/")
public class ManagePromotionController {

    @Autowired
    private PromotionService promotionService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private BookingService bookingService;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

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

    public List<PromotionEntity> checkExistPromotion(Page<PromotionEntity> promotions) {
        List<PromotionEntity> promotionList = new ArrayList<>();
        for (PromotionEntity p : promotions) {
            List<BookingEntity> bookings = bookingService.findBookingByPromotionCode(p.getCode());
            if (bookings.size() > 0) {
                p.setUsed(true);
                promotionList.add(p);
            } else {
                p.setUsed(false);
                promotionList.add(p);
            }
        }
        return promotionList;
    }

    @RequestMapping("/promotions")
    public String viewPromotions(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "promotions");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<PromotionEntity> promotions = promotionService.getPromotionsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (promotions != null) {
            List<PromotionEntity> promotionList = checkExistPromotion(promotions);
            int totalPages = promotions.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("promotions", promotionList);

        }
        return "/admin/promotion";
    }

    @RequestMapping(value = "/searchPromotions", method = RequestMethod.GET)
    public String searchPromotion(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_promotions");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<PromotionEntity> promotions = null;
        if (searchValue.equals("")) {
            promotions = promotionService.getPromotionsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        } else {
            promotions = promotionService.findPromotionByCode("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        }
        if (promotions != null) {
            List<PromotionEntity> promotionList = checkExistPromotion(promotions);
            int totalPages = promotions.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("promotions", promotionList);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/promotion";
    }

    @RequestMapping("addPromotion")
    public String addPromotion(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_promotion");
        model.addAttribute("minEffectiveDate", sdf.format(new Date()));
        model.addAttribute("promotion", new PromotionEntity());
        return "/admin/form/form_promotion";
    }

    @RequestMapping("editPromotion/{id}")
    public String updatePromotion(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        PromotionEntity promotion = promotionService.findByPromotionId(id);
        if (promotion.getId() > 0) {
            model.addAttribute("action", "update_promotion");
        } else {
            model.addAttribute("action", "add_promotion");
        }
        if (promotion.getEffectiveDate() != null) {
            model.addAttribute("effectiveDate", sdf.format(promotion.getEffectiveDate()));
            if (promotion.getExpiryDate() != null) {
                model.addAttribute("expiryDate", sdf.format(promotion.getExpiryDate()));
            }
        }
        model.addAttribute("promotion", promotion);
        return "/admin/form/form_promotion";
    }

    @RequestMapping(value = "/resultSavePromotion", method = RequestMethod.POST)
    public String resultPromotion(
            @Valid @ModelAttribute("promotion") PromotionEntity promotion,
            BindingResult result,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (result.hasFieldErrors("valuePromotion")) {
                model.addAttribute("messagePromotionValue", "ValuePromotion must be greater than or equal to 5000đ");
            }
            if (promotion.getId() > 0) {
                model.addAttribute("action", "update_promotion");

            } else {
                model.addAttribute("action", "add_promotion");
            }
            model.addAttribute("minEffectiveDate", sdf.format(new Date()));
            model.addAttribute("promotion", promotion);
            if (promotion.getEffectiveDate() != null) {
                model.addAttribute("effectiveDate", sdf.format(promotion.getEffectiveDate()));
                if (promotion.getExpiryDate() != null) {
                    model.addAttribute("expiryDate", sdf.format(promotion.getExpiryDate()));
                }
            }
            return "/admin/form/form_promotion";
        } else {
            Date effectiveDate = promotion.getEffectiveDate();
            Date expiryDate = promotion.getExpiryDate();
            if (promotion.getExpiryDate() != null && promotion.getExpiryDate().before(promotion.getEffectiveDate())) {
                promotion.setEffectiveDate(expiryDate);
                promotion.setExpiryDate(effectiveDate);
            }
            if (promotion.getId() > 0) {
                promotionService.saveOrUpdatePromotion(promotion);
                return "redirect:/admin/promotions";
            } else {
                PromotionEntity findPromotion = promotionService.findPromotionByCode(promotion.getCode());
                if (findPromotion != null && findPromotion.getId() > 0) {
                    model.addAttribute("messagePromotion", "Promotion is existed! Please Enter New Promotion!");
                    model.addAttribute("minEffectiveDate", sdf.format(new Date()));
                    if (promotion.getEffectiveDate() != null) {
                        model.addAttribute("effectiveDate", sdf.format(promotion.getEffectiveDate()));
                        if (promotion.getExpiryDate() != null) {
                            model.addAttribute("expiryDate", sdf.format(promotion.getExpiryDate()));
                        }
                    }
                    model.addAttribute("promotion", promotion);
                    model.addAttribute("action", "add_promotion");
                    return "/admin/form/form_promotion";
                } else {
                    promotionService.saveOrUpdatePromotion(promotion);
                    return "redirect:/admin/promotions";
                }
            }
        }
    }

    @RequestMapping("deletePromotion/{id}")
    public String deletePromotion(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        promotionService.deletePromotion(id);
        return "redirect:/admin/promotions";
    }
    
    @RequestMapping("viewBookingsOfPromotion/{id}")
    public String viewBookingsOfPromotionUsed(Model model,
            @PathVariable("id") long id){
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "view_bookings_of_promotion");
        PromotionEntity promotion = promotionService.findByPromotionId(id);
        if(promotion.getId() > 0){
            List<BookingEntity> bookings = bookingService.findBookingByPromotionCode(promotion.getCode());
            model.addAttribute("bookings", bookings);
            model.addAttribute("promotion", promotion);
        } 
        return "/admin/view_bookings_promotion";
    }
}
