/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.enums.BookingStatus;
import com.ivt.spring_final_doubletcinema.repository.BookingRepository;
import java.text.ParseException;
import java.text.SimpleDateFormat;
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

/**
 *
 * @author tanhegemony
 */
@Service
public class BookingService {

    @Autowired
    private BookingRepository bookingRepository;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    SimpleDateFormat dateStandard = new SimpleDateFormat("yyyy-MM-dd");
    SimpleDateFormat timeStandard = new SimpleDateFormat("HH:mm:ss");

    @Transactional
    public List<BookingEntity> findBookingByPromotionCode(String promotionCode){
        List<BookingEntity> bookings = bookingRepository.findByCode(promotionCode);
        if(bookings != null && bookings.size() > 0){
            for(BookingEntity booking: bookings){
                Hibernate.initialize(booking.getBookingSeats());
            }
            return bookings;
        }
        return new ArrayList<>();
    }
    
    // find booking by customer and code
    public BookingEntity findBookingByCustomerIdAndPromotionCode(long customerId, String promotionCode) {
        BookingEntity booking = bookingRepository.findByCustomerIdAndCode(customerId, promotionCode);
        if (booking != null) {
            return booking;
        }
        return new BookingEntity();
    }

    // find Booking by Id
    @Transactional
    public BookingEntity findBookingById(long id) {
        Optional<BookingEntity> bookingOpt = bookingRepository.findById(id);
        if (bookingOpt.isPresent() && bookingOpt.get().getId() > 0) {
            Hibernate.initialize(bookingOpt.get().getBookingSeats());
            Hibernate.initialize(bookingOpt.get().getBookingFoods());
            return bookingOpt.get();
        }
        return new BookingEntity();
    }

    // show list booking by customer and filter by booking date and status
    @Transactional
    public List<BookingEntity> getListBookingByCustomerIdAndBookingDateAndStatus(long customerId, Date startDate, Date toDate, BookingStatus status, Sort sortBy) {
        List<BookingEntity> bookings
                = bookingRepository.findByCustomerIdAndBookingDateAndStatus(customerId, startDate, toDate, status, sortBy);
        if (bookings != null) {
            for (BookingEntity booking : bookings) {
                Hibernate.initialize(booking.getBookingSeats());
                Hibernate.initialize(booking.getBookingFoods());
            }
            return bookings;
        }
        return new ArrayList<>();
    }

    // show list booking by customer and status
    @Transactional
    public List<BookingEntity> getListBookingByCustomerIdAndStatus(long customerId, BookingStatus status, Sort sortBy) {
        List<BookingEntity> bookings = bookingRepository.findByCustomerIdAndStatus(customerId, status, sortBy);
        if (bookings != null) {
            for (BookingEntity booking : bookings) {
                Hibernate.initialize(booking.getBookingSeats());
                Hibernate.initialize(booking.getBookingFoods());
            }
            return bookings;
        }
        return new ArrayList<>();
    }

    // show list booking by customer and filter by booking date
    @Transactional
    public List<BookingEntity> getListBookingByCustomerIdAndBookingDate(long customerId, Date startDate, Date toDate, Sort sortBy) {
        List<BookingEntity> bookings
                = bookingRepository.findByCustomerIdAndBookingDate(customerId, startDate, toDate, sortBy);
        if (bookings != null) {
            for (BookingEntity booking : bookings) {
                Hibernate.initialize(booking.getBookingSeats());
                Hibernate.initialize(booking.getBookingFoods());
            }
            return bookings;
        }
        return new ArrayList<>();
    }

    // show list booking by customer 
    @Transactional
    public List<BookingEntity> getListBookingByCustomerId(long customerId, Sort sortBy) throws ParseException {
        List<BookingEntity> bookings = bookingRepository.findByCustomerId(customerId, sortBy);
        String fullShowTime = new String();
        if (bookings != null) {
            for (BookingEntity booking : bookings) {
                fullShowTime = dateStandard.format(booking.getBookingDetail().getShowDate()) + " " + timeStandard.format(booking.getBookingDetail().getShowTime());
                booking.getBookingDetail().setFullShowTime(sdf.parse(fullShowTime));
                Hibernate.initialize(booking.getBookingSeats());
                Hibernate.initialize(booking.getBookingFoods());
            }
            return bookings;
        }
        return new ArrayList<>();
    }

    public void saveBooking(BookingEntity booking) {
        bookingRepository.save(booking);
    }

    //admin
    //show list booking
    @Transactional
    public Page<BookingEntity> getBookingPagination(int currentPage, int pageSize, Sort sort) {
        Page<BookingEntity> bookings = bookingRepository.findBookings(PageRequest.of(currentPage, pageSize, sort));
        if (!bookings.isEmpty()) {
            for (BookingEntity b : bookings.getContent()) {
                Hibernate.initialize(b.getBookingSeats());
                Hibernate.initialize(b.getBookingFoods());
            }
            return bookings;
        }
        return null;
    }

    // find Booking by Id
    @Transactional
    public BookingEntity getBookingById(long id) {
        Optional<BookingEntity> bookingOpt = bookingRepository.findById(id);
        if (bookingOpt != null && bookingOpt.isPresent()) {
            Hibernate.initialize(bookingOpt.get().getBookingFoods());
            Hibernate.initialize(bookingOpt.get().getBookingSeats());
            return bookingOpt.get();
        }
        return new BookingEntity();
    }

    // update booking
    public void updateBooking(BookingEntity booking) {
        bookingRepository.save(booking);
    }

    public void deleteBooking(long id) {
        bookingRepository.deleteById(id);
    }

    @Transactional
    public Page<BookingEntity> searchBookings(String search, int currentPage, int pageSize, Sort sort) {
        Page<BookingEntity> bookings = bookingRepository.findByBookingNameByEnglishOrCustomerNameOrBookingDateOrShowDate(search, search, search, search, PageRequest.of(currentPage, pageSize, sort));
        if (!bookings.isEmpty()) {
            for (BookingEntity b : bookings.getContent()) {
                Hibernate.initialize(b.getBookingSeats());
                Hibernate.initialize(b.getBookingFoods());
            }
            return bookings;
        }
        return null;
    }

    @Transactional
    public List<BookingEntity> findBookingMonth(String monthThis) {
        List<BookingEntity> bookingMonthThis = bookingRepository.findbyBookingMonth(monthThis);
        if (bookingMonthThis.size() > 0 && bookingMonthThis != null) {
            for (BookingEntity b : bookingMonthThis) {
                Hibernate.initialize(b.getBookingSeats());
                Hibernate.initialize(b.getBookingFoods());
            }
            return bookingMonthThis;
        }
        return new ArrayList<>();
    }

    @Transactional
    public List<BookingEntity> findByBookingStatus(BookingStatus bookingStatus) {
        List<BookingEntity> bookings = bookingRepository.findByStatus(bookingStatus);
        if (bookings != null && bookings.size() > 0) {
            for (BookingEntity b : bookings) {
                Hibernate.initialize(b.getBookingSeats());
                Hibernate.initialize(b.getBookingFoods());
            }
            return bookings;
        }
        return new ArrayList<>();
    }

}
