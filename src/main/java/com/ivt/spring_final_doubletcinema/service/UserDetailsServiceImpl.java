/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.RoleEntity;
import com.ivt.spring_final_doubletcinema.repository.AccountRepository;
import com.ivt.spring_final_doubletcinema.repository.RoleRepository;
import java.util.HashSet;
import java.util.Set;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.util.CollectionUtils;

/**
 *
 * @author tanhegemony
 */
@Service
public class UserDetailsServiceImpl implements UserDetailsService{
    
    @Autowired
    HttpSession session;
    
    @Autowired
    private AccountRepository userRepository;

    @Autowired
    private RoleRepository userRoleRepository;

    @Override
    public UserDetails loadUserByUsername(String customerEmail) throws UsernameNotFoundException {
        AccountEntity account = userRepository.findByCustomerCustomerEmailLikeAndIsLock(
                customerEmail, Boolean.FALSE);
        if (account == null) {
            throw new UsernameNotFoundException(customerEmail);
        }
        
        Set<RoleEntity> roleNames = userRoleRepository.findRolesByEmail(customerEmail);
        Set<GrantedAuthority> grantList = new HashSet<>();
        if (!CollectionUtils.isEmpty(roleNames)) {
            for (RoleEntity role : roleNames) {
                GrantedAuthority authority = new SimpleGrantedAuthority(role.getRoleAccount().toString());
                grantList.add(authority);
            }
        }
        return (UserDetails) new User(account.getCustomer().getCustomerEmail(),account.getPassword(), grantList);
    }
}
