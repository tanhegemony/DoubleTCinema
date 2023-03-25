/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.AccountBankingEntity;
import com.ivt.spring_final_doubletcinema.repository.AccountBankingRepository;
import java.util.Optional;
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
public class AccountBankingService {

    @Autowired
    private AccountBankingRepository accountBankingRepository;

    
    public void deleteAccountBanking(long accountBankingid){
        accountBankingRepository.deleteAB(accountBankingid);
    }
    
    // find AB by email banking
    public AccountBankingEntity findByEmailBanking(String emailBanking) {
        AccountBankingEntity accountBanking = accountBankingRepository.findByEmailBanking(emailBanking);
        if (accountBanking != null && accountBanking.getId() > 0) {
            return accountBanking;
        }
        return new AccountBankingEntity();
    }

    // find AB by customer
    public AccountBankingEntity findByCustomerId(long customerId) {
        AccountBankingEntity accountBanking = accountBankingRepository.findByCustomerId(customerId);
        if (accountBanking != null && accountBanking.getId() > 0) {
            return accountBanking;
        }
        return new AccountBankingEntity();
    }

    @Transactional
    public void saveOrUpdateAccountBanking(AccountBankingEntity accountBanking) {
        accountBankingRepository.save(accountBanking);
    }

    // find AB by number and name and expiry date and cvv code
    public AccountBankingEntity findABByCardNumberAndCardNameAndMonthExpiryDateAndYearExpiryDateAndCVVCode(String cardNumber,
            String cardName, int monthExpiryDate, int yearExpiryDate, String cvvCode) {
        AccountBankingEntity accountBanking = accountBankingRepository.findByCardNumberAndCardNameAndMonthExpiryDateAndYearExpiryDateAndCvvCode(cardNumber, cardName, monthExpiryDate, yearExpiryDate, cvvCode);
        if (accountBanking != null) {
            return accountBanking;
        }
        return new AccountBankingEntity();
    }
    
    
    //admin
    // show list accounts banking
     public Page<AccountBankingEntity> getAccountBankingPagination(int currentPage, int pageSize, Sort sort){
        Page<AccountBankingEntity>  accountBankings = accountBankingRepository.findAccountsBanking(PageRequest.of(currentPage, pageSize, sort));
       if(!accountBankings.isEmpty()){
           return accountBankings;
       }
       return null;
        
        }
    // search account banking
    public Page<AccountBankingEntity> findByAccountBankingByName(String searchValue ,  int currentPage, int pagesize, Sort sort ){
        Page<AccountBankingEntity> accountBanking = accountBankingRepository.findAccountsBankingByNameAndEmail(searchValue,  searchValue, PageRequest.of(currentPage, pagesize, sort));
        if(!accountBanking.isEmpty()){
            return accountBanking;
            
        }
        return null;
    }
    
    public AccountBankingEntity findById(long id) {
        Optional<AccountBankingEntity> acBankingOpt = accountBankingRepository.findById(id);

        if (acBankingOpt != null && acBankingOpt.isPresent()) {
            return acBankingOpt.get();
        }
        return new AccountBankingEntity();
    }
}
