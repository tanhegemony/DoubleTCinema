/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.AccountBankingEntity;
import com.ivt.spring_final_doubletcinema.entities.InvoiceEntity;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import com.ivt.spring_final_doubletcinema.repository.InvoiceRepository;
import java.util.Optional;
import org.hibernate.Hibernate;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author tanhegemony
 */
@Service
public class InvoiceService {

    @Autowired
    private InvoiceRepository invoiceRepository;
    

    public List<InvoiceEntity> findInvoicesByAccountBankingNameAndEmail(String accountBankingName, String accountBankingEmail){
        List<InvoiceEntity> invoices = invoiceRepository.findByAccountBankingNameAndAccountBankingEmail(accountBankingName, accountBankingEmail);
        if(invoices != null && invoices.size() > 0){
            return invoices;
        }
        return new ArrayList<>();
    }
    
    @Transactional
    public List<InvoiceEntity> findInvoicesByBookingId(long bookingId){
        List<InvoiceEntity> invoices = invoiceRepository.findByBookingId(bookingId);
        if(invoices != null && invoices.size() > 0){
            for(InvoiceEntity i: invoices){
                Hibernate.initialize(i.getBooking().getBookingSeats());
                Hibernate.initialize(i.getBooking().getBookingFoods());
                Hibernate.initialize(i.getBooking().getBookingTickets());
            }
            return invoices;
        }
        return new ArrayList<>();
    }
    
    public void saveInvoice(InvoiceEntity invoice) {
        invoiceRepository.save(invoice);
    }

    //admin
    //show list payments have page
    @Transactional
    public Page<InvoiceEntity> getInvoicesPagination(int currentPage, int pageSize, Sort sort) {
        Page<InvoiceEntity> invoices = invoiceRepository.findInvoices(PageRequest.of(currentPage, pageSize, sort));
        if (!invoices.isEmpty()) {
            for(InvoiceEntity i: invoices){
                Hibernate.initialize(i.getBooking().getBookingSeats());
                Hibernate.initialize(i.getBooking().getBookingFoods());
                Hibernate.initialize(i.getBooking().getBookingTickets());
            }
            return invoices;
        }
        return null;
    }
    
    public List<InvoiceEntity> getInvoices(){
        List<InvoiceEntity> invoices = (List<InvoiceEntity>) invoiceRepository.findAll();
        if (!invoices.isEmpty()) {
            return invoices;
        }
        return new ArrayList<>();
    }

    // search payment
    @Transactional
    public Page<InvoiceEntity> searchInvoiceByAccountBankingNameAndEmail(String searchValue, int currentPage, int pagesize, Sort sort) {
        Page<InvoiceEntity> invoices = invoiceRepository.searchInvoicesByAccountBankingNameAndAccountBankingEmail(searchValue, searchValue,PageRequest.of(currentPage, pagesize, sort));
        if (!invoices.isEmpty()) {
            for(InvoiceEntity i: invoices){
                Hibernate.initialize(i.getBooking().getBookingSeats());
                Hibernate.initialize(i.getBooking().getBookingFoods());
                Hibernate.initialize(i.getBooking().getBookingTickets());
            }
            return invoices;
        }
        return null;
    }
    
    public void deleteInvoice(long id){
        invoiceRepository.deleteById(id);
    }
    
    public List<InvoiceEntity> findByInvoiceByDate(String paymentMonth){
        List<InvoiceEntity> invoices = invoiceRepository.findInvoiceByDate(paymentMonth);
        if(!invoices.isEmpty()){
            return invoices;
        }
        return new ArrayList<>();
    }
    
    @Transactional
    public InvoiceEntity findByInvoiceID(long id){
        Optional<InvoiceEntity> invoiceOpt = invoiceRepository.findById(id);
        if(invoiceOpt.isPresent() && !invoiceOpt.isEmpty()){
            Hibernate.initialize(invoiceOpt.get().getBooking().getBookingSeats());
            return invoiceOpt.get();
        }
        return new InvoiceEntity();
    }

}
