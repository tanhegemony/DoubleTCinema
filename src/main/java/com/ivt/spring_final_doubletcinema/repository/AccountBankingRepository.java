/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.AccountBankingEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface AccountBankingRepository extends CrudRepository<AccountBankingEntity, Long>{
    
    @Transactional
    @Modifying
    @Query("DELETE FROM AccountBankingEntity ab WHERE ab.id = ?1")
    void deleteAB(long id);
    
    // find AB by email banking
    AccountBankingEntity findByEmailBanking(String emailBanking);
    
    // find AB by customer
    AccountBankingEntity findByCustomerId(long customerId);
    
    // find AB by number and name and expiry date and cvv code
    AccountBankingEntity findByCardNumberAndCardNameAndMonthExpiryDateAndYearExpiryDateAndCvvCode(String cardNumber,
            String cardName, int monthExpiryDate, int yearExpiryDate, String cvvCode);
    
    
    
    
    // admin
    
    // show list accounts banking
    @Query("SELECT a FROM AccountBankingEntity a")
    Page<AccountBankingEntity> findAccountsBanking(Pageable pageable);
    
    // search accounts banking
    @Query(value = "SELECT * FROM accountbanking where card_name like ?1 or email_banking like ?2" , nativeQuery = true)
    Page<AccountBankingEntity> findAccountsBankingByNameAndEmail(String cardName , String emailBanking, Pageable Pageable);
}
