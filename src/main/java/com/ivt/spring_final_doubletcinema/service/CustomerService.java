/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.CustomerEntity;
import com.ivt.spring_final_doubletcinema.repository.CustomerRepository;
import java.util.Date;
import java.util.Optional;
import org.hibernate.Hibernate;
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
public class CustomerService {
    @Autowired
    private CustomerRepository customerRepository;
    
    public CustomerEntity findCustomerById(long customerId){
        Optional<CustomerEntity> customerOpt = customerRepository.findById(customerId);
        if(customerOpt.isPresent() && customerOpt.get().getId() > 0){
            return customerOpt.get();
        }
        return new CustomerEntity();
    }
    
    
    public void saveOrUpdateCustomer(CustomerEntity customer){
        customerRepository.save(customer);
    }
    
    // find by email but not id displaying
    public CustomerEntity findCustomerByCustomerEmailAndIdNot(String customerEmail, long customerId){
        CustomerEntity customer = customerRepository.findByCustomerEmailAndIdNot(customerEmail, customerId);
        if(customer != null && customer.getId() > 0){
            return customer;
        }
        return new CustomerEntity();
    }
    
    // find by phone but not id displaying
    public CustomerEntity findCustomerByCustomerPhoneAndIdNot(String customerPhone, long customerId){
        CustomerEntity customer = customerRepository.findByCustomerPhoneAndIdNot(customerPhone, customerId);
        if(customer != null && customer.getId() > 0){
            return customer;
        }
        return new CustomerEntity();
    }
    
    
    // find by email
    public CustomerEntity findCustomerByCustomerEmail(String customerEmail){
        CustomerEntity customer = customerRepository.findByCustomerEmail(customerEmail);
        if(customer != null && customer.getId() > 0){
            return customer;
        }
        return new CustomerEntity();
    }
    // find by phone
    public CustomerEntity findCustomerByCustomerPhone(String customerPhone){
        CustomerEntity customer = customerRepository.findByCustomerPhone(customerPhone);
        if(customer != null && customer.getId() > 0){
            return customer;
        }
        return new CustomerEntity();
    }
    // find by accountId
    public CustomerEntity findCustomerByAccountId(long accountId){
        CustomerEntity customer = customerRepository.findByAccountId(accountId);
        if(customer != null && customer.getId() > 0){
            return customer;
        }
        return new CustomerEntity();
    }
    
    //admin
    // search customer
    @Transactional
    public Page<CustomerEntity> searchCustomerPagination(String searchValue, int currentPage, int pageSize, Sort sort) {
        Page<CustomerEntity> customers = customerRepository.findCustomerByNameOrEmailOrPhone(searchValue, searchValue, searchValue, PageRequest.of(currentPage, pageSize, sort));
        if (!customers.isEmpty()) {
            for(CustomerEntity customer: customers){
                Hibernate.initialize(customer.getBookings());
            }
            return customers;
        }
        return null;

    }

    // show list customers have page
    @Transactional
    public Page<CustomerEntity> getCustomerPagination(int currentPage, int pageSize, Sort sort) {
        Page<CustomerEntity> customers = customerRepository.findCustomser(PageRequest.of(currentPage, pageSize, sort));
        if (!customers.isEmpty()) {
            for(CustomerEntity customer: customers){
                Hibernate.initialize(customer.getBookings());
            }
            return customers;
        }
        return null;

    }
    
    public void deleteCustomer(long id){
        customerRepository.deleteById(id);
    }
}
