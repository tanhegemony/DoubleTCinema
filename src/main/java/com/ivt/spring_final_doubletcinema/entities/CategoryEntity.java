/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.NotEmpty;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "category")
public class CategoryEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "category_name", unique = true, nullable = false)
    @NotEmpty(message = "CategoryName is not empty!")
    private String categoryName;
    
    @Transient
    private boolean checkMovieCategories;
    
    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<MovieCategoryEntity> movieCategories;

    public List<MovieCategoryEntity> getMovieCategories() {
        return movieCategories;
    }

    public void setMovieCategories(List<MovieCategoryEntity> movieCategories) {
        this.movieCategories = movieCategories;
    }

    public boolean isCheckMovieCategories() {
        return checkMovieCategories;
    }

    public void setCheckMovieCategories(boolean checkMovieCategories) {
        this.checkMovieCategories = checkMovieCategories;
    }
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return categoryName;
    }

    
    
}
