/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import java.util.Date;
import java.util.List;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface MovieRepository extends CrudRepository<MovieEntity, Long> {

    List<MovieEntity> findByFilmItem(FilmItem filmItem, Sort sort);

    MovieEntity findByNameByEnglish(String nameByEnglish);
    
    MovieEntity findByNameByVietnam(String nameByVietnam);

    @Query(value = "select * from movies where movies.premiere "
            + " between ?1 and ?2 "
            + " and movies.film_item = 'PHIM_DANG_CHIEU' order by movies.id", nativeQuery = true)
    List<MovieEntity> searchFastTicketMovieByPremiereAndFilmItem(String premiereStart, String premiereEnd);

    @Query("SELECT m FROM MovieEntity m WHERE m.nameByEnglish LIKE ?1 OR m.nameByVietnam LIKE ?2 OR m.cast LIKE ?3")
    List<MovieEntity> searchByNameByEnglishContainingOrNameByVietnamContainingOrCastContaining(String nameByEnglish, String nameByVietnam, String cast, Sort sort);

    @Query("SELECT m FROM MovieEntity m WHERE (m.nameByEnglish LIKE ?1 OR m.nameByVietnam LIKE ?2 OR m.cast LIKE ?3) AND m.filmItem = ?4")
    List<MovieEntity> searchByNameByEnglishContainingOrNameByVietnamContainingOrCastContainingWithDisplayBy(String nameByEnglish, String nameByVietnam, String cast, FilmItem filmItem, Sort sort);

    @Query("SELECT m FROM MovieEntity m JOIN FETCH m.movieCategories mc  WHERE m.filmItem = ?1 AND mc.category.categoryName = ?2")
    List<MovieEntity> filterMovieWithCategory(FilmItem filmItem, String categoryName, Sort sort);

    @Query("SELECT m FROM MovieEntity m JOIN FETCH m.movieCategories mc WHERE m.filmItem = ?1 AND m.nation = ?2")
    List<MovieEntity> filterMovieWithNation(FilmItem filmItem, String nation, Sort sort);

    @Query("SELECT m FROM MovieEntity m JOIN FETCH m.movieCategories mc WHERE m.filmItem = ?1 AND mc.category.categoryName = ?2 AND m.nation = ?3")
    List<MovieEntity> filterMovieWithCategoryAndNation(FilmItem filmItem, String categoryName, String nation, Sort sort);

    List<MovieEntity> findTop4ByFilmItem(FilmItem filmItem);

    List<MovieEntity> findTop6ByFilmItem(FilmItem filmItem);

    @Query(value = "select distinct m.* from movies as m "
            + " join cinema_movie as cm "
            + " on m.id = cm.movieId "
            + " join cinema as c "
            + " on c.id = cm.cinemaId "
            + " where cm.show_date = ?1 and c.id = ?2", nativeQuery = true)
    List<MovieEntity> findMoviesByShowDateAndCinema(String showDate, long cinemaId);
    
    
    @Query("SELECT DISTINCT m FROM MovieEntity m JOIN FETCH m.cinemaMovies cm WHERE cm.cinema.id = ?1")
    List<MovieEntity> findMoviesByCinema(long cinemaId);

    //admin
    // show list movies have page
    @Query("SELECT m FROM MovieEntity m")
    Page<MovieEntity> findMovies(Pageable pageable);

    // search movie
    @Query(value = "SELECT * FROM movies where name_by_english like ?1 or name_by_vietnam like ?2", nativeQuery = true)
    Page<MovieEntity> findMovieByName(String nameByEnglish, String nameByVietnam, Pageable Pageable);
}
