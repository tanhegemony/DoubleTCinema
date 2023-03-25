/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.ViewedReviewMovieEntity;
import java.util.Date;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface ViewedReviewMovieRepository extends CrudRepository<ViewedReviewMovieEntity, Long>{
    
     // find viewed by date jsession and review
    ViewedReviewMovieEntity findByViewDateAndJSessionIdAndReviewId(Date viewDate, String JSessionId, long reviewId);
    
    // find viewed by date account and review
    ViewedReviewMovieEntity findByViewDateAndAccountIdAndReviewId(Date viewDate, long accountId, long reviewId);
}
