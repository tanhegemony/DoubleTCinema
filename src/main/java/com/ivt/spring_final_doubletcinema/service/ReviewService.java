/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.ReviewEntity;
import com.ivt.spring_final_doubletcinema.repository.ReviewRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author tanhegemony
 */
@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    public ReviewEntity findReviewByNameReview(String nameReview) {
        ReviewEntity review = reviewRepository.findByNameReview(nameReview);
        if (review != null && review.getId() > 0) {
            return review;
        }
        return new ReviewEntity();
    }

    public void saveOrUpdateReview(ReviewEntity review) {
        reviewRepository.save(review);
    }

    // show list review but not review id displaying
    @Transactional
    public List<ReviewEntity> findByIdNot(long id) {
        List<ReviewEntity> reviews = reviewRepository.findByIdNot(id);
        if (reviews.size() > 0 && reviews != null) {
            for (ReviewEntity review : reviews) {
                Hibernate.initialize(review.getReviewImages());
            }
            return reviews;
        }
        return new ArrayList<>();
    }

    // find Review by Id
    @Transactional
    public ReviewEntity findReviewById(long id) {
        Optional<ReviewEntity> reviewOpt = reviewRepository.findById(id);
        if (reviewOpt.get().getId() > 0 && reviewOpt != null) {
            Hibernate.initialize(reviewOpt.get().getReviewImages());
            return reviewOpt.get();
        }
        return new ReviewEntity();
    }

    // show list review in home page
    @Transactional
    public List<ReviewEntity> getReviews() {
        List<ReviewEntity> reviews = (List<ReviewEntity>) reviewRepository.findAll();
        if (reviews != null && reviews.size() > 0) {
            for (ReviewEntity review : reviews) {
                Hibernate.initialize(review.getReviewImages());
            }
            return reviews;
        }
        return null;
    }

    //admin
    @Transactional
    public Page<ReviewEntity> getReviewsPagination(int currentPage, int pageSize, Sort sort) {
        Page<ReviewEntity> reviews = reviewRepository.findReviews(PageRequest.of(currentPage, pageSize, sort));
        if (!reviews.isEmpty()) {
            for (ReviewEntity review : reviews) {
                Hibernate.initialize(review.getReviewImages());
            }
            return reviews;
        }
        return null;

    }

    @Transactional
    public Page<ReviewEntity> findReviewsByNameAndMovie(String searchValue, int currentPage, int pagesize, Sort sort) {
        Page<ReviewEntity> reviews = reviewRepository.findReviewsByNameAndMovie(searchValue, searchValue, PageRequest.of(currentPage, pagesize, sort));
        if (!reviews.isEmpty()) {
            for (ReviewEntity r : reviews) {
                Hibernate.initialize(r.getReviewImages());
            }
            return reviews;
        }
        return null;
    }

    public void deleteReview(long id) {
        reviewRepository.deleteById(id);
    }
}
