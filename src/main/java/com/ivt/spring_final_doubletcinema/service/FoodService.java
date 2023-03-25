/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.FoodEntity;
import com.ivt.spring_final_doubletcinema.repository.FoodRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

/**
 *
 * @author tanhegemony
 */
@Service
public class FoodService {

    @Autowired
    private FoodRepository foodRepository;

    public FoodEntity findFoodByNameFood(String nameFood){
        FoodEntity food = foodRepository.findByNameFood(nameFood);
        if(food != null && food.getId() > 0){
            return food;
        }
        return new FoodEntity();
    }
    
    public List<FoodEntity> getFoods() {
        List<FoodEntity> foods = (List<FoodEntity>) foodRepository.findAll();
        if (!CollectionUtils.isEmpty(foods)) {
            return foods;
        }
        return null;
    }

    //admin
    // show list foods have page
    public Page<FoodEntity> getFoodsPagination(int currentPage, int pageSize, Sort sort) {
        Page<FoodEntity> foods = foodRepository.findFoods(PageRequest.of(currentPage, pageSize, sort));
        if (!foods.isEmpty()) {
            return foods;
        }
        return null;

    }

    // search food
    public Page<FoodEntity> findByFoodName(String searchValue, int currentPage, int pagesize, Sort sort) {
        Page<FoodEntity> food = foodRepository.findFoodByName(searchValue, PageRequest.of(currentPage, pagesize, sort));
        if (!food.isEmpty()) {
            return food;
        }
        return null;
    }

    // find food by id
    public FoodEntity findById(long id) {
        Optional<FoodEntity> foodOpt = foodRepository.findById(id);
        if (foodOpt != null && foodOpt.isPresent()) {
            return foodOpt.get();
        }
        return new FoodEntity();
    }

    // save or update food
    public void saveOrUpdateFood(FoodEntity foodEntity) {
        foodRepository.save(foodEntity);
    }
    
    public void deleteFood(long id){
        foodRepository.deleteById(id);
    }

}
