/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "review_image")
public class ReviewImageEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "image_review", length = 255)
    private String imageReview;
    
    @ManyToOne
    @JoinColumn(name = "reviewId")
    private ReviewEntity review;

    public ReviewImageEntity() {
    }

    public ReviewImageEntity(String imageReview, ReviewEntity review) {
        this.imageReview = imageReview;
        this.review = review;
    }

    
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getImageReview() {
        return imageReview;
    }

    public void setImageReview(String imageReview) {
        this.imageReview = imageReview;
    }

    public ReviewEntity getReview() {
        return review;
    }

    public void setReview(ReviewEntity review) {
        this.review = review;
    }
    
    
}
