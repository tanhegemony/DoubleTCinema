/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface CinemaRepository extends CrudRepository<CinemaEntity, Long> {

    //admin
    // show list cinemas have page
    @Query("SELECT c FROM CinemaEntity c")
    Page<CinemaEntity> findCinemas(Pageable pageable);

    // search cinema
    @Query(value = "SELECT * FROM cinema where name_cinema like ?1", nativeQuery = true)
    Page<CinemaEntity> findCinemaByName(String cinemaName, Pageable Pageable);
    
    CinemaEntity findByNameCinema(String nameCinema);
}
