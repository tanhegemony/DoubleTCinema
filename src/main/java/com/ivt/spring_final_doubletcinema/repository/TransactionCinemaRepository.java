/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.TransactionCinemaEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author ngoct
 */
@Repository
public interface TransactionCinemaRepository extends CrudRepository<TransactionCinemaEntity, Long> {

    @Query("SELECT tc FROM TransactionCinemaEntity tc")
    Page<TransactionCinemaEntity> getTransactionsCinema(Pageable pageable);

    @Query(value = "SELECT * FROM transaction_cinema as tc "
            + " join customer as c "
            + " on tc.customerId = c.id "
            + " where c.customer_name like ?1 or c.customer_email like ?2 or c.customer_phone like ?3", nativeQuery = true)
    Page<TransactionCinemaEntity> findTransactionCinemaByCustomer(String customerName, String customerEmail, String customerPhone, Pageable Pageable);

}
