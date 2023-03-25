/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.repository;

import com.ivt.spring_final_doubletcinema.entities.VoteMovieEntity;
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
public interface VoteMovieRepository extends CrudRepository<VoteMovieEntity, Long> {

    // find vote by account and date and movie
    @Query(value = "select * from vote_movie where "
            + " accountId = ?1 and vote_date like ?2 and movieId = ?3", nativeQuery = true)
    VoteMovieEntity findVoteByAccountAndDateAndMovie(long accountId, String voteDate, long movieId);

    // show list vote by movie Id
    List<VoteMovieEntity> findByMovieId(long movieId);

    //admin
    @Query("SELECT vm FROM VoteMovieEntity vm")
    Page<VoteMovieEntity> findVotes(Pageable pageable);

    @Query(value = "SELECT * FROM vote_movie as vm " +
"             join movies as m " +
"             on vm.movieId = m.id " +
"             join accounts as a " +
"             on vm.accountId = a.id " +
"             join customer as c " +
"             on a.id = c.accountId " +
"            where m.name_by_english like ?1 or c.customer_name like ?2", nativeQuery = true)
    Page<VoteMovieEntity> findVoteMoviesByMovieAndCustomer(String nameByEnglish, String customerName, Pageable Pageable);
    
    @Query(value = "SELECT * FROM vote_movie " +
                    " where star_number = ?1", nativeQuery = true)
    Page<VoteMovieEntity> findVoteMoviesByStarNumber(String starNumber, Pageable Pageable);
}
