/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.service;

import com.ivt.spring_final_doubletcinema.entities.VoteMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.VoteReviewMovieEntity;
import com.ivt.spring_final_doubletcinema.repository.VoteReviewMovieRepository;
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
public class VoteReviewMovieService {
    @Autowired
    private VoteReviewMovieRepository voteReviewMovieRepository;
    
    public VoteReviewMovieEntity findVoteReviewMovieById(long voteReviewMovieId){
        Optional<VoteReviewMovieEntity> optVoteReviewMovie = voteReviewMovieRepository.findById(voteReviewMovieId);
        if(optVoteReviewMovie.isPresent() && optVoteReviewMovie.get().getId() > 0){
            return optVoteReviewMovie.get();
        }
        return new VoteReviewMovieEntity();
    }
    
    // handle avarage star
    public int averageStarVoteReview(long id){
        int starNumber = 0;
        double starReviewMovie = 0.0;
        List<VoteReviewMovieEntity> votesReview = getVotesReviewByReviewId(id);
        if(votesReview != null){
            for (VoteReviewMovieEntity voteReview : votesReview) {
                starNumber = starNumber + voteReview.getStarNumber();
            }
            if (starNumber != 0) {
                starReviewMovie = (double) starNumber / votesReview.size();
            }
            return  (int) Math.round(starReviewMovie);
        }
        return 0;
    }
    
    // find Vote review by date, account, review
    public VoteReviewMovieEntity findVoteReviewByDateAndAccountAndReview(String voteDate,long accountId, long reviewId){
        VoteReviewMovieEntity voteReview = voteReviewMovieRepository.findVoteReviewByDateAndAccountAndReview(
                voteDate,accountId,reviewId);
        if(voteReview != null){
            return voteReview;
        }
        return new VoteReviewMovieEntity();
    }
    
    public void saveVoteReviewMovie(VoteReviewMovieEntity voteReviewMovie){
        voteReviewMovieRepository.save(voteReviewMovie);
    }
    // get Vote review by reviewId
    public List<VoteReviewMovieEntity> getVotesReviewByReviewId(long id){
        List<VoteReviewMovieEntity> votesReview = (List<VoteReviewMovieEntity>) voteReviewMovieRepository.findByReviewId(id);
        if(votesReview.size() > 0 && votesReview != null){
            return votesReview;
        }
        return new ArrayList<>();
    }
    
    public Page<VoteReviewMovieEntity> getVotesReviewMoviePagination(int currentPage, int pageSize, Sort sort){
        Page<VoteReviewMovieEntity>  votesReviewMovie = voteReviewMovieRepository.findVotesReviewMovie(PageRequest.of(currentPage, pageSize, sort));
       if(!votesReviewMovie.isEmpty()){
           return votesReviewMovie;
       }
       return null;
        
        }
    
    public Page<VoteReviewMovieEntity> findVoteMoviesByReviewAndCustomerAndStarNumber(String searchValue, String starNumber,int currentPage, int pagesize, Sort sort ){
        Page<VoteReviewMovieEntity> votesReviewMovie = null;
        if(StringUtils.isNumeric(starNumber)){
            votesReviewMovie = voteReviewMovieRepository.findByStarNumber(starNumber,PageRequest.of(currentPage, pagesize, sort));
        }else{
            votesReviewMovie = voteReviewMovieRepository.findVoteReviewMoviesByReviewAndCustomer(searchValue,searchValue, PageRequest.of(currentPage, pagesize, sort));
        }
        if(!votesReviewMovie.isEmpty()){
            return votesReviewMovie;
        }
        return null;
    }
}
