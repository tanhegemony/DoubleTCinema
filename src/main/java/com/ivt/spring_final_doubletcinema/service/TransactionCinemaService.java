/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.TransactionCinemaEntity;
import com.ivt.spring_final_doubletcinema.repository.TransactionCinemaRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author ngoct
 */
@Service
public class TransactionCinemaService {
    
    @Autowired
    private TransactionCinemaRepository transactionCinemaRepository;
    
    public Page<TransactionCinemaEntity> getTransactionsCinemaPagination(int currentPage, int pageSize, Sort sort) {
        Page<TransactionCinemaEntity> transactionsCinema = transactionCinemaRepository.getTransactionsCinema(PageRequest.of(currentPage, pageSize, sort));
        if (!transactionsCinema.isEmpty()) {
            return transactionsCinema;
        }
        return null;
    }
    
    public Page<TransactionCinemaEntity> findTransactionsCinemaByCustomerPagination(String searchValue ,int currentPage, int pageSize, Sort sort) {
        Page<TransactionCinemaEntity> transactionsCinema = transactionCinemaRepository.findTransactionCinemaByCustomer("%"+searchValue+"%" , "%"+searchValue+"%", "%"+searchValue+"%", PageRequest.of(currentPage, pageSize, sort));
        if (!transactionsCinema.isEmpty()) {
            return transactionsCinema;
        }
        return null;
    }
    
    @Transactional
    public void saveTransactionCinema(TransactionCinemaEntity transactionCinema){
        transactionCinemaRepository.save(transactionCinema);
    }
    
}
