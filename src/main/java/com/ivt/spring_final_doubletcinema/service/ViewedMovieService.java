/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.ViewedMovieEntity;
import com.ivt.spring_final_doubletcinema.repository.ViewedMovieRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author ngoct
 */
@Service
public class ViewedMovieService {
    @Autowired
    private ViewedMovieRepository viewedMovieRepository;
    
    public void saveViewedMovie(ViewedMovieEntity viewedMovie){
        viewedMovieRepository.save(viewedMovie);
    }
    
    public ViewedMovieEntity findVMByJSessionAndMovieId(String JSession, long movieId){
        ViewedMovieEntity viewedMovie = viewedMovieRepository.findByJSessionAndMovieId(JSession, movieId);
        if(viewedMovie != null && viewedMovie.getId() > 0){
            return viewedMovie;
        }
        return new ViewedMovieEntity();
    }
     
    public ViewedMovieEntity findVMByAccountIdAndJSessionAndMovieId(long accountId, String JSession, long movieId){
        ViewedMovieEntity viewedMovie = viewedMovieRepository.findByAccountIdAndJSessionAndMovieId(accountId, JSession, movieId);
        if(viewedMovie != null && viewedMovie.getId() > 0){
            return viewedMovie;
        }
        return new ViewedMovieEntity();
    }
}
