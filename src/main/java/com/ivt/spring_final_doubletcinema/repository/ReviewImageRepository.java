/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.ReviewImageEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface ReviewImageRepository extends CrudRepository<ReviewImageEntity, Long>{
    List<ReviewImageEntity> findByReviewId(long reviewId);
    
    @Transactional
    @Modifying
    @Query(value = "delete from review_image where reviewId = ?1", nativeQuery = true)
    void deleteReviewImagesByReviewId(long reviewId);
}
