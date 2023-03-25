
<%@page import="java.util.Calendar"%>
<%@page import="com.ivt.spring_final_doubletcinema.repository.CinemaMovieRepository"%>
<%@page import="org.springframework.context.annotation.Bean"%>
<%@page import="org.springframework.beans.factory.annotation.Autowired"%>
<%@page import="org.springframework.ui.Model"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.ivt.spring_final_doubletcinema.service.CinemaService"%>
<%@page import="com.ivt.spring_final_doubletcinema.entities.CinemaMovieEntity"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Calendar Movie Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/calendar_movie.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/calendar_movie_responsive.css" />"/>


    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container content mt-3">
            <div class="row header text-center">
                <div class="col">
                    <p>Lịch chiếu phim</p>
                </div>
            </div>
            <div class="row calendarMovie mt-2">
                <div class="col">
                    <ul class="nav nav-tabs justify-content-center" id="calendarMovie" role="tablist">
                        <li class="nav-item mr-2" role="presentation">
                            <form action="calendar_movie" method="get">
                                <input type="hidden" name="contentNavCalendar" value="calendarFilmFollow">
                                <button class="nav-link <c:if test="${contentNavCalendar == 'calendarFilmFollow'}">active</c:if>" id="calendarFilmFollow-tab" onclick="location.href = '${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarFilmFollow'"  role="tab"
                                        aria-controls="calendarFilmFollow" aria-selected="true">Lịch chiếu theo phim</button>
                                </form>
                            </li>
                            <li class="nav-item mr-2" role="presentation">
                                <form action="calendar_movie" method="get">
                                    <input type="hidden" name="contentNavCalendar" value="calendarCinemaFollow">
                                    <button class="nav-link <c:if test="${contentNavCalendar == 'calendarCinemaFollow'}">active</c:if>" id="calendarCinemaFollow-tab" onclick="location.href = '${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarCinemaFollow'" role="tab"
                                            aria-controls="calendarCinemaFollow" aria-selected="true">Lịch chiếu theo rạp</button>
                                </form>
                            </li>
                            <li class="nav-item mr-2" role="presentation">
                                <form action="calendar_movie" method="get">
                                    <input type="hidden" name="contentNavCalendar" value="calendarDayFollow">
                                    <button class="nav-link <c:if test="${contentNavCalendar == 'calendarDayFollow'}">active</c:if>" id="calendarDayFollow-tab" onclick="location.href = '${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarDayFollow'" role="tab"
                                            aria-controls="calendarDayFollow" aria-selected="true">Lịch chiếu theo ngày</button>
                                </form>
                            </li>
                        </ul>
                        <div class="tab-content" id="calendarMovieContent">
                            <div class="tab-pane fade <c:if test="${contentNavCalendar == 'calendarFilmFollow'}">show active</c:if>" id="calendarFilmFollow" role="tabpanel"
                                 aria-labelledby="calendarFilmFollow-tab">
                                <div class="row mt-2 breadcrumbContent">
                                    <div class="col">
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="#"><i class="fas fa-home"></i> Trang
                                                        chủ</a></li>
                                                <li class="breadcrumb-item"><a href="#"><i class="fas fa-film"></i> Lịch chiếu
                                                        phim </a></li>
                                                <li class="breadcrumb-item active" aria-current="page">Lịch chiếu phim theo phim</li>
                                            </ol>
                                        </nav>
                                    </div>
                                </div>
                                <hr style="border: 2px solid #31d7a9; margin-top: 2rem;">
                                <div class="row filmFollow">
                                    <div class="col">
                                    <c:if test="${allCinemaMovies == null || allCinemaMovies.size() <= 0}">
                                        <b style="color: #31d7a9;">KHÔNG TỒN TẠI SUẤT CHIẾU</b>
                                    </c:if>
                                    <c:if test="${allCinemaMovies != null}">
                                        <c:forEach var="allcm" items="${allCinemaMovies}"> 
                                            <a href="#"><b>${allcm.movie.nameByEnglish}</b></a>
                                            <div class="row mt-3">
                                                <div class="col-2">
                                                    <a href="${pageContext.request.contextPath}/movieDetail/${allcm.movie.id}"><img class="img-fluid"
                                                                                                                                    src="${pageContext.request.contextPath}/resources/images/movies/coming/${allcm.movie.imageMovie}" alt=""></a>
                                                </div>
                                                <div class="col-10">
                                                    <c:if test="${allcm.cinemaMoviesDisplay.size() <= 0}">
                                                        <p style="color: #31d7a9;">Chưa có suất chiếu cho ngày hôm nay!!</p>
                                                    </c:if>
                                                    <c:if test="${allcm.cinemaMoviesDisplay.size() > 0}">
                                                        <c:forEach var="cmd" items="${allcm.cinemaMoviesDisplay}"> 
                                                            <div id='nz-div'>
                                                                <h3 class="tde">
                                                                    <span class="null">${cmd.cinema.nameCinema}</span>
                                                                </h3>
                                                            </div>
                                                            <i>Suất chiếu: </i> <br>
                                                            <c:if test="${cmd.showTime.size() <= 0}">
                                                                <p style="color: #31d7a9;">Chưa có suất chiếu tại rạp ${cmd.cinema.nameCinema} cho ngày hôm nay!!</p>
                                                            </c:if>
                                                            <c:if test="${cmd.showTime.size() > 0}">
                                                                <c:forEach var="showTime" items="${cmd.showTime}">
                                                                    <button style="border-radius: 5px 0px 0px 5px;" class=" mb-5 btn">${showTime.showTime}</button>
                                                                    <button style="border-radius: 0px 5px 5px 0px;transform: translateX(-0.5rem)" onclick="location.href = '${pageContext.request.contextPath}/booking?movieId=${showTime.movie.id}&cinemaId=${showTime.cinema.id}&showDate=${showTime.showDate}&showTime=${showTime.showTime}'" class="mb-5 btn btn-danger">Mua vé</button>
                                                                </c:forEach>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade <c:if test="${contentNavCalendar == 'calendarCinemaFollow'}">show active</c:if>" id="calendarCinemaFollow" role="tabpanel"
                             aria-labelledby="calendarCinemaFollow-tab">
                                <div class="row mt-2 breadcrumbContent">
                                    <div class="col">
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="#"><i class="fas fa-home"></i> Trang
                                                        chủ</a></li>
                                                <li class="breadcrumb-item"><a href="#"><i class="fas fa-film"></i> Lịch chiếu
                                                        phim </a></li>
                                                <li class="breadcrumb-item active" aria-current="page">Lịch chiếu phim theo rạp
                                                    -- Rạp: <i style="color: #31d7a9;">DoubleT Huế</i>
                                                </li>
                                            </ol>
                                        </nav>
                                    </div>
                                </div>
                                <div class="row cinemaFollow">
                                <c:forEach var="cinema" items="${cinemas}">
                                    <div class="col-4 mb-4">
                                        <button <c:if test="${cinemaId == cinema.id}">style="border: 2px solid #31d7a9;"</c:if> onclick="location.href = '${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarCinemaFollow&cinemaId=${cinema.id}'" class="btn">
                                                <div class="cinema text-left">
                                                    <h5>${cinema.nameCinema}</h5>
                                                <i class="address">Address: </i><i>${cinema.cinemaAddress}</i>
                                                <a href="${cinema.googleMap}" target="_blank"><i class="fas fa-map-marker-alt"></i> Xem Google Map</a>
                                            </div>
                                        </button>
                                    </div>
                                </c:forEach>
                            </div>
                            <hr style="border: 2px solid #31d7a9; margin-top: 2rem;">
                            <div class="row contentCinemaFollow mt-3">
                                <c:if test="${cinemaMoviesDisplay == null || cinemaMoviesDisplay.size() <= 0}">
                                    <div class="col text-center">
                                        <b style="color: #31d7a9;">KHÔNG TỒN TẠI SUẤT CHIẾU</b>
                                    </div>
                                </c:if>
                                <c:if test="${cinemaMoviesDisplay != null}">
                                    <c:forEach var="cmd" items="${cinemaMoviesDisplay}">
                                        <div class="col-6 mb-4">
                                            <a href="${pageContext.request.contextPath}/movieDetail/${cmd.movie.id}"><b>${cmd.movie.nameByEnglish}</b></a>
                                            <div class="row mt-3">
                                                <div class="col-4">
                                                    <a href="${pageContext.request.contextPath}/movieDetail/${cmd.movie.id}">
                                                        <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/movies/coming/${cmd.movie.imageMovie}" alt=""></a>
                                                </div>
                                                <div class="col-8">
                                                    <i>Suất chiếu: </i> <br>
                                                    <c:forEach var="showTime" items="${cmd.showTime}">
                                                        <button style="border-radius: 5px 0px 0px 5px;" class=" mb-5 btn">${showTime.showTime}</button>
                                                        <button style="border-radius: 0px 5px 5px 0px;transform: translateX(-0.5rem)" onclick="location.href = '${pageContext.request.contextPath}/booking?movieId=${showTime.movie.id}&cinemaId=${showTime.cinema.id}&showDate=${showTime.showDate}&showTime=${showTime.showTime}'" class="mb-5 btn btn-danger">Mua vé</button>
                                                    </c:forEach>
                                                </div>
                                            </div>
                                        </div>

                                    </c:forEach>
                                </c:if>


                            </div>
                        </div>
                        <div class="tab-pane fade <c:if test="${contentNavCalendar == 'calendarDayFollow'}">show active</c:if>" id="calendarDayFollow" role="tabpanel"
                             aria-labelledby="calendarDayFollow-tab">
                                <div class="row mt-2 breadcrumbContent">
                                    <div class="col">
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="#"><i class="fas fa-home"></i> Trang
                                                        chủ</a></li>
                                                <li class="breadcrumb-item"><a href="#"><i class="fas fa-film"></i> Lịch chiếu
                                                        phim </a></li>
                                                <li class="breadcrumb-item active" aria-current="page">Lịch chiếu phim theo ngày
                                                    -- Ngày: <i style="color: #31d7a9;">${showDate}</i>
                                            </li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                            <div class="row chooseCalendar text-center">
                                <div class="col">
                                    <c:forEach var="calendarDate" items="${calendarDates}">
                                        <button <c:if test="${showDate == calendarDate.dateData}">
                                                style="border: 2px solid #31d7a9;"
                                            </c:if> 
                                            onclick="location.href = '${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarDayFollow&showDate=${calendarDate.dateData}'" class="btn">${calendarDate.dateDisplay}</button>
                                    </c:forEach>
                                </div>
                            </div>
                            <hr style="border: 2px solid #31d7a9; margin-top: 2rem;">
                            <div class="row content mt-3">
                                <c:if test="${allCinemaMovies.size() <= 0}">
                                    <div class="col mb-4 text-center">
                                        <p style="color: #31d7a9;text-transform: uppercase;">Chưa có suất chiếu cho ngày ${showDate}!!</p>
                                    </div>
                                </c:if>
                                <c:if test="${allCinemaMovies.size() > 0}">
                                    <c:forEach var="allcm" items="${allCinemaMovies}">
                                        <div class="col-6 mb-4">
                                            <a href="#"><b>${allcm.movie.nameByEnglish}</b></a>
                                            <div class="row mt-3">
                                                <div class="col-4">
                                                    <a href="${pageContext.request.contextPath}/movieDetail/${allcm.movie.id}">
                                                        <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/movies/coming/${allcm.movie.imageMovie}" alt=""></a>
                                                </div>
                                                <div class="col-8">
                                                    <c:forEach var="cmd" items="${allcm.cinemaMoviesDisplay}">
                                                        <div id='nz-div'>
                                                            <h3 class="tde">
                                                                <span class="null">${cmd.cinema.nameCinema}:</span>
                                                            </h3>
                                                        </div>
                                                        <i>Suất chiếu: </i> <br>
                                                        <c:forEach var="showTime" items="${cmd.showTime}">
                                                            <button style="border-radius: 5px 0px 0px 5px;" class=" mb-5 btn">${showTime.showTime}</button>
                                                            <button style="border-radius: 0px 5px 5px 0px;transform: translateX(-0.5rem)" onclick="location.href = '${pageContext.request.contextPath}/booking?movieId=${cmd.movie.id}&cinemaId=${cmd.cinema.id}&showDate=${showTime.showDate}&showTime=${showTime.showTime}'" class="mb-5 btn btn-danger">Mua vé</button>
                                                        </c:forEach>
                                                    </c:forEach>

                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:if>


                            </div>
                        </div>
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
