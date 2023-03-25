/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.VoteMovieEntity;
import com.ivt.spring_final_doubletcinema.repository.VoteMovieRepository;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

/**
 *
 * @author tanhegemony
 */
@Service
public class VoteMovieService {
    @Autowired
    private VoteMovieRepository voteMovieRepository;
    
    public VoteMovieEntity findVoteMovieById(long voteMovieId){
        Optional<VoteMovieEntity> optVoteMovie = voteMovieRepository.findById(voteMovieId);
        if(optVoteMovie.isPresent() && optVoteMovie.get().getId() > 0){
            return optVoteMovie.get();
        }
        return new VoteMovieEntity();
    }
    
    public VoteMovieEntity findByAccountIdAndVoteDateStartingAndMovieId(long accountId, 
            String voteDate, long movieId){
        VoteMovieEntity voteMovie = voteMovieRepository.findVoteByAccountAndDateAndMovie(
                accountId, voteDate, movieId);
        if(voteMovie != null && voteMovie.getId() > 0){
            return voteMovie;
        }
        return new VoteMovieEntity();
    }
    
    public void saveVoteMovie(VoteMovieEntity voteMovie){
        voteMovieRepository.save(voteMovie);
    }
    
    public List<VoteMovieEntity> getListVoteByMovieId(long id){
        List<VoteMovieEntity> votes = voteMovieRepository.findByMovieId(id);
        if(votes != null && votes.size() > 0){
            return votes;
        }
        return new ArrayList<>();
    }
    
    public int averageStarVote(long id){
        int starNumber = 0;
        double starMovie = 0.0;
        List<VoteMovieEntity> votes = getListVoteByMovieId(id);
        if(votes != null){
            for (VoteMovieEntity vote : votes) {
                starNumber = starNumber + vote.getStarNumber();
            }
            if (starNumber != 0) {
                starMovie = (double) starNumber / votes.size();
            }
            return  (int) Math.round(starMovie);
        }
        return 0;
    }
    
    //admin
    public Page<VoteMovieEntity> getVotesPagination(int currentPage, int pageSize, Sort sort){
        Page<VoteMovieEntity>  votes = voteMovieRepository.findVotes(PageRequest.of(currentPage, pageSize, sort));
       if(!votes.isEmpty()){
           return votes;
       }
       return null;
        
        }
    
    public Page<VoteMovieEntity> findVoteMoviesByMovieAndCustomerAndStarNumber(String searchValue, String starNumber,int currentPage, int pagesize, Sort sort ){
        Page<VoteMovieEntity> votes = null;
        if(StringUtils.isNumeric(starNumber)){
            votes = voteMovieRepository.findVoteMoviesByStarNumber(starNumber, PageRequest.of(currentPage, pagesize, sort));
        }else{
            votes = voteMovieRepository.findVoteMoviesByMovieAndCustomer(searchValue,searchValue,PageRequest.of(currentPage, pagesize, sort));
        }
                
        if(!votes.isEmpty()){
            return votes;
            
        }
        return null;
    }
}
