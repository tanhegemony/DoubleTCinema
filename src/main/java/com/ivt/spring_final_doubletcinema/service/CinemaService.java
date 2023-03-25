/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.repository.CinemaRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class CinemaService {

    @Autowired
    private CinemaRepository cinemaRepository;

    
    public CinemaEntity findByCinemaName(String cinemaName){
        CinemaEntity cinema = cinemaRepository.findByNameCinema(cinemaName);
        if(cinema != null){
            return cinema;
        }
        return new CinemaEntity();
    }
    
    public CinemaEntity findByCinemaId(long id) {
        Optional<CinemaEntity> cinemaOpt = cinemaRepository.findById(id);
        if (!cinemaOpt.isEmpty() && cinemaOpt.isPresent()) {
            return cinemaOpt.get();
        }
        return null;
    }

    public CinemaEntity findByMovieId(long id) {
        Optional<CinemaEntity> cinemaOpt = cinemaRepository.findById(id);
        if (cinemaOpt != null && cinemaOpt.isPresent()) {
            return cinemaOpt.get();
        }
        return null;
    }

    public List<CinemaEntity> getCinemas() {
        List<CinemaEntity> cinemas = (List<CinemaEntity>) cinemaRepository.findAll();
        if (cinemas != null && cinemas.size() > 0) {
            return cinemas;
        }
        return null;
    }

    //admin
    // show list cinemas have page
    public Page<CinemaEntity> getCinemaPagination(int currentPage, int pageSize, Sort sort) {
        Page<CinemaEntity> cinemas = cinemaRepository.findCinemas(PageRequest.of(currentPage, pageSize, sort));
        if (!cinemas.isEmpty()) {
            return cinemas;
        }
        return null;

    }

    // search cinema
    public Page<CinemaEntity> findCinemaByName(String cinemaName, int currentPage, int pagesize, Sort sort) {
        Page<CinemaEntity> cinema = cinemaRepository.findCinemaByName("%"+cinemaName+"%", PageRequest.of(currentPage, pagesize, sort));
        if (!cinema.isEmpty()) {
            return cinema;
        }
        return null;
    }

    //delete Cinema
    public void deleteCinema(long id) {
        cinemaRepository.deleteById(id);
    }

    // find Cinema By Id
    public CinemaEntity findById(long id) {
        Optional<CinemaEntity> cinemaOpt = cinemaRepository.findById(id);

        if (cinemaOpt != null && cinemaOpt.isPresent()) {
            return cinemaOpt.get();
        }
        return new CinemaEntity();
    }

    // save or update cinema
    public void saveOrUpdateCinema(CinemaEntity cinema) {
        cinemaRepository.save(cinema);

    }

}
