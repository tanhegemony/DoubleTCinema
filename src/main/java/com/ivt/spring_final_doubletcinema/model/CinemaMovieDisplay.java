/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.model;

import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import java.util.List;

/**
 *
 * @author tanhegemony
 */
public class CinemaMovieDisplay {
    private MovieEntity movie;
    private CinemaEntity cinema;
    private String showDate;
    private List<CinemaMovieEntity> showTime;

    public CinemaMovieDisplay() {
    }
    
    public CinemaMovieDisplay(MovieEntity movie, CinemaEntity cinema, String showDate, List<CinemaMovieEntity> showTime) {
        this.movie = movie;
        this.cinema = cinema;
        this.showDate = showDate;
        this.showTime = showTime;
    }

    public MovieEntity getMovie() {
        return movie;
    }

    public void setMovie(MovieEntity movie) {
        this.movie = movie;
    }

    public CinemaEntity getCinema() {
        return cinema;
    }

    public void setCinema(CinemaEntity cinema) {
        this.cinema = cinema;
    }

    public String getShowDate() {
        return showDate;
    }

    public void setShowDate(String showDate) {
        this.showDate = showDate;
    }

    public List<CinemaMovieEntity> getShowTime() {
        return showTime;
    }

    public void setShowTime(List<CinemaMovieEntity> showTime) {
        this.showTime = showTime;
    }

    @Override
    public String toString() {
        return "CinemaMovieDisplay{" + "movie=" + movie.getNameByEnglish() + "\n" + 
                ", cinema=" + cinema.getNameCinema() + "\n" + 
                ", showDate=" + showDate + "\n" + 
                ", showTime=" + showTime + '}';
    }

    

   
    
}
