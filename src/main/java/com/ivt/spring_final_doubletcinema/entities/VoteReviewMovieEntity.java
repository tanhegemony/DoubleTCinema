/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "vote_review_movie")
public class VoteReviewMovieEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "star_number", length = 1)
    private int starNumber;
    
    @Column(length = 1000)
    private String comment;
    
    @ManyToOne
    @JoinColumn(name = "reviewId")
    private ReviewEntity review;
    
    @ManyToOne
    @JoinColumn(name = "accountId")
    private AccountEntity account;

    @Column(name = "vote_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date voteDate;
    
    private boolean display;

    public boolean isDisplay() {
        return display;
    }

    public void setDisplay(boolean display) {
        this.display = display;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public int getStarNumber() {
        return starNumber;
    }

    public void setStarNumber(int starNumber) {
        this.starNumber = starNumber;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public ReviewEntity getReview() {
        return review;
    }

    public void setReview(ReviewEntity review) {
        this.review = review;
    }

    public AccountEntity getAccount() {
        return account;
    }

    public void setAccount(AccountEntity account) {
        this.account = account;
    }

    public Date getVoteDate() {
        return voteDate;
    }

    public void setVoteDate(Date voteDate) {
        this.voteDate = voteDate;
    }
    
    
}
