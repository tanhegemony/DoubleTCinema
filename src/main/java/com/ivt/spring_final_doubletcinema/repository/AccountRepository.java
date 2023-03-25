/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
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
public interface AccountRepository extends CrudRepository<AccountEntity, Long> {

    AccountEntity findByCustomerCustomerEmailLikeAndIsLock(String customerEmail,
            boolean isLock);

    AccountEntity findByCustomerCustomerEmail(String customerEmail);
    
    AccountEntity findByCustomerCustomerPhone(String customerPhone);

    //admin
    @Query("SELECT a FROM AccountEntity a")
    Page<AccountEntity> findAccounts(Pageable Pageable);

    
    // search accounts
    @Query(value = "SELECT * FROM accounts as a "
            + " join role_account as rl "
            + " on a.id = rl.accountId "
            + " join roles as r "
            + " on r.id = rl.roleId "
            + " join customer as c "
            + " on c.accountId = a.id"
            + " where c.customer_name like ?1 or c.customer_email like ?2 "
            + " or c.customer_phone like ?3 or r.role_account like ?4 "
            + " group by c.customer_email", nativeQuery = true)
    Page<AccountEntity> searchAccounts(String customerName,String customerEmail, String customerPhone,String role, Pageable Pageable);
    
    @Query(value = "SELECT * FROM accounts where create_date like ?1", nativeQuery = true)
   List<AccountEntity> findAccountByCreateDate(String AccountThis);
}
