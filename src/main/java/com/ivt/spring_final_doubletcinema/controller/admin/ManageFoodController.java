/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.BookingFoodEntity;
import com.ivt.spring_final_doubletcinema.entities.FoodEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.BookingFoodService;
import com.ivt.spring_final_doubletcinema.service.FoodService;
import java.io.IOException;
import java.util.ArrayList;
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
public class ManageFoodController {

    @Autowired
    private FoodService foodService;

    @Autowired
    private AccountService accountService;
    
    @Autowired
    private BookingFoodService bookingFoodService;

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
    
    public List<FoodEntity> checkExistBookingFoods(Page<FoodEntity> foods){
        List<FoodEntity> foodList = new ArrayList<>();
        for (FoodEntity f : foods) {
            List<BookingFoodEntity> bookingFoods = bookingFoodService.findFoodByBookingFood(f.getId());
            if (bookingFoods.size() > 0) {
                f.setCheckExistBookingFoods(true);
                foodList.add(f);
            } else {
                f.setCheckExistBookingFoods(false);
                foodList.add(f);
            }
        }
        return foodList;
    }

    @RequestMapping("/foods")
    public String viewFood(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "foods");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<FoodEntity> foods = foodService.getFoodsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (foods != null) {
            List<FoodEntity> foodList = checkExistBookingFoods(foods);
            int totalPages = foods.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("foods", foodList);
        }
        return "/admin/food";
    }

    @RequestMapping(value = "searchFoods", method = RequestMethod.GET)
    public String searchFood(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_foods");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<FoodEntity> foods = null;
        if(searchValue.equals("")){
            foods = foodService.getFoodsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        }else{
            foods = foodService.findByFoodName("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        }
        if (foods != null) {
            List<FoodEntity> foodList = checkExistBookingFoods(foods);
            int totalPages = foods.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("foods", foodList);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/food";

    }

    @RequestMapping("deleteFood/{id}")
    public String deleteFood(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        foodService.deleteFood(id);
        return "redirect:/admin/foods";
    }

    @RequestMapping("addFood")
    public String addFood(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_food");
        return "/admin/form/form_food";
    }

    @RequestMapping("editFood/{id}")
    public String viewFood(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        FoodEntity food = foodService.findById(id);
        if (food.getId() > 0) {
            model.addAttribute("action", "update_food");
        } else {
            model.addAttribute("action", "add_food");
        }
        model.addAttribute("food", food);
        return "/admin/form/form_food";
    }

    @RequestMapping(value = "/resultSaveFood", method = RequestMethod.POST)
    public String resultAddFood(
            @Valid @ModelAttribute("food") FoodEntity food,
            BindingResult result,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (result.hasFieldErrors("priceFood")) {
                model.addAttribute("messagePriceFood", "PriceFood must be a positive number large than 0!");
            }
            if (food.getId() > 0) {
                model.addAttribute("action", "update_food");
            } else {
                model.addAttribute("action", "add_food");
            }
            model.addAttribute("food", food);
            return "/admin/form/form_food";
        } else {
            if (food.getId() > 0) {
                foodService.saveOrUpdateFood(food);
                return "redirect:/admin/foods";
            } else {
                FoodEntity findFood = foodService.findFoodByNameFood(food.getNameFood());
                if (findFood != null && findFood.getId() > 0) {
                    model.addAttribute("messageFood", "Food is existed!");
                    model.addAttribute("action", "add_food");
                    model.addAttribute("food", food);
                    return "/admin/form/form_food";
                } else {
                    foodService.saveOrUpdateFood(food);
                    return "redirect:/admin/foods";
                }
            }
        }

    }

}
