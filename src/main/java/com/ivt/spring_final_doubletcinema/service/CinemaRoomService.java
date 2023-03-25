/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.repository.CinemaRoomRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

/**
 *
 * @author tanhegemony
 */
@Service
public class CinemaRoomService {

    @Autowired
    private CinemaRoomRepository cinemaRoomRepository;

    @Autowired
    private CinemaService cinemaService;

    public boolean checkParam(HttpServletRequest request, String action,
            String cinema, String cinemaRoomName, String rowCinemaRoomString, String columnCinemaRoomString,
            Model model) {
        if (cinema.equals("")) {
            model.addAttribute("messageCinema", "Please Select Cinema!");
            model.addAttribute("cinemas", cinemaService.getCinemas());
            return false;
        } else {
            if (cinemaRoomName.equals("")) {
                model.addAttribute("messageCinemaRoomName", "CinemaRoomName is not empty!");
                model.addAttribute("cinemas", cinemaService.getCinemas());
                return false;
            } else {
                if (!cinemaRoomName.substring(0, 3).equals("RAP") || !StringUtils.isNumeric(cinemaRoomName.substring(3))) {
                    model.addAttribute("messageCinemaRoomName", "CinemaRoomName is not in the correct format!");
                    model.addAttribute("cinemas", cinemaService.getCinemas());
                    return false;
                } else {
                    CinemaRoomEntity findCinemaRoomExist = findByNameAndCinemaId(cinemaRoomName, Long.parseLong(cinema));
                    if (findCinemaRoomExist.getId() > 0 && action.equals("add_cinema_room")) {
                        model.addAttribute("messageCinemaRoomName", "CinemaRoomName is existed!");
                        model.addAttribute("cinemas", cinemaService.getCinemas());
                        return false;
                    } else {
                        int rowCinemaRoom = Integer.parseInt(rowCinemaRoomString);
                        if (rowCinemaRoom < 1 || rowCinemaRoom > 10) {
                            model.addAttribute("messageRowCinemaRoom", "RowCinemaRoom must be greater than 1 and less than 10");
                            model.addAttribute("cinemas", cinemaService.getCinemas());
                            return false;
                        } else {
                            int columnCinemaRoom = Integer.parseInt(columnCinemaRoomString);
                            if (columnCinemaRoom < 1 || columnCinemaRoom > 10) {
                                model.addAttribute("messageColumnCinemaRoom", "ColumnCinemaRoom must be greater than 1 and less than 10");
                                model.addAttribute("cinemas", cinemaService.getCinemas());
                                return false;
                            } else {
                                return true;
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    public List<CinemaRoomEntity> findByCinemaId(long cinemaId){
        List<CinemaRoomEntity> cinemaRooms = cinemaRoomRepository.findByCinemaId(cinemaId);
        if(cinemaRooms != null && cinemaRooms.size() > 0){
            return cinemaRooms;
        }
        return new ArrayList<>();
    }

    public CinemaRoomEntity findByNameAndCinemaId(String cinemaRoomName, long cinemaId) {
        CinemaRoomEntity cinemaRoom = cinemaRoomRepository.findByCinemaRoomNameAndCinemaId(cinemaRoomName, cinemaId);
        if (cinemaRoom != null && cinemaRoom.getId() > 0) {
            return cinemaRoom;
        }
        return new CinemaRoomEntity();
    }

    public CinemaRoomEntity findByCinemaRoomId(long id) {
        Optional<CinemaRoomEntity> cinemaRoomOpt = cinemaRoomRepository.findById(id);
        if (cinemaRoomOpt != null && cinemaRoomOpt.isPresent()) {
            return cinemaRoomOpt.get();
        }
        return null;
    }

    //admin
    // find cinema room by name
    public CinemaRoomEntity findCinemaRoomByName(String cinemaRoomName) {
        CinemaRoomEntity cinemaRoom = cinemaRoomRepository.findByCinemaRoomName(cinemaRoomName);
        if (cinemaRoom != null) {
            return cinemaRoom;
        }
        return new CinemaRoomEntity();
    }

    // show list cinema rooms have page
    public Page<CinemaRoomEntity> getCinemaRoomsPagination(int currentPage, int pageSize, Sort sort) {
        Page<CinemaRoomEntity> cinemaRooms = cinemaRoomRepository.findCinemaRooms(PageRequest.of(currentPage, pageSize, sort));
        if (!cinemaRooms.isEmpty()) {
            return cinemaRooms;
        }
        return null;

    }

    // search cinema room
    public Page<CinemaRoomEntity> findCinemaRoomByNameAndCinemaName(String searchValue, int currentPage, int pagesize, Sort sort) {
        Page<CinemaRoomEntity> cinemaRooms = cinemaRoomRepository.findCinemaRoomByNameAndCinemaName(searchValue, searchValue,PageRequest.of(currentPage, pagesize, sort));
        if (!cinemaRooms.isEmpty()) {
            return cinemaRooms;
        }
        return null;
    }

    // find cinema room by id
    public CinemaRoomEntity findById(long id) {
        Optional<CinemaRoomEntity> cinemaRoomOpt = cinemaRoomRepository.findById(id);
        if (cinemaRoomOpt != null && cinemaRoomOpt.isPresent()) {
            return cinemaRoomOpt.get();
        }
        return new CinemaRoomEntity();
    }

    // delete cinemaRoom
    public void deleteCinemaRoom(long id) {
        cinemaRoomRepository.deleteById(id);
    }

    // save or update cinemaRoom
    public void saveOrUpdateCinemaRoom(long cinemaRoomId, long cinemaId, String cinemaRoomName, int rowCinemaRoom, int columnCinemaRoom) {
        CinemaRoomEntity cinemaRoom = new CinemaRoomEntity();
        CinemaEntity cinema = new CinemaEntity();
        if (cinemaRoomId > 0) {
            cinemaRoom.setId(cinemaRoomId);
        }
        cinema.setId(cinemaId);
        cinemaRoom.setCinema(cinema);
        cinemaRoom.setCinemaRoomName(cinemaRoomName);
        cinemaRoom.setRowCinemaRoom(rowCinemaRoom);
        cinemaRoom.setColumnCinemaRoom(columnCinemaRoom);
        cinemaRoomRepository.save(cinemaRoom);
    }

    public List<CinemaRoomEntity> getCinemaRooms() {
        List<CinemaRoomEntity> cinemaRooms = (List<CinemaRoomEntity>) cinemaRoomRepository.findAll();
        if (cinemaRooms != null && cinemaRooms.size() > 0) {
            return cinemaRooms;
        }
        return new ArrayList<>();
    }
}
