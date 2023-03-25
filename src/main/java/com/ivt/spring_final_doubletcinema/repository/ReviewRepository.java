/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.ReviewEntity;
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
public interface ReviewRepository extends CrudRepository<ReviewEntity, Long> {

    ReviewEntity findByNameReview(String nameReview);

    List<ReviewEntity> findByIdNot(long id);

    //admin
    @Query("SELECT r FROM ReviewEntity r")
    Page<ReviewEntity> findReviews(Pageable pageable);

    @Query(value = "SELECT * FROM review as r "
            + "	join movies as m "
            + " on r.movieId = m.id "
            + " where r.name_review  like ?1  or m.name_by_english like ?2", nativeQuery = true)
    Page<ReviewEntity> findReviewsByNameAndMovie(String nameReview, String nameByEnglish, Pageable Pageable);
}
