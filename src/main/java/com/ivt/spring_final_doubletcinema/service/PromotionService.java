/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.PromotionEntity;
import com.ivt.spring_final_doubletcinema.repository.PromotionRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class PromotionService {
    
    @Autowired
    private PromotionRepository promotionRepository;
    
    public PromotionEntity findPromotionByCode(String code){
        PromotionEntity promotion = promotionRepository.findByCode(code);
        if(promotion != null){
            return promotion;
        }
        return new PromotionEntity();
    }
    
    public List<PromotionEntity> getPromotions(){
        List<PromotionEntity> promotions = (List<PromotionEntity>) promotionRepository.findAll();
        if(promotions != null && promotions.size() > 0){
            return promotions;
        }
        return new ArrayList<>();
    }
    
    //admin
    
    //show list promotions have page
    public Page<PromotionEntity> getPromotionsPagination(int currentPage, int pageSize, Sort sort) {
        Page<PromotionEntity> promotions = promotionRepository.findPromotions(PageRequest.of(currentPage, pageSize, sort));
        if (!promotions.isEmpty()) {
            return promotions;
        }
        return null;

    }

    // search promotion
    public Page<PromotionEntity> findPromotionByCode(String searchValue, int currentPage, int pagesize, Sort sort) {
        Page<PromotionEntity> promotions = promotionRepository.findPromotionByCode(searchValue, PageRequest.of(currentPage, pagesize, sort));
        if (!promotions.isEmpty()) {
            return promotions;

        }
        return null;
    }

    // find promotion by id
    public PromotionEntity findByPromotionId(long id) {
        Optional<PromotionEntity> movieOpt = promotionRepository.findById(id);
        if (movieOpt != null && movieOpt.isPresent()) {
            return movieOpt.get();
        }
        return new PromotionEntity();
    }

    // save or update promotion
    public void saveOrUpdatePromotion(PromotionEntity promotion) {
        promotionRepository.save(promotion);
    }
    
    public void deletePromotion(long id){
        promotionRepository.deleteById(id);
    }
}
