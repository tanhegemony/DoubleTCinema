/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import com.ivt.spring_final_doubletcinema.enums.RoleAccount;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "roles")
public class RoleEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    @Column(name = "role_account")
    @Enumerated(EnumType.STRING)
    private RoleAccount roleAccount;
    
    @OneToMany(mappedBy = "role", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<RoleAccountEntity> rolesAccount;

    @Transient
    private boolean existRoleAccount = false;
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public RoleAccount getRoleAccount() {
        return roleAccount;
    }

    public void setRoleAccount(RoleAccount roleAccount) {
        this.roleAccount = roleAccount;
    }

    public List<RoleAccountEntity> getRolesAccount() {
        return rolesAccount;
    }

    public void setRolesAccount(List<RoleAccountEntity> rolesAccount) {
        this.rolesAccount = rolesAccount;
    }

    public boolean isExistRoleAccount() {
        return existRoleAccount;
    }

    public void setExistRoleAccount(boolean existRoleAccount) {
        this.existRoleAccount = existRoleAccount;
    }

    
    
    
}
