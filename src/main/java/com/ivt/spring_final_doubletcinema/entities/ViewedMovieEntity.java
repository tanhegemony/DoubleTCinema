/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 *
 * @author ngoct
 */
@Entity
@Table(name = "viewed_movie")
public class ViewedMovieEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @ManyToOne()
    @JoinColumn(name = "movieId")
    private MovieEntity movie;
    
    @ManyToOne()
    @JoinColumn(name = "accountId")
    private AccountEntity account;
    
    private String JSession;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public MovieEntity getMovie() {
        return movie;
    }

    public void setMovie(MovieEntity movie) {
        this.movie = movie;
    }

    public AccountEntity getAccount() {
        return account;
    }

    public void setAccount(AccountEntity account) {
        this.account = account;
    }

    public String getJSession() {
        return JSession;
    }

    public void setJSession(String JSession) {
        this.JSession = JSession;
    }
}
