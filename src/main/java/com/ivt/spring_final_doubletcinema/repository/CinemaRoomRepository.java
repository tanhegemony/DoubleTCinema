/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.CinemaRoomEntity;
import java.util.List;
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
public interface CinemaRoomRepository extends CrudRepository<CinemaRoomEntity, Long> {
    //admin

    // show list cinema rooms have page
    @Query("SELECT c FROM CinemaRoomEntity c")
    Page<CinemaRoomEntity> findCinemaRooms(Pageable Pageable);

    // search cinema room
    @Query(value = "SELECT * FROM cinema_room as cr "
            + " join cinema as c "
            + " on cr.cinemaId = c.id "
            + " where cr.cinema_room_name like ?1 or c.name_cinema like ?2 ", nativeQuery = true)
    Page<CinemaRoomEntity> findCinemaRoomByNameAndCinemaName(String cinemaRoomName, String cinemaName,Pageable Pageable);

    // find cinema room by name
    CinemaRoomEntity findByCinemaRoomName(String cinemaRoomName);

    CinemaRoomEntity findByCinemaRoomNameAndCinemaId(String cinemaRoomName, long cinemaId);

    List<CinemaRoomEntity> findByCinemaId(long cinemaId);
}
