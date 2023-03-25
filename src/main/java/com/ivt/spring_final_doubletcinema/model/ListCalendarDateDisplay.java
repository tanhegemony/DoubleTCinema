/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.model;

/**
 *
 * @author tanhegemony
 */
public class ListCalendarDateDisplay {
    private String dateDisplay;
    
    private String dateData;

    public ListCalendarDateDisplay(String dateDisplay, String dateData) {
        this.dateDisplay = dateDisplay;
        this.dateData = dateData;
    }
    
    public String getDateDisplay() {
        return dateDisplay;
    }

    public void setDateDisplay(String dateDisplay) {
        this.dateDisplay = dateDisplay;
    }

    public String getDateData() {
        return dateData;
    }

    public void setDateData(String dateData) {
        this.dateData = dateData;
    }

    
    
    
}
