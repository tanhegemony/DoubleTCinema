/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.RoleAccountEntity;
import com.ivt.spring_final_doubletcinema.repository.RoleAccountRepository;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class RoleAccountService {
    @Autowired
    private RoleAccountRepository roleAccountRepository;
    
    // admin
    public void deleteRoleAccount(List<RoleAccountEntity> rolesAccount){
        roleAccountRepository.deleteAll(rolesAccount);
    }
}
