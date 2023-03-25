/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;
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
public interface InvoiceRepository extends CrudRepository<InvoiceEntity, Long> {
    //admin 

    // show list payments have page
    @Query("SELECT p FROM InvoiceEntity p")
    Page<InvoiceEntity> findInvoices(Pageable pageable);

    @Query(value = "SELECT * FROM invoices"
            + " where accountBankingName like ?1 or accountBankingEmail like ?2", nativeQuery = true)
    Page<InvoiceEntity> searchInvoicesByAccountBankingNameAndAccountBankingEmail(String cardName, String emailBanking,Pageable Pageable);
    
    @Query(value = "SELECT * FROM invoices where invoice_date like ?1", nativeQuery = true)
    List<InvoiceEntity> findInvoiceByDate(String invoiceDate);
    
    List<InvoiceEntity> findByBookingId(long bookingId);
    
    List<InvoiceEntity> findByAccountBankingNameAndAccountBankingEmail(String accountBankingName, String accountBankingEmail);
}
