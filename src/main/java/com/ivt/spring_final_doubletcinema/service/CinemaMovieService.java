/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.repository.CinemaMovieRepository;
import java.util.ArrayList;
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
public class CinemaMovieService {

    @Autowired
    private CinemaMovieRepository cinemaMovieRepository;

    public List<CinemaMovieEntity> findByMovieId(long movieId){
        List<CinemaMovieEntity> cinemaMovies = cinemaMovieRepository.findByMovieId(movieId);
        if(cinemaMovies != null && cinemaMovies.size() > 0){
            return cinemaMovies;
        }
        return new ArrayList<>();
    }
    
    public List<CinemaMovieEntity> findByCinemaId(long cinemaId){
        List<CinemaMovieEntity> cinemaMovies = cinemaMovieRepository.findByCinemaId(cinemaId);
        if(cinemaMovies != null && cinemaMovies.size() > 0){
            return cinemaMovies;
        }
        return new ArrayList<>();
    }
    
    public List<CinemaMovieEntity> findByCinemaRoomId(long cinemaRoomId){
        List<CinemaMovieEntity> cinemaMovies = cinemaMovieRepository.findByCinemaRoomId(cinemaRoomId);
        if(cinemaMovies != null && cinemaMovies.size() > 0){
            return cinemaMovies;
        }
        return new ArrayList<>();
    }
    
    public List<CinemaMovieEntity> findCinemaMovieCinemaAndShowDate(long cinemaId, String showDate) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.findCinemaMovieCinemaAndShowDate(cinemaId, showDate);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return null;
    }

    // movie detail
    public List<CinemaMovieEntity> findCinemaMovieByMovieAndCinemaAndShowDate(long movieId, long cinemaId, String showDate) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.findCinemaMovieByMovieAndCinemaAndShowDate(movieId, cinemaId, showDate);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }

    // calendar movie by showDate
    public List<CinemaMovieEntity> findCinemaMovieByDateAndPresentTime(String showDate, String presentTime) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.findCinemaMovieByDateAndPresentTime(showDate, presentTime);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }

    public List<CinemaMovieEntity> getListShowTimeByNameAndCinemaAndDate(String nameByEnglish, String showDate, long cinemaId) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.getListShowTimeByNameAndCinemaAndDate(nameByEnglish, showDate, cinemaId);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }

    // calendar movie by cinema id
    public List<CinemaMovieEntity> findCinemaMovieByCinemaAndDate(long cinemaId, String showDate) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.findCinemaMovieByCinemaAndDate(cinemaId, showDate);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }

    // calendar movie by name film
    public List<CinemaMovieEntity> getListShowTimeByNameAndCinemaAndDateAndPresentTime(String nameByEnglish, long cinemaId, String showDate, String presentTime) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.getListShowTimeByNameAndCinemaAndDateAndPresentTime(nameByEnglish, cinemaId,showDate, presentTime);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }
    public List<CinemaMovieEntity> findCinemaMoviesByDateAndPresentTime(String showDate, String presentTime) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.findCinemaMoviesByDateAndPresentTime(showDate, presentTime);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }

    public List<CinemaMovieEntity> findCinemaMovieByNameAndDate(String nameByEnglish, String showDate) {
        List<CinemaMovieEntity> cinemaMovies
                = cinemaMovieRepository.findCinemaMovieByNameAndDate(nameByEnglish, showDate);
        if (cinemaMovies != null) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }

    // booking show info movie
    public CinemaMovieEntity findCinemaMovieByMovieIdAndCinemaIdAndDateAndTime(long movieId, long cinemaId, String showDate, String showTime) {
        CinemaMovieEntity cinemaMovie
                = cinemaMovieRepository.findCinemaMovieByMovieIdAndCinemaIdAndDateAndTime(movieId, cinemaId, showDate, showTime);
        if (cinemaMovie != null) {
            return cinemaMovie;
        }
        return new CinemaMovieEntity();
    }

    // search fast of home page and show time movie detail
    public List<CinemaMovieEntity> getTimeByCinemaIdAndMovieIdAndShowDateAndPresentTime(long movieId, long cinemaId, String showDate, String presentTime) {
        List<CinemaMovieEntity> cinemaMovies = cinemaMovieRepository.getTimeByCinemaIdAndMovieIdAndShowDateAndPresentTime(movieId, cinemaId, showDate, presentTime);
        if (cinemaMovies != null && cinemaMovies.size() > 0) {
            return cinemaMovies;
        }
        return new ArrayList<>();
    }

    //admin
    // show list cinemaMovie have page
    public Page<CinemaMovieEntity> getCinemaMoviePagination(int currentPage, int pageSize, Sort sort) {
        Page<CinemaMovieEntity> cinemaMovies = cinemaMovieRepository.findCinemaMovies(PageRequest.of(currentPage, pageSize, sort));
        if (!cinemaMovies.isEmpty()) {
            return cinemaMovies;
        }
        return null;

    }
    
    // search cinemaMovie
    public Page<CinemaMovieEntity> findCinemaMoviesByMovieAndCinemaAndRoom(String searchValue,int currentPage, int pageSize, Sort sort) {
        Page<CinemaMovieEntity> cinemaMovies = cinemaMovieRepository.findCinemaMoviesByMovieAndCinemaAndRoom(searchValue,searchValue,searchValue,searchValue,PageRequest.of(currentPage, pageSize, sort));
        if (!cinemaMovies.isEmpty()) {
            return cinemaMovies;
        }
        return null;

    }

    // delete cinemaMovie
    public void deleteCinemaMovie(long id) {
        cinemaMovieRepository.deleteById(id);
    }

    // find Cinema Movie By Id
    public CinemaMovieEntity findById(long id) {
        Optional<CinemaMovieEntity> cinemaMovieOpt = cinemaMovieRepository.findById(id);

        if (cinemaMovieOpt != null && cinemaMovieOpt.isPresent()) {
            return cinemaMovieOpt.get();
        }
        return new CinemaMovieEntity();
    }

    // save or update cinema Movie
    public void saveOrUpdateCinemaMovie(CinemaMovieEntity cinemaMovie) {
        if (cinemaMovie != null) {
            cinemaMovieRepository.save(cinemaMovie);
        }

    }
}
