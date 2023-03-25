/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.LikeReviewMovieEntity;
import com.ivt.spring_final_doubletcinema.repository.LikeReviewMovieRepository;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class LikeReviewMovieService {
    @Autowired
    private LikeReviewMovieRepository likeReviewMovieRepository;
    
    public void saveOrUpdateLikeReviewMovie(LikeReviewMovieEntity likeReviewMovie){
        likeReviewMovieRepository.save(likeReviewMovie);
    }
    
    public LikeReviewMovieEntity findByAccountIdAndReviewId(long accountId, long reviewId){
        LikeReviewMovieEntity likeReview = likeReviewMovieRepository.findByAccountIdAndReviewId(
                accountId, reviewId);
        if(likeReview != null){
            return  likeReview;
        }
        return new LikeReviewMovieEntity();
    }
}
