/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.model;

import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import java.util.List;

/**
 *
 * @author TanHegemony
 */
public class AllCinemaMoviesInOneDateDisplay {
    private MovieEntity movie;
    private List<CinemaMovieDisplay> cinemaMoviesDisplay;

    public AllCinemaMoviesInOneDateDisplay() {
    }

    public AllCinemaMoviesInOneDateDisplay(MovieEntity movie, List<CinemaMovieDisplay> cinemaMoviesDisplay) {
        this.movie = movie;
        this.cinemaMoviesDisplay = cinemaMoviesDisplay;
    }
    
    public MovieEntity getMovie() {
        return movie;
    }

    public void setMovie(MovieEntity movie) {
        this.movie = movie;
    }

    public List<CinemaMovieDisplay> getCinemaMoviesDisplay() {
        return cinemaMoviesDisplay;
    }

    public void setCinemaMoviesDisplay(List<CinemaMovieDisplay> cinemaMoviesDisplay) {
        this.cinemaMoviesDisplay = cinemaMoviesDisplay;
    }
    
    
}
