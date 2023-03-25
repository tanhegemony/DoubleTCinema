/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.ReviewImageEntity;
import com.ivt.spring_final_doubletcinema.repository.ReviewImageRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class ReviewImageService {
    @Autowired
    private ReviewImageRepository reviewImageRepository;
    
    public List<ReviewImageEntity> findReviewImageByReviewId(long reviewId){
        List<ReviewImageEntity> reviewImages = reviewImageRepository.findByReviewId(reviewId);
        if(reviewImages != null && reviewImages.size() > 0){
            return reviewImages;
        }
        return new ArrayList<>();
    }
    
    public void saveReviewImage(List<ReviewImageEntity> reviewImages){
        reviewImageRepository.saveAll(reviewImages);
    }
    
    public void deleteReviewImageByReviewId(long reviewId){
        reviewImageRepository.deleteReviewImagesByReviewId(reviewId);
    }
}
