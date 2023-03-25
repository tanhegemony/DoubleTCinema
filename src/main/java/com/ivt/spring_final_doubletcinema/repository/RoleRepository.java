/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.RoleEntity;
import java.util.Set;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author tanhegemony
 */
@Repository
public interface RoleRepository extends JpaRepository<RoleEntity, Long> {

    @Query(value = "select * from roles as r \n"
            + " join role_account as ra \n"
            + " on r.id = ra.roleId \n"
            + " join accounts as a \n"
            + " on ra.accountId = a.id \n"
            + " join customer as c\n"
            + " on c.accountId = a.id\n"
            + " where c.customer_email = ?1", nativeQuery = true)
    Set<RoleEntity> findRolesByEmail(String customerEmail);
}
