/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.ViewedMovieEntity;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author ngoct
 */
@Repository
public interface ViewedMovieRepository extends CrudRepository<ViewedMovieEntity, Long>{
    
    ViewedMovieEntity findByJSessionAndMovieId(String JSession, long movieId);
    
    ViewedMovieEntity findByAccountIdAndJSessionAndMovieId(long accountId, String JSession, long movieId);
}
