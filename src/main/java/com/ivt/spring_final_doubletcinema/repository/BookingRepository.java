/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.BookingEntity;
import com.ivt.spring_final_doubletcinema.enums.BookingStatus;
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
public interface BookingRepository extends CrudRepository<BookingEntity, Long> {

    List<BookingEntity> findByCode(String promotionCode);
        
    // find booking by customer and code
    BookingEntity findByCustomerIdAndCode(long customerId, String promotionCode);

    // show list booking by customer 
    List<BookingEntity> findByCustomerId(long customerId, Sort sort);

    // show list booking by customer and filter by booking date
    @Query("SELECT b FROM BookingEntity b WHERE b.customer.id = ?1 and b.bookingDate BETWEEN ?2 and ?3")
    List<BookingEntity> findByCustomerIdAndBookingDate(long customerId, Date startDate, Date toDate, Sort sort);

    // show list booking by customer and status
    List<BookingEntity> findByCustomerIdAndStatus(long customerId, BookingStatus status, Sort sort);

    // show list booking by customer and filter by booking date and status
    @Query("SELECT b FROM BookingEntity b WHERE b.customer.id = ?1 and b.bookingDate BETWEEN ?2 and ?3 and b.status = ?4")
    List<BookingEntity> findByCustomerIdAndBookingDateAndStatus(long customerId, Date startDate, Date toDate, BookingStatus status, Sort sort);

    //admin
    @Query("SELECT b FROM BookingEntity b")
    Page<BookingEntity> findBookings(Pageable pageable);

    public BookingEntity findAllById(long id);

    @Query(value = "select * from booking as b"
            + " join booking_detail as bd "
            + " on b.id = bd.bookingId"
            + " join movies as m"
            + " on bd.movieId = m.id "
            + " join customer as c "
            + " on b.customerId = c.id "
            + " where m.name_by_english like ?1 or c.customer_name like ?2 or b.booking_date like ?3 or bd.show_date like ?4", nativeQuery = true)
    Page<BookingEntity> findByBookingNameByEnglishOrCustomerNameOrBookingDateOrShowDate(String nameByEnglish, String customerName, String bookingDate, String showDate, Pageable pageable);
    @Query(value ="Select * From booking where booking_date like ?1", nativeQuery = true)
    List<BookingEntity> findbyBookingMonth(String monthThis);
    
    
    List<BookingEntity> findByStatus(BookingStatus bookingStatus);
}
