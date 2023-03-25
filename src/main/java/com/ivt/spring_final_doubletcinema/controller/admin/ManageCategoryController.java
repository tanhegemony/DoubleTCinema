/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CategoryEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieCategoryEntity;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CategoryService;
import com.ivt.spring_final_doubletcinema.service.MovieCategoriesService;
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
public class ManageCategoryController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private MovieCategoriesService movieCategoriesService;

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

    @RequestMapping("/categories")
    public String viewCategory(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "categories");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CategoryEntity> categories = categoryService.getCategoryPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (categories != null) {
            for (CategoryEntity c : categories) {
                List<MovieCategoryEntity> movieCategories = movieCategoriesService.findMCByCategoryId(c.getId());
                if (movieCategories.size() > 0) {
                    c.setCheckMovieCategories(true);
                } else {
                    c.setCheckMovieCategories(false);
                }
                categoryService.saveOrUpdateCategory(c);
            }
            int totalPages = categories.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("categories", categories);

        }
        return "/admin/category";
    }

    @RequestMapping(value = "/searchCategories", method = RequestMethod.GET)
    public String searchCategory(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_categories");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<CategoryEntity> categories = categoryService.findByCategoryByName("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        if (categories != null) {
            for (CategoryEntity c : categories) {
                List<MovieCategoryEntity> movieCategories = movieCategoriesService.findMCByCategoryId(c.getId());
                if (movieCategories.size() > 0) {
                    c.setCheckMovieCategories(true);
                } else {
                    c.setCheckMovieCategories(false);
                }
                categoryService.saveOrUpdateCategory(c);
            }
            int totalPages = categories.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageNumbers", totalPages);
            model.addAttribute("categories", categories);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/category";
    }

    @RequestMapping("addCategory")
    public String addFormCategory(
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_category");
        return "/admin/form/form_category";

    }

    @RequestMapping("editCategory/{id}")
    public String viewFormCategory(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        CategoryEntity category = categoryService.findCategoryById(id);
        model.addAttribute("action", "update_category");
        model.addAttribute("category", category);
        return "/admin/form/form_category";

    }

    @RequestMapping(value = "resultSaveCategory", method = RequestMethod.POST)
    public String saveCategory(
            @Valid @ModelAttribute("category") CategoryEntity category,
            BindingResult result,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (category.getId() > 0) {
                model.addAttribute("action", "update_category");
            } else {
                model.addAttribute("action", "add_category");
            }
            return "/admin/form/form_category";
        } else {
            CategoryEntity findCategory = categoryService.findByCategoryName(category.getCategoryName());
            if (category.getId() > 0) {
                model.addAttribute("action", "update_category");
                CategoryEntity findCategoryId = categoryService.findCategoryById(category.getId());
                if (!findCategoryId.getCategoryName().equals(findCategory.getCategoryName()) && findCategory.getId() > 0) {
                    model.addAttribute("messageCategory", "CategoryName is existed! Please enter again new CategoryName!!");
                    return "/admin/form/form_category";
                } else {
                    categoryService.saveOrUpdateCategory(category);
                    model.addAttribute("category", category);
                    return "redirect:/admin/categories";
                }
            } else {
                model.addAttribute("action", "add_category");
                if (findCategory.getId() > 0) {
                    model.addAttribute("messageCategory", "CategoryName is existed! Please enter again new CategoryName!!");
                    return "/admin/form/form_category";
                } else {
                    categoryService.saveOrUpdateCategory(category);
                    model.addAttribute("category", category);
                    return "redirect:/admin/categories";
                }
            }
        }
    }

    @RequestMapping("deleteCategory/{id}")
    public String deleteCategory(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        categoryService.deleteCategory(id);
        return "redirect:/admin/categories";
    }

}
