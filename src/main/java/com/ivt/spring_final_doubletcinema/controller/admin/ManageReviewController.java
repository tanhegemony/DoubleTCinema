/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.ReviewEntity;
import com.ivt.spring_final_doubletcinema.entities.ReviewImageEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.service.ReviewImageService;
import com.ivt.spring_final_doubletcinema.service.ReviewService;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpSession;
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
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author ngoct
 */
@Controller
@RequestMapping("/admin/")
public class ManageReviewController {

    @Autowired
    private AccountService accountService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private MovieService movieService;

    @Autowired
    private ReviewImageService reviewImageService;

    @Autowired
    HttpSession session;

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

    @RequestMapping("/reviews")
    public String viewReview(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "reviews");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<ReviewEntity> reviews = reviewService.getReviewsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        if (reviews != null) {
            int totalPages = reviews.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("reviews", reviews);
        }
        return "/admin/review";
    }

    @RequestMapping(value = "/searchReviews", method = RequestMethod.GET)
    public String searchReview(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "search_reviews");
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<ReviewEntity> reviews = null;
        if(searchValue.equals("")){
            reviews = reviewService.getReviewsPagination(currentPage - 1, pageSize, Sort.by("id").descending());
        }else{
            reviews = reviewService.findReviewsByNameAndMovie("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("id").descending());
        }
        if (reviews != null) {
            int totalPages = reviews.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("reviews", reviews);
        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/review";
    }

    @RequestMapping("deleteReview/{id}")
    public String deleteReview(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        reviewService.deleteReview(id);
        return "redirect:/admin/reviews";
    }

    @RequestMapping("addReview")
    public String addReview(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending()));
        model.addAttribute("action", "add_review");
        return "/admin/form/form_review";
    }

    @RequestMapping("editReview/{id}")
    public String updateReview(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        ReviewEntity review = reviewService.findReviewById(id);
        if (review.getId() > 0) {
            model.addAttribute("action", "update_review");
            model.addAttribute("review", review);
            session.setAttribute("imageReviewByMovieId", review.getMovie().getId());
            session.setAttribute("imageNameReviewByMovieId", review.getReviewImages());
        } else {
            model.addAttribute("action", "add_review");
        }
        model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending()));
        return "/admin/form/form_review";
    }

    @RequestMapping(value = {"resultSaveReview"}, method = RequestMethod.POST)
    public String saveCategory(
            @Valid @ModelAttribute("review") ReviewEntity review,
            BindingResult result,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (result.hasFieldErrors("movie.id")) {
                model.addAttribute("messageMovie", "Select Review Movie!");
            }
            if (review.getId() > 0) {
                model.addAttribute("action", "update_review");
            } else {
                model.addAttribute("action", "add_review");
            }
            model.addAttribute("review", review);
            model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending()));
            return "/admin/form/form_review";
        } else {
            URL location = ManageAccountBankingController.class.getProtectionDomain().getCodeSource().getLocation();
            String saveDirectory = location.getFile().substring(1, location.getPath().lastIndexOf("WEB-INF")) + "/resources/images/review/idmovie" + review.getMovie().getId();
            Path path = Paths.get(saveDirectory);
            List<MultipartFile> files = review.getImages();
            List<String> fileNames = new ArrayList<String>();
            if (!Files.exists(path)) {
                Files.createDirectory(path);
            }
            if (review.getId() > 0) {
                List<ReviewImageEntity> ris = new ArrayList<>();
                List<ReviewImageEntity> reviewImages = reviewImageService.findReviewImageByReviewId(review.getId());
                for (MultipartFile multipartFile : files) {
                    String fileName = multipartFile.getOriginalFilename();
                    if (!fileName.equals("") && files.size() == 4) {
                        reviewImageService.deleteReviewImageByReviewId(review.getId());
                        fileNames.add(fileName);
                        multipartFile.transferTo(new File(path + "\\" + fileName));
                    } else if (fileName.equals("") && reviewImages.size() > 0) {
                        review.setReviewImages(reviewImages);
                    } else if (!fileName.equals("") && files.size() != 4) {
                        model.addAttribute("messageReviewImages", "Please Select 4 Image!");
                        model.addAttribute("review", review);
                        model.addAttribute("action", "update_review");
                        model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending()));
                        return "/admin/form/form_review";
                    }
                }
                if (fileNames.size() > 0) {
                    for (String file : fileNames) {
                        ReviewImageEntity reviewImage = new ReviewImageEntity(file, review);
                        ris.add(reviewImage);
                    }
                }
                review.setReviewer(accountLogin.getCustomer().getCustomerName());
                reviewService.saveOrUpdateReview(review);
                reviewImageService.saveReviewImage(ris);
                return "redirect:/admin/reviews";

            } else {
                if (files != null && files.size() == 4) {
                    for (MultipartFile multipartFile : files) {
                        String fileName = multipartFile.getOriginalFilename();
                        if (!fileName.equals("")) {
                            fileNames.add(fileName);
                            multipartFile.transferTo(new File(path + "\\" + fileName));
                        } else {
                            model.addAttribute("messageReviewImages", "Please Select 4 Image!");
                            model.addAttribute("review", review);
                            model.addAttribute("action", "add_review");
                            model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending()));
                            return "/admin/form/form_review";
                        }

                    }
                    List<ReviewImageEntity> ris = new ArrayList<>();
                    for (String fileName : fileNames) {
                        ReviewImageEntity reviewImage = new ReviewImageEntity(fileName, review);
                        ris.add(reviewImage);
                    }
                    ReviewEntity findReview = reviewService.findReviewByNameReview(review.getNameReview());
                    if (findReview != null && findReview.getId() > 0) {
                        model.addAttribute("messageReview", "Review is existed!");
                        model.addAttribute("review", review);
                        model.addAttribute("action", "add_review");
                        model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending()));
                        return "/admin/form/form_review";
                    } else {
                        review.setReviewer(accountLogin.getCustomer().getCustomerName());
                        reviewService.saveOrUpdateReview(review);
                        reviewImageService.saveReviewImage(ris);
                        return "redirect:/admin/reviews";
                    }
                } else {
                    model.addAttribute("messageReviewImages", "Please Select 4 Image!");
                    model.addAttribute("review", review);
                    model.addAttribute("action", "add_review");
                    model.addAttribute("movies", movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending()));
                    return "/admin/form/form_review";
                }
            }
        }
    }
}
