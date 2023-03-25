/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import static com.ivt.spring_final_doubletcinema.enums.FilmItem.PHIM_SAP_CHIEU;
import com.ivt.spring_final_doubletcinema.repository.MovieRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

/**
 *
 * @author tanhegemony
 */
@Service
public class MovieService {

    @Autowired
    private MovieRepository movieRepository;

    public List<MovieEntity> findMoviesByCinema(String cinemaId) {
        List<MovieEntity> movies = movieRepository.findMoviesByCinema(Long.parseLong(cinemaId));
        if (movies != null && movies.size() > 0) {
            return movies;
        }
        return new ArrayList<>();
    }

    public List<MovieEntity> findMoviesByShowDateAndCinema(String showDate, String cinemaId) {
        List<MovieEntity> movies = movieRepository.findMoviesByShowDateAndCinema(showDate, Long.parseLong(cinemaId));
        if (movies != null && movies.size() > 0) {
            return movies;
        }
        return new ArrayList<>();
    }

    public MovieEntity findByNameVietnam(String nameByVietnam) {
        MovieEntity movie = movieRepository.findByNameByVietnam(nameByVietnam);
        if (movie != null && movie.getId() > 0) {
            return movie;
        }
        return null;
    }

    public List<MovieEntity> filterMovie(FilmItem filmItem, String categoryName, String nation, Sort sortName) {
        List<MovieEntity> movies = null;
        if (categoryName != null && (nation == null || nation == "")) {
            movies = movieRepository.filterMovieWithCategory(filmItem, categoryName, sortName);
        } else if (categoryName == null && nation != null) {
            movies = movieRepository.filterMovieWithNation(filmItem, nation, sortName);
        } else if (categoryName != null && nation != null) {
            movies = movieRepository.filterMovieWithCategoryAndNation(filmItem, categoryName, nation, sortName);
        }
        if (!CollectionUtils.isEmpty(movies)) {
            return movies;
        }
        return null;
    }

    public List<MovieEntity> viewByFilmItem(FilmItem filmItem, Sort sortName) {
        List<MovieEntity> movies = movieRepository.findByFilmItem(filmItem, sortName);
        if (movies != null && movies.size() > 0) {
                return movies;
        }
        return new ArrayList<>();
    }

    public List<MovieEntity> searchMovieByNameOrCastWithDisplayBy(String searchValue, FilmItem filmItem, Sort sortName) {
        List<MovieEntity> movies = movieRepository.searchByNameByEnglishContainingOrNameByVietnamContainingOrCastContainingWithDisplayBy(searchValue, searchValue, searchValue, filmItem, sortName);
        if (!CollectionUtils.isEmpty(movies)) {
            return movies;
        }
        return null;
    }
    
    public List<MovieEntity> getMovies(){
        List<MovieEntity> movies = (List<MovieEntity>) movieRepository.findAll();
        if(movies != null && movies.size() > 0){
            return movies;
        }
        return new ArrayList<>();
    }

    public List<MovieEntity> searchMovieByNameOrCast(String searchValue, Sort sortName) {
        List<MovieEntity> movies = movieRepository.searchByNameByEnglishContainingOrNameByVietnamContainingOrCastContaining(searchValue, searchValue, searchValue, sortName);
        if (!CollectionUtils.isEmpty(movies)) {
            return movies;
        }
        return null;
    }

    @Transactional
    public MovieEntity findByMovieId(long id) {
        Optional<MovieEntity> movieOpt = movieRepository.findById(id);
        if (movieOpt != null && movieOpt.isPresent()) {
            Hibernate.initialize(movieOpt.get().getMovieCategories());
            return movieOpt.get();
        }
        return null;
    }

    public List<MovieEntity> searchFastTicketMovie(String premiereStart, String premiereEnd) {
        List<MovieEntity> movies = movieRepository.searchFastTicketMovieByPremiereAndFilmItem(premiereStart, premiereEnd);
        if (movies != null && movies.size() > 0) {
            return movies;
        }
        return null;
    }

    public List<MovieEntity> viewTop4ByFilmItem(FilmItem filmItem) {
        List<MovieEntity> movies = movieRepository.findTop4ByFilmItem(filmItem);
        if (movies != null && movies.size() > 0) {
            return movies;
        }
        return null;
    }

    public List<MovieEntity> viewTop6ByFilmItem(FilmItem filmItem) {
        List<MovieEntity> movies = movieRepository.findTop6ByFilmItem(filmItem);
        if (movies != null && movies.size() > 0) {
            return movies;
        }
        return null;
    }

    //admin
    // show list movies have page
    @Transactional
    public Page<MovieEntity> getMoviePagination(int currentPage, int pageSize, Sort sort) {
        Page<MovieEntity> movies = movieRepository.findMovies(PageRequest.of(currentPage, pageSize, sort));
        if (!movies.isEmpty()) {
            for (MovieEntity m : movies) {
                Hibernate.initialize(m.getMovieCategories());
            }
            return movies;
        }
        return null;

    }

    // save or update movie
    public void saveOrUpdateMovie(MovieEntity movie) {
        movieRepository.save(movie);
    }

    // search movie
    @Transactional
    public Page<MovieEntity> findByMovieName(String searchValue, int currentPage, int pagesize, Sort sort) {
        Page<MovieEntity> movies = movieRepository.findMovieByName(searchValue, searchValue, PageRequest.of(currentPage, pagesize, sort));
        if (!movies.isEmpty()) {
            for (MovieEntity m : movies) {
                Hibernate.initialize(m.getMovieCategories());
            }
            return movies;
        }
        return null;
    }

    // delete movie
    public void deleteMovie(long id) {
        movieRepository.deleteById(id);
    }

    // find movie by id
    public MovieEntity findMovieById(long id) {
        Optional<MovieEntity> movieOpt = movieRepository.findById(id);
        if (movieOpt != null && movieOpt.isPresent()) {
            return movieOpt.get();
        }
        return new MovieEntity();
    }

    // find movie by name english and film item
    public MovieEntity findByNameByEnglish(String nameByEnglish) {
        MovieEntity movie = movieRepository.findByNameByEnglish(nameByEnglish);
        if (movie != null) {
            return movie;
        }
        return new MovieEntity();
    }
}
