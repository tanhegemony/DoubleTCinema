/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.ivt.spring_final_doubletcinema.controller.admin;

import com.ivt.spring_final_doubletcinema.entities.AccountEntity;
import com.ivt.spring_final_doubletcinema.entities.CategoryEntity;
import com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieCategoryEntity;
import com.ivt.spring_final_doubletcinema.entities.MovieEntity;
import com.ivt.spring_final_doubletcinema.enums.FilmItem;
import com.ivt.spring_final_doubletcinema.service.AccountService;
import com.ivt.spring_final_doubletcinema.service.CategoryService;
import com.ivt.spring_final_doubletcinema.service.CinemaMovieService;
import com.ivt.spring_final_doubletcinema.service.MovieCategoriesService;
import com.ivt.spring_final_doubletcinema.service.MovieService;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Optional;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Sort;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

/**
 *
 * @author ngoct
 */
@Controller
@RequestMapping("/admin/")
public class ManageMovieController {

    @Autowired
    private MovieService movieService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private AccountService accountService;

    @Autowired
    private CinemaMovieService cinemaMovieService;

    @Autowired
    private MovieCategoriesService movieCategoriesService;

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public AccountEntity getAccountByUserLogin(Model model) {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String customerEmail = principal.toString();
        if (principal instanceof UserDetails) {
            customerEmail = ((UserDetails) principal).getUsername();
        }
        AccountEntity account = accountService.findByCustomerEmail(customerEmail);
        model.addAttribute("accountLogin", account);
        return account;
    }

    public List<MovieEntity> checkExistCinemaMovies(Page<MovieEntity> movies) {
        List<MovieEntity> movieList = new ArrayList<>();
        for (MovieEntity m : movies) {
            List<CinemaMovieEntity> cinemaMovies = cinemaMovieService.findByMovieId(m.getId());
            if (cinemaMovies.size() > 0) {
                m.setCheckExistCinemaMovies(true);
                movieList.add(m);
            } else {
                m.setCheckExistCinemaMovies(false);
                movieList.add(m);
            }
        }
        return movieList;
    }

    @RequestMapping("/movies")
    public String viewMovie(
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        model.addAttribute("action", "movies");
        AccountEntity accountLogin = getAccountByUserLogin(model);
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);

