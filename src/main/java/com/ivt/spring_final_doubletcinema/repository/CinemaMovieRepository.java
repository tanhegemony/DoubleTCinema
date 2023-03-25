/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
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
public interface CinemaMovieRepository extends CrudRepository<CinemaMovieEntity, Long> {

    List<CinemaMovieEntity> findByMovieId(long movieId);
    
    List<CinemaMovieEntity> findByCinemaId(long cinemaId);
    
    List<CinemaMovieEntity> findByCinemaRoomId(long cinemaRoomId);
    
    // booking show info movie
    @Query(value = "select * from cinema_movie where "
            + "movieId = ?1 and cinemaId = ?2 "
            + "and show_date = ?3 and show_time = ?4 group by cinemaId", nativeQuery = true)
    CinemaMovieEntity findCinemaMovieByMovieIdAndCinemaIdAndDateAndTime(long movieId, long cinemaId, String showDate, String showTime);

    @Query(value = "select * from cinema_movie where "
            + "movieId = ?1 and cinemaId = ?2 "
            + "and show_date = ?3 group by cinemaId", nativeQuery = true)
    List<CinemaMovieEntity> findCinemaMovieByMovieAndCinemaAndShowDate(long movieId, long cinemaId, String showDate);

    @Query(value = "select * from cinema_movie as cm "
            + " join movies as m "
            + " on cm.movieId = m.id "
            + " where cm.cinemaId = ?1 and cm.show_date = ?2 group by cm.movieId", nativeQuery = true)
    List<CinemaMovieEntity> findCinemaMovieCinemaAndShowDate(long cinemaId, String showDate);

    // calendar movie by show date
    @Query(value = "select * from cinema_movie as cm "
            + " join movies as m "
            + " on cm.movieId = m.id "
            + " join cinema as c "
            + " on cm.cinemaId = c.id "
            + " where cm.show_date = ?1 and cm.show_time >= ?2 group by cm.movieId", nativeQuery = true)
    List<CinemaMovieEntity> findCinemaMovieByDateAndPresentTime(String showDate, String presentTime);

    @Query(value = "select * from cinema_movie as cm "
            + " join movies as m "
            + " on cm.movieId = m.id "
            + " join cinema as c "
            + " on cm.cinemaId = c.id "
            + " where m.name_by_english = ?1 and cm.show_date = ?2 and cm.cinemaId = ?3", nativeQuery = true)
    List<CinemaMovieEntity> getListShowTimeByNameAndCinemaAndDate(String nameByEnglish, String showDate, long cinemaId);

    // calendar movie by cinema id
    @Query(value = "select * from cinema_movie as cm "
            + " join movies as m "
            + " on cm.movieId = m.id "
            + " where cm.cinemaId = ?1 and cm.show_date = ?2 group by movieId order by movieId ", nativeQuery = true)
    List<CinemaMovieEntity> findCinemaMovieByCinemaAndDate(long cinemaId, String showDate);

    // calendar movie by name film
    @Query(value = "select * from cinema_movie as cm "
            + " join movies as m "
            + " on cm.movieId = m.id "
            + " join cinema as c "
            + " on cm.cinemaId = c.id "
            + " where m.name_by_english = ?1 and c.id = ?2 and cm.show_date = ?3 and cm.show_time >= ?4 ", nativeQuery = true)
    List<CinemaMovieEntity> getListShowTimeByNameAndCinemaAndDateAndPresentTime(String nameByEnglish, long cinemaId, String showDate, String presentTime);
    
    @Query(value = "select * from cinema_movie as cm "
            + " join movies as m "
            + " on cm.movieId = m.id "
            + " join cinema as c "
            + " on cm.cinemaId = c.id "
            + " where cm.show_date = ?1 and cm.show_time >= ?2 group by m.id", nativeQuery = true)
    List<CinemaMovieEntity> findCinemaMoviesByDateAndPresentTime(String showDate, String presentTime);

    @Query(value = "select * from cinema_movie as cm "
            + " join movies as m "
            + " on cm.movieId = m.id "
            + " where m.name_by_english = ?1 and cm.show_date = ?2 group by cm.cinemaId", nativeQuery = true)
    List<CinemaMovieEntity> findCinemaMovieByNameAndDate(String nameByEnglish, String showDate);

    // search fast of home page
    @Query(value = "select * from cinema_movie where "
            + " movieId = ?1 "
            + " and cinemaId = ?2 "
            + " and show_date = ?3 "
            + " and show_time >= ?4 "
            + " group by show_time order by show_time", nativeQuery = true)
    List<CinemaMovieEntity> getTimeByCinemaIdAndMovieIdAndShowDateAndPresentTime(long movieId, long cinemaId, String showDate, String presentTime);

    //admin
    // show list cinema movies have page
    @Query("SELECT cm FROM CinemaMovieEntity cm")
    Page<CinemaMovieEntity> findCinemaMovies(Pageable pageable);

    @Query(value = "select * from cinema_movie cm "
            + " join cinema as c "
            + " on c.id = cm.cinemaId "
            + " join movies as m "
            + " on m.id = cm.movieId "
            + " join cinema_room as cr"
            + " on cr.id = cm.cinemaRoomId "
            + " where  m.name_by_english like ?1 or m.name_by_vietnam like ?2 or c.name_cinema like ?3 or cr.cinema_room_name like ?4", nativeQuery = true)
    Page<CinemaMovieEntity> findCinemaMoviesByMovieAndCinemaAndRoom(String nameByEnglish, String nameByVietnam, String nameCinema, String cinemaRoomName, Pageable pageable);
}
