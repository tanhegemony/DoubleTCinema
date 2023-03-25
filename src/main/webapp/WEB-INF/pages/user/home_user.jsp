
<%-- 
    Document   : home
    Created on : Jul 23, 2022, 5:14:02 PM
    Author     : tanhegemony
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <!-- Bootstrap CSS -->
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/home_user.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/home_user_responsive.css" />"/>


    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container-fluid content">
            <div class="row content1 mt-2">
                <div class="col-3">
                    <h5>Tìm kiếm vé nhanh</h5>
                    <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist" aria-orientation="vertical">
                        <li class="nav-item " role="presentation">
                            <form action="home" method="get" >
                                <input type="hidden" name="contentNav" value="filmFollow">
                                <button  class="nav-link
                                         <c:if test="${contentNav == 'filmFollow' || contentNav == ''}">active</c:if>" id="filmFollow-tab" onclick="location.href = '${pageContext.request.contextPath}/home#filmFollow'"
                                             role="tab" aria-controls="filmFollow" aria-selected="true" 
                                         <c:if test="${contentNav == 'filmFollow' || contentNav == ''}">
                                             disabled
                                         </c:if>>Theo phim</button>
                            </form>

                        </li>
                        <li class="nav-item " role="presentation">
                            <form action="home" method="get" >
                                <input type="hidden" name="contentNav" value="dayFollow">
                                <button class="nav-link
                                        <c:if test="${contentNav == 'dayFollow'}">active</c:if>
                                        " id="dayFollow-tab" onclick="location.href = '${pageContext.request.contextPath}/home#dayFollow'" 
                                        role="tab" aria-controls="dayFollow" aria-selected="false" <c:if test="${contentNav == 'dayFollow'}">disabled</c:if>>Theo ngày</button>
                                </form>

                            </li>
                            <li class="nav-item " role="presentation">
                                <form action="home" method="get" >
                                    <input type="hidden" name="contentNav" value="cinemaFollow">
                                    <button class="nav-link <c:if test="${contentNav == 'cinemaFollow'}">active</c:if>" id="cinemaFollow-tab" onclick="location.href = '${pageContext.request.contextPath}/home#cinemaFollow'"
                                        role="tab" aria-controls="cinemaFollow" aria-selected="false" <c:if test="${contentNav == 'cinemaFollow'}">disabled</c:if>>Theo rạp</button>
                                </form>

                            </li>
                        </ul>
                        <div class="tab-content" id="myTabContent">
                            <div class="tab-pane fade <c:if test="${contentNav == 'filmFollow' || contentNav == ''}">show active</c:if> mt-2 ml-2 mr-2" id="filmFollow" role="tabpanel"
                                 aria-labelledby="filmFollow-tab">
                            <mvc:form action="saveInfoSearchInSession" method="post">
                                <input type="hidden" name="contentNav" value="filmFollow">
                                <div class="form-group">
                                    <select class="form-control" name="movieIdFilmFollow" onchange="this.form.submit()">
                                        <option value="">Chọn phim</option>
                                        <c:forEach var="mv" items="${searchFastTicketMovies}">
                                            <c:if test="${sessionScope.movieIdFilmFollow == mv.id}">
                                                <option title="${mv.nameByEnglish}" value="${mv.id}" selected>${mv.nameByEnglish}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.movieIdFilmFollow != mv.id}">
                                                <option title="${mv.nameByEnglish}" value="${mv.id}">${mv.nameByEnglish}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="cinemaIdFilmFollow" onchange="this.form.submit()">
                                        <option value="">Chọn rạp</option>
                                        <c:if test="${sessionScope.movieIdFilmFollow != null && sessionScope.movieIdFilmFollow != ''}">
                                            <c:forEach var="cinema" items="${cinemas}">
                                                <c:if test="${sessionScope.cinemaIdFilmFollow == cinema.id}">
                                                    <option value="${cinema.id}" selected>${cinema.nameCinema}</option>
                                                </c:if>
                                                <c:if test="${sessionScope.cinemaIdFilmFollow !=cinema.id}">
                                                    <option value="${cinema.id}">${cinema.nameCinema}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <input type="date" name="showDateFilmFollow" onchange="this.form.submit()" class="form-control showDate" min="${startDate}" 
                                           max="${endDate}"
                                           <c:if test="${sessionScope.showDateFilmFollow != null}">value="${sessionScope.showDateFilmFollow}"</c:if>  
                                           <c:if test="${sessionScope.showDateFilmFollow == null}">value="${startDate}"</c:if>>
                                    </div>
                                    <div class="form-group">
                                        <select class="form-control" name="showTimeFilmFollow" onchange="this.form.submit()">
                                            <option value="">Chọn suất</option>
                                        <c:forEach var="cmt" items="${cinemaMovies}">
                                            <c:if test="${sessionScope.showTimeFilmFollow == cmt.showTime}">
                                                <option value="${cmt.showTime}" selected>${cmt.showTime}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.showTimeFilmFollow != cmt.showTime}">
                                                <option value="${cmt.showTime}">${cmt.showTime}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="text-right">
                                    <a <c:if test="${sessionScope.movieIdFilmFollow == '' || 
                                                     sessionScope.cinemaIdFilmFollow == '' || 
                                                     sessionScope.showDateFilmFollow == '' || 
                                                     sessionScope.showTimeFilmFollow == ''}">
                                              onclick="return confirm('Bạn chưa chọn suất chiếu?')"
                                          </c:if> 
                                          <c:if test="${sessionScope.movieIdFilmFollow != '' && 
                                                        sessionScope.cinemaIdFilmFollow != '' && 
                                                        sessionScope.showDateFilmFollow != '' && 
                                                        sessionScope.showTimeFilmFollow != ''}">
                                                href="${pageContext.request.contextPath}/booking?movieId=${sessionScope.movieIdFilmFollow}&cinemaId=${sessionScope.cinemaIdFilmFollow}&showDate=${sessionScope.showDateFilmFollow}&showTime=${sessionScope.showTimeFilmFollow}"
                                          </c:if>  
                                          class="btn mr-2 mb-2"> <i class="fas fa-money-check-alt"></i> Mua
                                        vé</a>
                                </div>
                            </mvc:form>
                        </div>
                        <div class="tab-pane fade <c:if test="${contentNav == 'dayFollow'}">show active</c:if> fade mt-2 ml-2 mr-2" id="dayFollow" role="tabpanel"
                             aria-labelledby="dayFollow-tab">
                            <mvc:form action="saveInfoSearchInSession" method="post">
                                <input type="hidden" name="contentNav" value="dayFollow">
                                <div class="form-group">
                                    <input type="date" name="showDateDayFollow" onchange="this.form.submit()" class="form-control showDate" min="${startDate}" 
                                           max="${endDate}"
                                           <c:if test="${sessionScope.showDateDayFollow != null}">value="${sessionScope.showDateDayFollow}"</c:if>  
                                           <c:if test="${sessionScope.showDateDayFollow == null}">value="${startDate}"</c:if>>
                                    </div>
                                    <div class="form-group">
                                        <select class="form-control" name="cinemaIdDayFollow" onchange="this.form.submit()">
                                            <option value="">Chọn rạp</option>
                                        <c:forEach var="cinema" items="${cinemas}">
                                            <c:if test="${sessionScope.cinemaIdDayFollow == cinema.id}">
                                                <option value="${cinema.id}" selected>${cinema.nameCinema}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.cinemaIdDayFollow !=cinema.id}">
                                                <option value="${cinema.id}">${cinema.nameCinema}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="movieIdDayFollow" onchange="this.form.submit()">
                                        <option value="">Chọn phim</option>
                                        <c:if test="${sessionScope.cinemaIdDayFollow != null && sessionScope.cinemaIdDayFollow != ''}">
                                            <c:forEach var="mv" items="${movies}">
                                                <c:if test="${sessionScope.movieIdDayFollow == mv.id}">
                                                    <option value="${mv.id}" selected>${mv.nameByVietnam}</option>
                                                </c:if>
                                                <c:if test="${sessionScope.movieIdDayFollow != mv.id}">
                                                    <option value="${mv.id}">${mv.nameByVietnam}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>

                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="showTimeDayFollow" onchange="this.form.submit()">
                                        <option value="">Chọn suất</option>
                                        <c:forEach var="cmt" items="${cinemaMovies}">
                                            <c:if test="${sessionScope.showTimeDayFollow == cmt.showTime}">
                                                <option value="${cmt.showTime}" selected>${cmt.showTime}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.showTimeDayFollow != cmt.showTime}">
                                                <option value="${cmt.showTime}">${cmt.showTime}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="text-right">
                                    <a <c:if test="${sessionScope.movieIdDayFollow == '' || 
                                                     sessionScope.cinemaIdDayFollow == '' || 
                                                     sessionScope.showDateDayFollow == '' || 
                                                     sessionScope.showTimeDayFollow == ''}">
                                              onclick="return confirm('Bạn chưa chọn suất chiếu?')"
                                          </c:if> 
                                          <c:if test="${sessionScope.movieIdDayFollow != '' && 
                                                        sessionScope.cinemaIdDayFollow != '' && 
                                                        sessionScope.showDateDayFollow != '' && 
                                                        sessionScope.showTimeDayFollow != ''}">
                                                href="${pageContext.request.contextPath}/booking?movieId=${sessionScope.movieIdDayFollow}&cinemaId=${sessionScope.cinemaIdDayFollow}&showDate=${sessionScope.showDateDayFollow}&showTime=${sessionScope.showTimeDayFollow}"
                                          </c:if>  
                                          class="btn mr-2 mb-2"> <i class="fas fa-money-check-alt"></i> Mua
                                        vé</a>
                                </div>
                            </mvc:form>
                        </div>
                        <div class="tab-pane fade <c:if test="${contentNav == 'cinemaFollow'}">show active</c:if> mt-2 ml-2 mr-2" id="cinemaFollow" role="tabpanel"
                             aria-labelledby="cinemaFollow-tab">
                            <mvc:form action="saveInfoSearchInSession" method="post">
                                <input type="hidden" name="contentNav" value="cinemaFollow">
                                <div class="form-group">
                                    <select class="form-control" name="cinemaIdCinemaFollow" onchange="this.form.submit()">
                                        <option value="">Chọn rạp</option>
                                        <c:forEach var="cinema" items="${cinemas}">
                                            <c:if test="${sessionScope.cinemaIdCinemaFollow == cinema.id}">
                                                <option value="${cinema.id}" selected>${cinema.nameCinema}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.cinemaIdCinemaFollow !=cinema.id}">
                                                <option value="${cinema.id}">${cinema.nameCinema}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <select class="form-control" name="movieIdCinemaFollow" onchange="this.form.submit()">
                                        <option value="">Chọn phim</option>
                                        <c:if test="${sessionScope.cinemaIdCinemaFollow != null && sessionScope.cinemaIdCinemaFollow != ''}">
                                            <c:forEach var="mv" items="${movies}">
                                                <c:if test="${sessionScope.movieIdCinemaFollow == mv.id}">
                                                    <option value="${mv.id}" selected>${mv.nameByVietnam}</option>
                                                </c:if>
                                                <c:if test="${sessionScope.movieIdCinemaFollow != mv.id}">
                                                    <option value="${mv.id}">${mv.nameByVietnam}</option>
                                                </c:if>
                                            </c:forEach>
                                        </c:if>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <input type="date" name="showDateCinemaFollow" onchange="this.form.submit()" class="form-control showDate" min="${startDate}" 
                                           max="${endDate}"
                                           <c:if test="${sessionScope.showDateCinemaFollow != null}">value="${sessionScope.showDateCinemaFollow}"</c:if>  
                                           <c:if test="${sessionScope.showDateCinemaFollow == null}">value="${startDate}"</c:if>>
                                    </div>
                                    <div class="form-group">
                                        <select class="form-control" name="showTimeCinemaFollow" onchange="this.form.submit()">
                                            <option value="">Chọn suất</option>
                                        <c:forEach var="cmt" items="${cinemaMovies}">
                                            <c:if test="${sessionScope.showTimeCinemaFollow == cmt.showTime}">
                                                <option value="${cmt.showTime}" selected>${cmt.showTime}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.showTimeCinemaFollow != cmt.showTime}">
                                                <option value="${cmt.showTime}">${cmt.showTime}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                                <div class="text-right">
                                    <a <c:if test="${sessionScope.movieIdCinemaFollow == '' || 
                                                     sessionScope.cinemaIdCinemaFollow == '' || 
                                                     sessionScope.showDateCinemaFollow == '' || 
                                                     sessionScope.showTimeCinemaFollow == ''}">
                                              onclick="return confirm('Bạn chưa chọn suất chiếu?')"
                                          </c:if> 
                                          <c:if test="${sessionScope.movieIdCinemaFollow != '' && 
                                                        sessionScope.cinemaIdCinemaFollow != '' && 
                                                        sessionScope.showDateCinemaFollow != '' && 
                                                        sessionScope.showTimeCinemaFollow != ''}">
                                                href="${pageContext.request.contextPath}/booking?movieId=${sessionScope.movieIdCinemaFollow}&cinemaId=${sessionScope.cinemaIdCinemaFollow}&showDate=${sessionScope.showDateCinemaFollow}&showTime=${sessionScope.showTimeCinemaFollow}"
                                          </c:if>  
                                          class="btn mr-2 mb-2"> <i class="fas fa-money-check-alt"></i> Mua
                                        vé</a>
                                </div>
                            </mvc:form>
                        </div>
                    </div>
                </div>
                <div class="col-9 movieCarousel mt-4">
                    <div id="movieCrs" class="carousel slide" data-ride="carousel">
                        <ol class="carousel-indicators">
                            <li class="active" data-target="#movieCrs" data-slide-to="0" aria-current="location"></li>
                            <li data-target="#movieCrs" data-slide-to="1"></li>
                            <li data-target="#movieCrs" data-slide-to="2"></li>
                            <li data-target="#movieCrs" data-slide-to="3"></li>
                            <li data-target="#movieCrs" data-slide-to="4"></li>
                        </ol>
                        <div class="carousel-inner">
                            <div class="carousel-item active">
                                <a href="${pageContext.request.contextPath}/movieDetail/1"><img class="img-fluid" width="100%" src="resources/images/carousel/thor.jpg" alt=""></a>
                            </div>
                            <div class="carousel-item">
                                <a href="${pageContext.request.contextPath}/movieDetail/3"><img class="img-fluid" width="100%" src="resources/images/carousel/conanmovie25.jpg"
                                                                                                alt=""></a>
                            </div>
                            <div class="carousel-item">
                                <a href="${pageContext.request.contextPath}/movieDetail/2"><img class="img-fluid" width="100%" src="resources/images/carousel/minion.jpg" alt=""></a>
                            </div>
                            <div class="carousel-item">
                                <a href="#"><img class="img-fluid" width="100%" src="resources/images/carousel/orther1.jpg"
                                                 alt=""></a>
                            </div>
                            <div class="carousel-item">
                                <a href="#"><img class="img-fluid" width="100%" src="resources/images/carousel/orther2.jpg"
                                                 alt=""></a>
                            </div>
                        </div>
                        <a class="carousel-control-prev" href="#movieCrs" data-slide="prev" role="button">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="carousel-control-next" href="#movieCrs" data-slide="next" role="button">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div>
                </div>
            </div>
            <div class="content2 mt-2">
                <div class="row">
                    <div class="col">
                        <div id='nz-div-2'>
                            <h3 class="tde">
                                <span>Phim đang chiếu</span>
                            </h3>
                            <hr>
                        </div>
                    </div>
                </div>
                <div class="row text-right extraView">
                    <div class="col">
                        <a href="${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=PHIM_DANG_CHIEU"><b>Xem thêm...</b></a>
                    </div>
                </div>
                <div class="row movies text-center">
                    <c:if test="${top6Coming == null}">
                        <div class="col mb-5">
                            <b style="color: #31d7a9;">KHÔNG TỒN TẠI PHIM ĐANG CHIẾU</b>
                        </div>
                    </c:if>
                    <c:if test="${top6Coming != null}">
                        <c:forEach var="movie" items="${top6Coming}">
                            <div class="col-2">
                                <div class="imgContent">
                                    <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img class="card-img-top" src="resources/images/movies/coming/${movie.imageMovie}"
                                                                                                                                             alt=""></a>

                                </div>
                                <div class="card-body">
                                    <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}">
                                        <h5 class="card-title">${movie.nameByEnglish}</h5>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="content3 mt-2">
                <div class="row">
                    <div class="col">
                        <div id='nz-div-2'>
                            <h3 class="tde">
                                <span>Phim sắp chiếu</span>
                            </h3>
                            <hr>
                        </div>
                    </div>
                </div>
                <div class="row text-right extraView">
                    <div class="col">
                        <a href="${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=PHIM_SAP_CHIEU"><b>Xem thêm...</b></a>
                    </div>
                </div>
                <div class="row movies text-center">
                    <c:if test="${top6ComingSoon == null}">
                        <div class="col mb-5">
                            <b style="color: #31d7a9;">KHÔNG TỒN TẠI PHIM SẮP CHIẾU</b>
                        </div>
                    </c:if>
                    <c:if test="${top6ComingSoon != null}">
                        <c:forEach var="movie" items="${top6ComingSoon}">
                            <div class="col-2">
                                <div class="imgContent">
                                    <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img class="card-img-top" src="resources/images/movies/coming soon/${movie.imageMovie}"
                                                                                                                                             alt=""></a>

                                </div>
                                <div class="card-body">
                                    <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}">
                                        <h5 class="card-title">${movie.nameByEnglish}</h5>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
            </div>
            <div class="content4 mt-2">
                <div class="row nameContent">
                    <div class="col">
                        <p style="text-decoration: underline;">Review Phim:</p>
                    </div>
                </div>
                <div class="row bodyContent">
                    <c:forEach var="review" items="${reviews}">
                        <div class="col-6 mt-2 mb-2">
                            <div class="row">
                                <div class="col-6">
                                    <a title="${review.nameReview}" href="${pageContext.request.contextPath}/reviewMovieDetail/${review.id}"><img class="img-fluid" src="resources/images/review/idmovie${review.movie.id}/${review.reviewImages.get(0).imageReview}" alt=""></a>
                                </div>
                                <div class="col-6">
                                    <a title="${review.nameReview}" href="${pageContext.request.contextPath}/reviewMovieDetail/${review.id}">
                                        <h5>
                                            <c:if test="${review.nameReview.length() <= 49}">
                                                [Review Phim] ${review.nameReview.substring(0,review.nameReview.length())}
                                            </c:if>
                                            <c:if test="${review.nameReview.length() > 49}">
                                                [Review Phim] ${review.nameReview.substring(0,49)}....
                                            </c:if>
                                        </h5>
                                    </a>
                                    <div class="row text-center">
                                        <div class="col-6 mt-2">
                                            <p style="color: white;"><i class="fas fa-thumbs-up"></i>${review.likeNumber}</p>
                                        </div>
                                        <div class="col-6 mt-2">
                                            <i style="color: white;">Views: ${review.viewNumber}</i>
                                        </div>
                                    </div>
                                    <div class="rate" style="color: #ffd84a;">
                                        <c:if test="${review.vote == 0}">
                                            Chưa có đánh giá
                                        </c:if>
                                        <c:if test="${review.vote != 0}">
                                            <c:forEach begin="1" end="${review.vote}" var="i">
                                                <label for="star${i}">${i} star</label>
                                            </c:forEach>
                                        </c:if>

                                    </div>
                                    <p class="contentReview">
                                        <c:if test="${review.contentReview.length() <= 70}">
                                            [Review Phim] ${review.contentReview.substring(0,review.contentReview.length())}
                                        </c:if>
                                        <c:if test="${review.contentReview.length() > 70}">
                                            [Review Phim] ${review.contentReview.substring(0,70)}....
                                        </c:if>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="content6">
                <div class="row">
                    <div class="col">
                        <p style="text-decoration: underline;">Double T Cinema</p>
                    </div>
                </div>
                <div class="row">
                    <div class="col">
                        <i style="color: white;">Hân hạnh được phục vụ quý khách! Hãy đến đây và cùng tận hưởng những giây phút thoải mái nhất
                            sau những giờ học tập, làm việc căng thẳng! Chúng tôi sẵn sàng đưa quý khách đi tham quan những
                            bộ phim hay và hấp dẫn nhất!!</i>
                    </div>
                </div>
            </div>

        </div>
        <!-- footer -->
        <jsp:include page="../user/fragment/footer.jsp" />
        <!-- scroll -->
        <jsp:include page="../user/fragment/scroll.jsp" />
        <script src="<c:url value="/webjars/jquery/3.6.0/jquery.min.js"/>"></script>
        <!--jQuery first, then Popper.js, then Bootstrap JS--> 
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
        </script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
        </script>
    </body>
</html>
