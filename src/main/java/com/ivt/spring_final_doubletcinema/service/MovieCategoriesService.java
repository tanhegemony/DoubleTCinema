/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.MovieCategoryEntity;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ivt.spring_final_doubletcinema.repository.MovieCategoriesRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;

/**
 *
 * @author ngoct
 */
@Service
public class MovieCategoriesService {
    @Autowired
    private MovieCategoriesRepository movieCategoryRepositories;
    
    public List<MovieCategoryEntity> findMCByCategoryId(long categoryId){
        List<MovieCategoryEntity> movieCategories = movieCategoryRepositories.findByCategoryId(categoryId);
        if(movieCategories != null && movieCategories.size() > 0){
            return movieCategories;
        }
        return new ArrayList<>();
    }
    
    public void saveListMovieCategories(List<MovieCategoryEntity> movieCategories){
        movieCategoryRepositories.saveAll(movieCategories);
    }
    
    public void deleteMovieCategories(List<MovieCategoryEntity> movieCategories){
        movieCategoryRepositories.deleteAll(movieCategories);
    }
}
