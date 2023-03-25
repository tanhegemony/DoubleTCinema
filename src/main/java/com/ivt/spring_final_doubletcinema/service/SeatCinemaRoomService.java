/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.CinemaEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.entities.SeatCinemaRoomEntity;
import com.ivt.spring_final_doubletcinema.entities.SeatEntity;
import com.ivt.spring_final_doubletcinema.repository.SeatCinemaRoomRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class SeatCinemaRoomService {

    @Autowired
    private SeatCinemaRoomRepository seatCinemaRoomRepository;

    @Autowired
    private SeatService seatService;

    public void addSeatCinemaRoomInManageCinemaRoom(long cinemaRoomId,
            String cinema, String cinemaRoomName, String rowCinemaRoomString, String columnCinemaRoomString) {
        List<SeatEntity> seats = seatService.getSeats();
        List<SeatCinemaRoomEntity> seatsCinemaRoom = new ArrayList<>();
        CinemaRoomEntity cinemaRoom = new CinemaRoomEntity();
        CinemaEntity cinemaEntity = new CinemaEntity();
        cinemaEntity.setId(Long.parseLong(cinema));
        cinemaRoom.setId(cinemaRoomId);
        cinemaRoom.setCinema(cinemaEntity);
        cinemaRoom.setCinemaRoomName(cinemaRoomName);
        cinemaRoom.setRowCinemaRoom(Integer.parseInt(rowCinemaRoomString));
        cinemaRoom.setColumnCinemaRoom(Integer.parseInt(columnCinemaRoomString));
        for (int i = 0; i < Integer.parseInt(rowCinemaRoomString); i++) {
            for (int j = 0; j < Integer.parseInt(columnCinemaRoomString); j++) {
                for (SeatEntity seat : seats) {
                    if (i == 0 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("A")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 1 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("B")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 2 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("C")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 3 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("D")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 4 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("E")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 5 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("F")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 6 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("G")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 7 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("H")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 8 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("I")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 9 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("J")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                    if (i == 10 && (Integer.parseInt(seat.getSeatNumber().substring(1)) == (j + 1))
                            && seat.getSeatNumber().substring(0, 1).equals("K")) {
                        SeatCinemaRoomEntity scr = new SeatCinemaRoomEntity(seat, cinemaRoom);
                        seatsCinemaRoom.add(scr);
                    }
                }
            }
        }
        saveSeatCinemaRoom(seatsCinemaRoom);
    }

    public void saveSeatCinemaRoom(List<SeatCinemaRoomEntity> seatsCinemaRoom) {
        seatCinemaRoomRepository.saveAll(seatsCinemaRoom);
    }

    public List<SeatCinemaRoomEntity> findSeatCinemaRoomById(long cinemaRoomId) {
        List<SeatCinemaRoomEntity> seatsCinemaRoom = (List<SeatCinemaRoomEntity>) seatCinemaRoomRepository.findByCinemaRoomId(cinemaRoomId);
        if (seatsCinemaRoom != null && seatsCinemaRoom.size() > 0) {
            return seatsCinemaRoom;
        }
        return new ArrayList<>();
    }

    public void deleteSeatCinemaRoom(List<SeatCinemaRoomEntity> seatsCinemaRoom) {
        seatCinemaRoomRepository.deleteAll(seatsCinemaRoom);
    }
}
