/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.entities;

import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import java.util.Date;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;
import javax.validation.Valid;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author tanhegemony
 */
@Entity
@Table(name = "movies")
public class MovieEntity {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    
    private int viewedNumber;
    
    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<ViewedMovieEntity> viewedMovies;

    public List<ViewedMovieEntity> getViewedMovies() {
        return viewedMovies;
    }

    public void setViewedMovies(List<ViewedMovieEntity> viewedMovies) {
        this.viewedMovies = viewedMovies;
    }

    public int getViewedNumber() {
        return viewedNumber;
    }

    public void setViewedNumber(int viewedNumber) {
        this.viewedNumber = viewedNumber;
    }
    
    @Transient
    private MultipartFile image;
    
    @Column(name = "image_movie")
    private String imageMovie;
    
    @Column(name = "name_by_english", unique = true, length = 255)
    @NotEmpty(message = "NameByEnglish is not empty!")
    private String nameByEnglish;
    
    @Column(name = "name_by_vietnam", unique = true, length = 255)
    @NotEmpty(message = "NameByVietNam is not empty!")
    private String nameByVietnam;
    
    @Column(length = 3)
    @Min(value = 0)
    private int duration;
    
    @Temporal(TemporalType.DATE)
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date premiere;
    
    @Column(length = 50)
    @NotEmpty(message = "Director is not empty!")
    private String director;
    
    @Column(length = 255)
    @NotEmpty(message = "Cast is not empty!")
    private String cast;
    
    @Column(length = 50)
    @NotEmpty(message = "Trailer is not empty!")
    private String trailer;
    
    @Column(length = 2000)
    @NotEmpty(message = "Description is not empty!")
    private String description;
    
    @Column(length = 50)
    @NotEmpty(message = "Nation is not empty!")
    private String nation;
    
    @Column(length = 50)
    @NotEmpty(message = "Producer is not empty!")
    private String producer;

    @Column(name = "film_item", length = 50)
    @Enumerated(EnumType.STRING)
    private FilmItem filmItem;

    @Transient
    private boolean checkExistCinemaMovies = false;

    public boolean isCheckExistCinemaMovies() {
        return checkExistCinemaMovies;
    }

    public void setCheckExistCinemaMovies(boolean checkExistCinemaMovies) {
        this.checkExistCinemaMovies = checkExistCinemaMovies;
    }
    
    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    @Valid
    private List<ReviewEntity> reviews;
    
    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    @Valid
    private List<CinemaMovieEntity> cinemaMovies;
    
    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<VoteMovieEntity> votesMovie;

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<BookingDetailEntity> bookingDetails;
    
     @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL)
    private List<MovieCategoryEntity> movieCategories;

    public List<BookingDetailEntity> getBookingDetails() {
        return bookingDetails;
    }

    public void setBookingDetails(List<BookingDetailEntity> bookingDetails) {
        this.bookingDetails = bookingDetails;
    }
    
    public List<VoteMovieEntity> getVotesMovie() {
        return votesMovie;
    }

    public void setVotesMovie(List<VoteMovieEntity> votesMovie) {
        this.votesMovie = votesMovie;
    }
    
    public List<CinemaMovieEntity> getCinemaMovies() {
        return cinemaMovies;
    }

    public void setCinemaMovies(List<CinemaMovieEntity> cinemaMovies) {
        this.cinemaMovies = cinemaMovies;
    }
    
    public List<ReviewEntity> getReviews() {
        return reviews;
    }

    public void setReviews(List<ReviewEntity> reviews) {
        this.reviews = reviews;
    }
    
    
    
    public FilmItem getFilmItem() {
        return filmItem;
    }

    public void setFilmItem(FilmItem filmItem) {
        this.filmItem = filmItem;
    }
    
    
    public String getNation() {
        return nation;
    }

    public void setNation(String nation) {
        this.nation = nation;
    }

    public String getProducer() {
        return producer;
    }

    public void setProducer(String producer) {
        this.producer = producer;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    
    
    
   

    public List<MovieCategoryEntity> getMovieCategories() {
        return movieCategories;
    }

    public void setMovieCategories(List<MovieCategoryEntity> movieCategories) {
        this.movieCategories = movieCategories;
    }
    
    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public MultipartFile getImage() {
        return image;
    }

    public void setImage(MultipartFile image) {
        this.image = image;
    }

    public String getImageMovie() {
        return imageMovie;
    }

    public void setImageMovie(String imageMovie) {
        this.imageMovie = imageMovie;
    }

    public String getNameByEnglish() {
        return nameByEnglish;
    }

    public void setNameByEnglish(String nameByEnglish) {
        this.nameByEnglish = nameByEnglish;
    }

    public String getNameByVietnam() {
        return nameByVietnam;
    }

    public void setNameByVietnam(String nameByVietnam) {
        this.nameByVietnam = nameByVietnam;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public Date getPremiere() {
        return premiere;
    }

    public void setPremiere(Date premiere) {
        this.premiere = premiere;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getCast() {
        return cast;
    }

    public void setCast(String cast) {
        this.cast = cast;
    }

 

    public String getTrailer() {
        return trailer;
    }

    public void setTrailer(String trailer) {
        this.trailer = trailer;
    }

    
    
}
