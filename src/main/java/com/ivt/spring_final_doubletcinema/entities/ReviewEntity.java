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
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "review")
public class ReviewEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "name_review",length = 255, nullable = false, unique = true)
    @NotEmpty(message = "ReviewName is not empty!")
    private String nameReview;
    
    @Column(name = "content_review", length = 2000)
    @NotEmpty(message = "ReviewContent is not empty!")
    private String contentReview;
    
    @Column(name = "view_number")
    private int viewNumber;
    
    @Column(length = 1)
    private int vote;
    
    @Column(name = "like_number")
    private int likeNumber;
    
    private String reviewer;

    public String getReviewer() {
        return reviewer;
    }

    public void setReviewer(String reviewer) {
        this.reviewer = reviewer;
    }
    
    @Transient
    private List<MultipartFile> images;

    public List<MultipartFile> getImages() {
        return images;
    }

    public void setImages(List<MultipartFile> images) {
        this.images = images;
    }
    
    @OneToMany(mappedBy = "review", cascade = CascadeType.ALL)
    private List<ReviewImageEntity> reviewImages;

    @OneToMany(mappedBy = "review", cascade = CascadeType.ALL)
    private List<VoteReviewMovieEntity> votesReviewMovie;
    
    @OneToMany(mappedBy = "review", cascade = CascadeType.ALL)
    private List<LikeReviewMovieEntity> likesReviewMovie;
    
    @ManyToOne
    @JoinColumn(name = "movieId")
    @NotNull()
    private MovieEntity movie;

    @OneToMany(mappedBy = "review", cascade = CascadeType.ALL)
    private List<ViewedReviewMovieEntity> viewedReviewsMovie;

    public List<LikeReviewMovieEntity> getLikesReviewMovie() {
        return likesReviewMovie;
    }

    public void setLikesReviewMovie(List<LikeReviewMovieEntity> likesReviewMovie) {
        this.likesReviewMovie = likesReviewMovie;
    }
    
    public List<ViewedReviewMovieEntity> getViewedReviewsMovie() {
        return viewedReviewsMovie;
    }

    public void setViewedReviewsMovie(List<ViewedReviewMovieEntity> viewedReviewsMovie) {
        this.viewedReviewsMovie = viewedReviewsMovie;
    }
    
    public List<VoteReviewMovieEntity> getVotesReviewMovie() {
        return votesReviewMovie;
    }

    public void setVotesReviewMovie(List<VoteReviewMovieEntity> votesReviewMovie) {
        this.votesReviewMovie = votesReviewMovie;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getNameReview() {
        return nameReview;
    }

    public void setNameReview(String nameReview) {
        this.nameReview = nameReview;
    }

    public String getContentReview() {
        return contentReview;
    }

    public void setContentReview(String contentReview) {
        this.contentReview = contentReview;
    }

    public int getViewNumber() {
        return viewNumber;
    }

    public void setViewNumber(int viewNumber) {
        this.viewNumber = viewNumber;
    }

    public int getVote() {
        return vote;
    }

    public void setVote(int vote) {
        this.vote = vote;
    }

    public int getLikeNumber() {
        return likeNumber;
    }

    public void setLikeNumber(int likeNumber) {
        this.likeNumber = likeNumber;
    }

    public List<ReviewImageEntity> getReviewImages() {
        return reviewImages;
    }

    public void setReviewImages(List<ReviewImageEntity> reviewImages) {
        this.reviewImages = reviewImages;
    }

    public MovieEntity getMovie() {
        return movie;
    }

    public void setMovie(MovieEntity movie) {
        this.movie = movie;
    }

    
    
    
}
