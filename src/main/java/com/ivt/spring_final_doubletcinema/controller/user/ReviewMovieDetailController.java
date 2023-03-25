/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.user;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.LikeReviewMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.entities.ReviewEntity;
import com.ivt.spring_final_doubletcinema.entities.ViewedReviewMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.VoteReviewMovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.LikeReviewMovieService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import com.ivt.spring_final_doubletcinema.service.ReviewService;
import com.ivt.spring_final_doubletcinema.service.ViewedReviewMovieService;
import com.ivt.spring_final_doubletcinema.service.VoteReviewMovieService;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 *
 * @author ngoct
 */
@Controller
public class ReviewMovieDetailController {
    
    @Autowired
    private AccountService accountService;
    
    @Autowired
    private MovieService movieService;
    
    @Autowired
    private ReviewService reviewService;
    
    @Autowired
    private VoteReviewMovieService voteReviewMovieService;

    @Autowired
    private LikeReviewMovieService likeReviewMovieService;

    @Autowired
    private ViewedReviewMovieService viewedReviewMovieService;
    
    @Autowired
    HttpSession session;
    
    SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");

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
    
    @RequestMapping("reviewMovieDetail/{id}")
    public String reviewMovieDetail(
            @PathVariable("id") long id,
            Model model) {

        AccountEntity accountLogin = getAccountByUserLogin(model);
        viewFilmInHeaderInHomePage(model);

        // show info review 
        ReviewEntity review = reviewService.findReviewById(id);
        model.addAttribute("review", review);

        // save viewed review movie
        ViewedReviewMovieEntity viewedReviewMovieE = new ViewedReviewMovieEntity();
        if (accountLogin.getId() > 0) {
            viewedReviewMovieE.setAccount(accountLogin);
        } else {
            viewedReviewMovieE.setJSessionId(session.getId());
        }
        viewedReviewMovieE.setReview(review);
        viewedReviewMovieE.setViewDate(new Date());
        ViewedReviewMovieEntity viewedReviewMovie = new ViewedReviewMovieEntity();
        if (accountLogin.getId() > 0) {
            viewedReviewMovie = viewedReviewMovieService.findByViewDateAndAccountIdAndReviewId(
                    new Date(), accountLogin.getId(), id);
        } else {
            viewedReviewMovie = viewedReviewMovieService.findByViewDateAndJSessionIdAndReviewId(
                    new Date(), session.getId(), id);
        }
        if (viewedReviewMovie.getId() <= 0) {
            viewedReviewMovieService.saveViewedReviewMovie(viewedReviewMovieE);
            review.setViewNumber(review.getViewNumber() + 1);
            reviewService.saveOrUpdateReview(review);
        }

        // show review other but not review displaying
        List<ReviewEntity> reviewsOther = reviewService.findByIdNot(id);
        model.addAttribute("reviewsOther", reviewsOther);
        // show movie comming
        List<MovieEntity> moviesComing = movieService.viewByFilmItem(FilmItem.PHIM_DANG_CHIEU, Sort.by("id").ascending());
        model.addAttribute("moviesComing", moviesComing);
        // show list vote by review
        List<VoteReviewMovieEntity> votesReview = voteReviewMovieService.getVotesReviewByReviewId(id);
        model.addAttribute("votesReview", votesReview);
        // find voteReview exist
        VoteReviewMovieEntity voteReview = voteReviewMovieService.findVoteReviewByDateAndAccountAndReview(
                sdf.format(new Date()) + "%", accountLogin.getId(), id);
        model.addAttribute("voteReview", voteReview);
        // handle star vote
        int starVoteReview = voteReviewMovieService.averageStarVoteReview(id);
        model.addAttribute("starVoteReview", starVoteReview);

        // handle like
        LikeReviewMovieEntity likeReviewMovie = likeReviewMovieService.findByAccountIdAndReviewId(
                accountLogin.getId(), review.getId());
        model.addAttribute("likeReviewMovie", likeReviewMovie);

        model.addAttribute("account", accountLogin);
        session.setAttribute("reviewId", id);
        return "/user/review_movie_detail";
    }

    @RequestMapping(value = "addVoteReviewMovie", method = RequestMethod.POST)
    public String addVoteReviewMovie(
            @ModelAttribute("voteReviewMovie") VoteReviewMovieEntity voteReviewMovie,
            Model model) {
        // save vote
        AccountEntity accountLogin = getAccountByUserLogin(model);
        voteReviewMovie.setAccount(accountLogin);
        ReviewEntity review = reviewService.findReviewById((long) session.getAttribute("reviewId"));
        voteReviewMovie.setReview(review);
        voteReviewMovie.setDisplay(true);
        Date today = new Date();
        Timestamp voteDate = new Timestamp(today.getTime());
        voteReviewMovie.setVoteDate(voteDate);
        voteReviewMovieService.saveVoteReviewMovie(voteReviewMovie);
        // update vote number
        int starVoteReview = voteReviewMovieService.averageStarVoteReview((long) session.getAttribute("reviewId"));
        review.setVote(starVoteReview);
        reviewService.saveOrUpdateReview(review);

        return "redirect:reviewMovieDetail/" + session.getAttribute("reviewId");
    }

    @RequestMapping("likeReviewMovie")
    public String likeReviewMovie(Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        // update like number
        ReviewEntity review = reviewService.findReviewById((long) session.getAttribute("reviewId"));
        review.setLikeNumber(review.getLikeNumber() + 1);
        reviewService.saveOrUpdateReview(review);

        // save like
        LikeReviewMovieEntity likeReviewMovie = new LikeReviewMovieEntity();
        likeReviewMovie.setAccount(accountLogin);
        likeReviewMovie.setReview(review);
        likeReviewMovie.setLikeDate(new Date());
        likeReviewMovieService.saveOrUpdateLikeReviewMovie(likeReviewMovie);
        return "redirect:reviewMovieDetail/" + session.getAttribute("reviewId");
    }
}
