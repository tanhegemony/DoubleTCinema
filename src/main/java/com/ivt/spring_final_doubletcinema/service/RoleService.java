/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.RoleEntity;
import com.ivt.spring_final_doubletcinema.repository.RoleRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class RoleService {
    @Autowired
    private RoleRepository roleRepository;
    
    public List<RoleEntity> getRoles(){
        List<RoleEntity> roles = roleRepository.findAll();
        if(roles.size() > 0 && roles != null){
            return roles;
        }
        return new ArrayList<>();
    }
}
