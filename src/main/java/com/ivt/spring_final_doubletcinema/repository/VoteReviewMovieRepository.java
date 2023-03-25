/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.VoteMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.VoteReviewMovieEntity;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface VoteReviewMovieRepository extends CrudRepository<VoteReviewMovieEntity, Long>{
    
    // get Vote review by reviewId
    List<VoteReviewMovieEntity> findByReviewId(long reviewId);
    
    @Query("SELECT vrm FROM VoteReviewMovieEntity vrm")
    Page<VoteReviewMovieEntity> findVotesReviewMovie(Pageable pageable);
    
    // find Vote review by date, account, review
    @Query(value = "select * from vote_review_movie "
            + " where vote_date like ?1 and "
            + " accountId = ?2 and reviewId = ?3", nativeQuery = true)
    VoteReviewMovieEntity findVoteReviewByDateAndAccountAndReview(String voteDate,long accountId, long reviewId);

    @Query(value = "SELECT * FROM vote_review_movie as vrm " +
"             join review as r " +
"             on vrm.reviewId = r.id " +
"             join accounts as a " +
"             on vrm.accountId = a.id " +
"             join customer as c " +
"             on a.id = c.accountId " +
"            where r.name_review like ?1 or c.customer_name like ?2", nativeQuery = true)
    Page<VoteReviewMovieEntity> findVoteReviewMoviesByReviewAndCustomer(String nameReview, String customerName, Pageable Pageable);

    @Query(value = "SELECT * FROM vote_review_movie" +
                    " where star_number = ?1", nativeQuery = true)
    Page<VoteReviewMovieEntity> findByStarNumber(String starNumber, Pageable Pageable);
}
