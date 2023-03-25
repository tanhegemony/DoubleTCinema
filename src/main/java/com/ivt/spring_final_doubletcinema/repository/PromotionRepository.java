/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.PromotionEntity;
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
public interface PromotionRepository extends CrudRepository<PromotionEntity, Long>{
    PromotionEntity findByCode(String code);
    
    //admin
    
    // show list promotions have page
    @Query("SELECT p FROM PromotionEntity p")
    Page<PromotionEntity> findPromotions(Pageable Pageable);

    // search promotion
    @Query(value = "SELECT * FROM promotion where code like ?1" , nativeQuery = true)
    Page<PromotionEntity> findPromotionByCode(String promotionCode, Pageable Pageable);
}
