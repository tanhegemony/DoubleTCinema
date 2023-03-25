/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.configuration;

import com.ivt.spring_final_doubletcinema.service.UserDetailsServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.rememberme.InMemoryTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

/**
 *
 * @author tanhegemony
 */
@Configuration
@EnableWebSecurity
@ComponentScan(basePackages = {"com.ivt.spring_final_doubletcinema"})
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Autowired
    private UserDetailsServiceImpl userDetailsService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        BCryptPasswordEncoder bCryptPasswordEncoder = new BCryptPasswordEncoder();
        return bCryptPasswordEncoder;
    }

    @Autowired
    public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(passwordEncoder());
    }


    @Override
    protected void configure(HttpSecurity http) throws Exception {

        http.csrf().disable();
        http.authorizeRequests().antMatchers("/", "/login", "/logout", "/home").permitAll();

        http.authorizeRequests()
                .antMatchers("/booking","/booking_seat",
                        "/addVoteMovie",
                "/view_checkout","/checkout", "/applyPromotion",
                "/user/viewInvoice", "/user/invoice",
                "/manage_user", "/result_save_customer", "/updateAccountBySendEmail", "/viewBookingDetail/*", "/addAccountBanking", "/deleteAccountBanking",
                "/addVoteMovie",
                "/addVoteReviewMovie","/likeReviewMovie").access("hasAnyRole('ROLE_ADMIN,ROLE_USER,ROLE_MANAGER,ROLE_RECEPTIONIST')")
                
                .antMatchers("/admin/home", "/admin/", "/admin/changeYearPaymentChart/*").access("hasAnyRole('ROLE_ADMIN,ROLE_MANAGER,ROLE_RECEPTIONIST')")
                
                .antMatchers("/admin/accounts", "/admin/searchAccounts","/admin/addAccount","/admin/editAccount/*", "/admin/deleteAccount/*","/admin/resultSaveAccount").access("hasRole('ROLE_ADMIN')")
                
                .antMatchers("/admin/invoices","/admin/searchInvoices","/admin/viewBookingInvoice/*", "/admin/exportExcel","/admin/checkViewed/*", "/admin/buyFoods/*", "/admin/resultBuyFood", "/admin/deleteFoodInListBuy/*", "/admin/completeBuyFood", "/admin/resultCompleteBuyFood",
                        "/admin/bookings", "/admin/searchBookings", "/admin/deleteBooking/*","/admin/viewBookingDetail/*","/admin/viewInvoiceOfBooking/*",
                        "/admin/transactionsCinema","/admin/searchTransactionsCinema",
                        "/admin/customers","/admin/searchCustomers","/admin/viewBookingsOfCustomer/*", "/admin/editCustomer/*", "/admin/resultSaveCustomer", "/admin/deleteCustomer/*"
                ).access("hasAnyRole('ROLE_MANAGER, ROLE_RECEPTIONIST')")
                
                .antMatchers("/admin/accountsBanking","/admin/searchAccountsBanking", "/admin/deposit/*", "/admin/resultDeposit", "/admin/inforVerify", "/admin/resultInforVerify",
                        "/admin/categories", "/admin/searchCategories", "/admin/addCategory", "/admin/editCategory/*", "/admin/deleteCategory/*", "/admin/resultSaveCategory",  
                        "/admin/cinemaRooms","/admin/searchCinemaRooms","/admin/addCinemaRoom","/admin/editCinemaRoom/*", "/admin/deleteCinemaRoom/*", "/admin/resultSaveCinemaRoom", 
                        "/admin/cinemas", "/admin/searchCinemas", "/admin/addCinema", "/admin/editCinema/*", "/admin/resultSaveCinema", "/admin/deleteCinema/*", 
                        "/admin/cinemaMovies", "/admin/searchCinemaMovies", "/admin/addCinemaMovie", "/admin/editCinemaMovie/*","/admin/deleteCinemaMovie/*", "/admin/resultSaveCinemaMovie",  
                        "/admin/foods", "/admin/searchFoods", "/admin/addFood", "/admin/editFood/*","/admin/deleteFood/*", "/admin/resultSaveFood",  
                        "/admin/movies","/admin/searchMovies","/admin/addMovie","/admin/editMovie/*", "/admin/resultSaveMovie", "/admin/deleteMovie/*",
                        "/admin/promotions", "/admin/searchPromotions", "/admin/addPromotion", "/admin/editPromotion/*","/admin/deletePromotion/*", "/admin/resultSavePromotion", "/admin/viewBookingsOfPromotion/*",
                        "/admin/reviews", "/admin/searchReviews", "/admin/addReview", "/admin/editReview/*","/admin/deleteReview/*", "/admin/resultSaveReview",
                        "/admin/seats", "/admin/searchSeats", "/admin/addSeat", "/admin/editSeat/*","/admin/deleteSeat/*", "/admin/resultSaveSeat",
                        "/admin/tickets","/admin/searchTickets", "/admin/addTicket", "/admin/editTicket/*","/admin/deleteTicket/*", "/admin/resultSaveTicket",
                        "/admin/votes","/admin/searchVotes","/admin/displayVoteMovie/*",
                        "/admin/votesReviewMovie","/admin/searchVotesReviewMovie","/admin/displayVoteReviewMovie/*"
                    ).access("hasRole('ROLE_MANAGER')");

        http.authorizeRequests().and().exceptionHandling().accessDeniedPage("/403");

        http.authorizeRequests().and().formLogin()
                .loginProcessingUrl("/j_spring_security_check")
                .loginPage("/login")
                .defaultSuccessUrl("/home")
                .failureUrl("/login?error=true")
                .usernameParameter("email")
                .passwordParameter("password")
                .and().logout().logoutUrl("/logout?logoutStatus=true")
                .logoutSuccessUrl("/home").deleteCookies("JSESSIONID");
        
        http.authorizeRequests().and().rememberMe().rememberMeParameter("remember")
                .tokenRepository(this.persistentTokenRepository())
                .tokenValiditySeconds(24*60*60);
    }
    // Ta lưu tạm remember me trong memory (RAM).
    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        InMemoryTokenRepositoryImpl memory = new InMemoryTokenRepositoryImpl();
        return memory;
    }
    
}
