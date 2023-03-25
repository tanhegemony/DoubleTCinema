/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
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
public interface CustomerRepository extends CrudRepository<CustomerEntity, Long>{
    // find by accountId
    CustomerEntity findByAccountId(long accountId);
    // find by email
    CustomerEntity findByCustomerEmail(String customerEmail);
    // find by email but not id displaying
    CustomerEntity findByCustomerEmailAndIdNot(String customerEmail, long customerId);
    // find by phone
    CustomerEntity findByCustomerPhone(String customerPhone);
    // find by phone but not id displaying
    CustomerEntity findByCustomerPhoneAndIdNot(String customerPhone, long customerId);
    
    
    //admin
    
    // show list customers have page
    @Query("SELECT c FROM CustomerEntity c")
    Page<CustomerEntity> findCustomser(Pageable Pageable);
   
    // search customer
    @Query(value = "SELECT * FROM customer where customer_name like ?1 or customer_email like ?2 Or customer_phone like ?3" , nativeQuery = true)
    Page<CustomerEntity> findCustomerByNameOrEmailOrPhone(String customerName ,String customerEmail,String customerPhone, Pageable Pageable);
}