        Page<MovieEntity> movies = movieService.getMoviePagination(currentPage - 1, pageSize, Sort.by("filmItem").ascending().and(Sort.by("id").descending()));
        if (movies != null) {
            List<MovieEntity> movieList = checkExistCinemaMovies(movies);
            int totalPages = movies.getTotalPages();
            model.addAttribute("currentPage", currentPage);
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("pageSize", pageSize);
            model.addAttribute("movies", movieList);
        }
        return "/admin/movie";
    }

    @RequestMapping(value = "searchMovies", method = RequestMethod.GET)
    public String searchMovie(
            @RequestParam(value = "searchValue", required = false) String searchValue,
            @RequestParam(name = "page", required = false) Optional<Integer> page,
            @RequestParam(name = "size", required = false) Optional<Integer> size,
            Model model) {
        model.addAttribute("action", "search_movies");
        AccountEntity accountLogin = getAccountByUserLogin(model);
        int currentPage = page.orElse(1);
        int pageSize = size.orElse(5);
        Page<MovieEntity> movies = null;
        if (searchValue.equals("")) {
            movies = movieService.getMoviePagination(currentPage - 1, pageSize, Sort.by("filmItem").ascending().and(Sort.by("id").descending()));
        } else {
            movies = movieService.findByMovieName("%" + searchValue + "%", currentPage - 1, pageSize, Sort.by("film_item").ascending().and(Sort.by("id").descending()));
        }
        if (movies != null) {
            List<MovieEntity> movieList = checkExistCinemaMovies(movies);
            int totalPages = movies.getTotalPages();
            model.addAttribute("totalPages", totalPages);
            model.addAttribute("movies", movieList);

        }
        model.addAttribute("searchValue", searchValue);
        model.addAttribute("pageSize", pageSize);
        model.addAttribute("currentPage", currentPage);
        return "/admin/movie";
    }

    @RequestMapping("addMovie")
    public String addMovie(
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        model.addAttribute("action", "add_movie");
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("currentDate", sdf.format(new Date()));
        model.addAttribute("filmItems", FilmItem.values());
        return "/admin/form/form_movie";
    }

    @RequestMapping("editMovie/{id}")
    public String updateMovie(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        MovieEntity movie = movieService.findByMovieId(id);
        if (movie.getId() > 0) {
            model.addAttribute("action", "update_movie");
            model.addAttribute("premiere", sdf.format(movie.getPremiere()));
        } else {
            model.addAttribute("action", "add_movie");
        }
        model.addAttribute("categories", categoryService.getCategories());
        model.addAttribute("movie", movie);
        model.addAttribute("currentDate", sdf.format(new Date()));
        model.addAttribute("filmItems", FilmItem.values());
        return "/admin/form/form_movie";
    }

    @RequestMapping(value = "/resultSaveMovie", method = RequestMethod.POST)
    public String saveOrUpdateMovie(
            @Valid @ModelAttribute("movie") MovieEntity movie,
            BindingResult result,
            @RequestParam(value = "movieCategs", required = false) String[] movieCategs,
            Model model) throws IOException {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        if (result.hasErrors()) {
            if (result.hasFieldErrors("duration")) {
                model.addAttribute("messageDuration", "Duration must be greater than or equal to 0!");
            }
            if (movie.getId() > 0) {
                model.addAttribute("action", "update_movie");
                model.addAttribute("movie", movie);
                model.addAttribute("premiere", sdf.format(movie.getPremiere()));
            } else {
                model.addAttribute("action", "add_movie");
            }
            model.addAttribute("categories", categoryService.getCategories());
            model.addAttribute("currentDate", sdf.format(new Date()));
            model.addAttribute("filmItems", FilmItem.values());
            return "/admin/form/form_movie";
        } else {
            MultipartFile file = movie.getImage();
            URL location = ManageAccountBankingController.class.getProtectionDomain().getCodeSource().getLocation();
            String saveDirectory = location.getFile().substring(1, location.getPath().lastIndexOf("WEB-INF")) + "/resources/images/movies/";
            if (movie.getFilmItem().equals(FilmItem.PHIM_DANG_CHIEU)) {
                saveDirectory = saveDirectory.concat("coming");
            } else {
                saveDirectory = saveDirectory.concat("coming soon");
            }
            Path path = Paths.get(saveDirectory);
            if (!Files.exists(path)) {
                Files.createDirectory(path);
            }
            String filename = file.getOriginalFilename();

            if (movie.getId() > 0) {
                if (movie.getDuration() > 999) {
                    model.addAttribute("messageDuration", "MovieDuration must be 3 digits!");
                    model.addAttribute("currentDate", sdf.format(new Date()));
                    model.addAttribute("action", "update_movie");
                    model.addAttribute("filmItems", FilmItem.values());
                    model.addAttribute("categories", categoryService.getCategories());
                    return "/admin/form/form_movie";
                } else {
                    if (filename == "" && movie.getImageMovie() != null) {
                        filename = movie.getImageMovie();
                    }
                    File filePath = new File(path + "\\" + filename);
                    if (filename != null && !filePath.exists()) {
                        file.transferTo(filePath);
                    }
                    if (movieCategs == null) {
                        model.addAttribute("messageCategory", "Please Select Category!");
                        model.addAttribute("currentDate", sdf.format(new Date()));
                        model.addAttribute("action", "update_movie");
                        model.addAttribute("filmItems", FilmItem.values());
                        model.addAttribute("categories", categoryService.getCategories());
                        model.addAttribute("movieCategs", movieCategs);
                        return "/admin/form/form_movie";
                    } else{
                        MovieEntity findMovie = movieService.findByMovieId(movie.getId());
                        if(findMovie.getId() > 0){
                            movieCategoriesService.deleteMovieCategories(findMovie.getMovieCategories());
                        }
                        List<MovieCategoryEntity> listMovieCategories = new ArrayList<>();
                        for (int i = 0; i < movieCategs.length; i++) {
                            MovieCategoryEntity movieCategory = new MovieCategoryEntity();
                            CategoryEntity category = new CategoryEntity();
                            category.setId(Long.parseLong(movieCategs[i]));
                            movieCategory.setCategory(category);
                            movieCategory.setMovie(movie);
                            listMovieCategories.add(movieCategory);
                        }
                        movie.setMovieCategories(listMovieCategories);
                    }

                    movie.setImageMovie(filename);
                    movie.setViewedNumber(0);
                    movieService.saveOrUpdateMovie(movie);
                }
            } else {
                if (movieCategs == null) {
                    model.addAttribute("messageCategory", "Please Select Category!");
                    model.addAttribute("currentDate", sdf.format(new Date()));
                    model.addAttribute("action", "add_movie");
                    model.addAttribute("filmItems", FilmItem.values());
                    model.addAttribute("categories", categoryService.getCategories());
                    model.addAttribute("movieCategs", movieCategs);
                    return "/admin/form/form_movie";
                } else {
                    if (movie.getDuration() > 999) {
                        model.addAttribute("messageDuration", "MovieDuration must be 3 digits!");
                        model.addAttribute("currentDate", sdf.format(new Date()));
                        model.addAttribute("action", "add_movie");
                        model.addAttribute("filmItems", FilmItem.values());
                        model.addAttribute("categories", categoryService.getCategories());
                        return "/admin/form/form_movie";
                    } else {
                        MovieEntity findMovieE = movieService.findByNameByEnglish(movie.getNameByEnglish());
                        if (findMovieE.getId() > 0) {
                            model.addAttribute("messageNameByEnglish", "MovieNameByEnglish is existed!");
                            model.addAttribute("currentDate", sdf.format(new Date()));
                            model.addAttribute("action", "add_movie");
                            model.addAttribute("filmItems", FilmItem.values());
                            model.addAttribute("categories", categoryService.getCategories());
                            return "/admin/form/form_movie";
                        } else {
                            MovieEntity findMovieV = movieService.findByNameVietnam(movie.getNameByVietnam());
                            if (findMovieV != null && findMovieV.getId() > 0) {
                                model.addAttribute("messageNameByVietnam", "MovieNameByVietnam is existed!");
                                model.addAttribute("currentDate", sdf.format(new Date()));
                                model.addAttribute("action", "add_movie");
                                model.addAttribute("filmItems", FilmItem.values());
                                model.addAttribute("categories", categoryService.getCategories());
                                return "/admin/form/form_movie";
                            } else {
                                if (filename == "") {
                                    filename = "no_image_movie.png";
                                }
                                File filePath = new File(path + "\\" + filename);
                                if (filename != null && !filePath.exists() && filename != "") {
                                    file.transferTo(filePath);
                                }
                                movie.setImageMovie(filename);

                                List<MovieCategoryEntity> listMovieCategories = new ArrayList<>();
                                for (int i = 0; i < movieCategs.length; i++) {
                                    MovieCategoryEntity movieCategory = new MovieCategoryEntity();
                                    CategoryEntity category = new CategoryEntity();
                                    category.setId(Long.parseLong(movieCategs[i]));
                                    movieCategory.setCategory(category);
                                    movieCategory.setMovie(movie);
                                    listMovieCategories.add(movieCategory);
                                }
                                movie.setMovieCategories(listMovieCategories);
                                movieService.saveOrUpdateMovie(movie);
                            }
                        }
                    }
                }
            }
            return "redirect:/admin/movies";
        }
    }

    @RequestMapping("deleteMovie/{id}")
    public String deleteMovie(
            @PathVariable("id") long id,
            Model model) {
        AccountEntity accountLogin = getAccountByUserLogin(model);
        movieService.deleteMovie(id);
        return "redirect:/admin/movies";
    }
}
