/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "accounts")
public class AccountEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @Column(length = 255, nullable = false)
    @NotEmpty(message = "Password is not empty!")
    private String password;

    @Column(name = "image_account", length = 50)
    private String imageAccount;

    @Transient
    private MultipartFile imageAcc;

    @Column(name = "is_lock")
    private boolean isLock;

    @Column(name = "create_date")
    @Temporal(TemporalType.TIMESTAMP)
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createDate;

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<ViewedMovieEntity> viewedMovies;

    public List<ViewedMovieEntity> getViewedMovies() {
        return viewedMovies;
    }

    public void setViewedMovies(List<ViewedMovieEntity> viewedMovies) {
        this.viewedMovies = viewedMovies;
    }
    
    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
    
    
    public boolean isIsLock() {
        return isLock;
    }

    public void setIsLock(boolean isLock) {
        this.isLock = isLock;
    }

    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<TransactionCinemaEntity> transactionsCinema;

    public List<TransactionCinemaEntity> getTransactionsCinema() {
        return transactionsCinema;
    }

    public void setTransactionsCinema(List<TransactionCinemaEntity> transactionsCinema) {
        this.transactionsCinema = transactionsCinema;
    }
    
    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<VoteMovieEntity> votesMovie;

    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<RoleAccountEntity> rolesAccount;

    @Valid
    @OneToOne(mappedBy = "account", cascade = CascadeType.ALL)
    private CustomerEntity customer;
    
    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<VoteReviewMovieEntity> votesReviewMovie;

    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<ViewedReviewMovieEntity> viewedReviewsMovie;
    
    @OneToMany(mappedBy = "account", cascade = CascadeType.ALL)
    private List<LikeReviewMovieEntity> likesReviewMovie;

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
    
    public CustomerEntity getCustomer() {
        return customer;
    }

    public void setCustomer(CustomerEntity customer) {
        this.customer = customer;
    }

    public List<RoleAccountEntity> getRolesAccount() {
        return rolesAccount;
    }

    public void setRolesAccount(List<RoleAccountEntity> rolesAccount) {
        this.rolesAccount = rolesAccount;
    }

    public List<VoteMovieEntity> getVotesMovie() {
        return votesMovie;
    }

    public void setVotesMovie(List<VoteMovieEntity> votesMovie) {
        this.votesMovie = votesMovie;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getImageAccount() {
        return imageAccount;
    }

    public void setImageAccount(String imageAccount) {
        this.imageAccount = imageAccount;
    }

    public MultipartFile getImageAcc() {
        return imageAcc;
    }

    public void setImageAcc(MultipartFile imageAcc) {
        this.imageAcc = imageAcc;
    }

    @Override
    public String toString() {
        return "AccountEntity{" + "id=" + id + ", password=" + password + ", imageAccount=" + imageAccount + ", imageAcc=" + imageAcc + ", isLock=" + isLock + ", createDate=" + createDate + ", rolesAccount=" + rolesAccount + ", customer=" + customer + '}';
    }
    
    
}
