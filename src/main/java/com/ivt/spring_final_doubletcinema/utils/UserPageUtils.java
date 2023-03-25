/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.utils;

import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.http.HttpSession;
import org.springframework.ui.Model;

/**
 *
 * @author ngoct
 */
public class UserPageUtils {
    
    // reset session in ticket
    public static void resetAllSessionInSearchTicketFast(HttpSession session) {
        // handle part datetime
        SimpleDateFormat sdf = new SimpleDateFormat("YYYY-MM-dd");
        session.setAttribute("movieIdFilmFollow", "");
        session.setAttribute("showDateFilmFollow", sdf.format(new Date()));
        session.setAttribute("cinemaIdDayFollow", "");
        session.setAttribute("showDateDayFollow", sdf.format(new Date()));
        session.setAttribute("cinemaIdCinemaFollow", "");
        session.setAttribute("showDateCinemaFollow", sdf.format(new Date()));
    }
}
