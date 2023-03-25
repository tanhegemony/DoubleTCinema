/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.FoodEntity;
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
public interface FoodRepository extends CrudRepository<FoodEntity, Long>{
    //admin
    
    //show list foods have page
    @Query("SELECT f FROM FoodEntity f")
    Page<FoodEntity> findFoods(Pageable Pageable);
    
    // search food
    @Query(value = "SELECT * FROM food where name_food like ?1 " , nativeQuery = true)
     Page<FoodEntity> findFoodByName(String nameFood,Pageable Pageable);
     
    FoodEntity findByNameFood(String nameFood);
}
