/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.CategoryEntity;
import com.ivt.spring_final_doubletcinema.repository.CategoryRepository;
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
public class CategoryService {

    @Autowired
    private CategoryRepository categoryRepository;

    public CategoryEntity findByCategoryName(String categoryName){
        CategoryEntity category = categoryRepository.findByCategoryName(categoryName);
        if(category != null && category.getId() > 0){
            return category;
        }
        return new CategoryEntity();
    }
    
    public List<CategoryEntity> getCategoryByMovieId(long movieId) {
        List<CategoryEntity> categories = (List<CategoryEntity>) categoryRepository.getCategoryByMovieId(movieId);
        if (!CollectionUtils.isEmpty(categories)) {
            return categories;
        }
        return null;
    }

    public List<CategoryEntity> getCategories() {
        List<CategoryEntity> categories = (List<CategoryEntity>) categoryRepository.findAll();
        if (!CollectionUtils.isEmpty(categories)) {
            return categories;
        }
        return null;
    }

    //admin 
    // show categories have page
    public Page<CategoryEntity> getCategoryPagination(int currentPage, int pageSize, Sort sort) {
        Page<CategoryEntity> categories = categoryRepository.findCategories(PageRequest.of(currentPage, pageSize, sort));
        if (!categories.isEmpty()) {
            return categories;
        }
        return null;

    }

    // search category
    public Page<CategoryEntity> findByCategoryByName(String searchValue, int currentPage, int pagesize, Sort sort) {
        Page<CategoryEntity> categories = categoryRepository.findCategoryByName(searchValue, PageRequest.of(currentPage, pagesize, sort));
        if (!categories.isEmpty()) {
            return categories;
        }
        return null;
    }

    // delete category
    public void deleteCategory(long id) {
        categoryRepository.deleteById(id);
    }

    // find category by id
    public CategoryEntity findCategoryById(long id) {
        Optional<CategoryEntity> categoryOpt = categoryRepository.findById(id);
        if (categoryOpt != null && categoryOpt.isPresent()) {
            return categoryOpt.get();
        }
        return new CategoryEntity();
    }

    // save or update category
    public void saveOrUpdateCategory(CategoryEntity category) {
         categoryRepository.save(category);
    }
}
