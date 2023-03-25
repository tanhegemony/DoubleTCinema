/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.CategoryEntity;
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
public interface CategoryRepository extends CrudRepository<CategoryEntity, Long>{
    
    @Query(value = "select * from category as c join movie_category as mc on c.id = mc.categoryId where mc.movieId = ?1", nativeQuery = true)
    List<CategoryEntity> getCategoryByMovieId(long movieId);
    
    //admin
    // show categories have page
    @Query("SELECT c FROM CategoryEntity c")
    Page<CategoryEntity> findCategories(Pageable pageable);
    //search category
    @Query(value = "SELECT * FROM category where category_name like ?1" , nativeQuery = true)
    Page<CategoryEntity> findCategoryByName(String categoryName , Pageable Pageable);
    
    CategoryEntity findByCategoryName(String categoryName);
}
