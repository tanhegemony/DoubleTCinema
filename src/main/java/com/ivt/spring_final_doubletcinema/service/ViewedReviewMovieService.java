/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.ViewedReviewMovieEntity;
import com.ivt.spring_final_doubletcinema.repository.ViewedReviewMovieRepository;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class ViewedReviewMovieService {
    @Autowired
    private ViewedReviewMovieRepository viewedReviewMovieRepository;
    
    // find viewed by date jsession and review
    public ViewedReviewMovieEntity findByViewDateAndJSessionIdAndReviewId(Date viewDate, String jSessionId, long reviewId){
        ViewedReviewMovieEntity viewedReviewMovie = viewedReviewMovieRepository.findByViewDateAndJSessionIdAndReviewId(
                viewDate, jSessionId, reviewId);
        if(viewedReviewMovie != null){
            return viewedReviewMovie;
        }
        return new ViewedReviewMovieEntity();
    }
    
    public void saveViewedReviewMovie(ViewedReviewMovieEntity viewedReviewMovie){
        viewedReviewMovieRepository.save(viewedReviewMovie);
    }
    
    // find viewed by date account and review
    public ViewedReviewMovieEntity findByViewDateAndAccountIdAndReviewId(Date viewDate, long accountId, long reviewId){
        ViewedReviewMovieEntity viewedReviewMovie = viewedReviewMovieRepository.findByViewDateAndAccountIdAndReviewId(
                viewDate, accountId, reviewId);
        if(viewedReviewMovie != null){
            return viewedReviewMovie;
        }
        return new ViewedReviewMovieEntity();
    }
}
