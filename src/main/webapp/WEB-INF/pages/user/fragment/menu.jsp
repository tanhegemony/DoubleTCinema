<%-- 
    Document   : menu
    Created on : Jul 23, 2022, 5:12:31 PM
    Author     : tanhegemony
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="<c:url value="/resources/style/fragment/menu.css" />"/>
<link rel="stylesheet" href="<c:url value="/resources/style/fragment/menu_responsive.css" />"/>
<div class="menu">
    <ul class="nav justify-content-center" >
        <li class="nav-item">
            <a class="nav-link" <c:if test="${action == 'home'}">style="color: #31d7a9;"</c:if> href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Trang chủ</a>
            </li>
            <li class="nav-item film">
                <div class="dropdown">
                    <a class="nav-link" <c:if test="${action == 'movie_by_item'}">style="color: #31d7a9;"</c:if> href="#"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/film-reel.png" alt=""> Phim</a>
                    <div class="submenu">
                        <div class="row">
                            <div class="col">
                                <a <c:if test="${contentNavMovieItem == 'PHIM_DANG_CHIEU'}">style="color: #31d7a9;"</c:if> href="${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=PHIM_DANG_CHIEU" class="text-left">
                                    <h6 style="text-decoration: underline;">Phim đang chiếu: </h6>
                                </a>
                            <c:if test="${top4Coming == null}">
                                <b style="color: #31d7a9;">KHÔNG TỒN TẠI PHIM ĐANG CHIẾU</b>
                            </c:if>
                        </div>
                    </div>
                    <div class="row movieMenu">
                        <c:if test="${top4Coming != null}">
                            <c:forEach var="movie" items="${top4Coming}">
                                <div class="col-3">
                                    <div class="imgContent">
                                        <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img class="card-img-top"
                                                                                                                                                 src="${pageContext.request.contextPath}/resources/images/movies/coming/${movie.imageMovie}" alt=""></a>
                                    </div>
                                    <div class="card-body text-left">
                                        <h5 title="${movie.nameByEnglish}" class="card-title">
                                            <c:if test="${movie.nameByEnglish.length() <= 22}">
                                                ${movie.nameByEnglish.substring(0,movie.nameByEnglish.length())}
                                            </c:if>
                                            <c:if test="${movie.nameByEnglish.length() > 22}">
                                                ${movie.nameByEnglish.substring(0,22)}...
                                            </c:if>
                                        </h5>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                    <div class="row">
                        <div class="col">
                            <a <c:if test="${contentNavMovieItem == 'PHIM_SAP_CHIEU'}">style="color: #31d7a9;"</c:if> href="${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=PHIM_SAP_CHIEU" class="text-left">
                                    <h6 style="text-decoration: underline;">Phim sắp chiếu: </h6>
                                </a>
                            <c:if test="${top4ComingSoon == null}">
                                <b style="color: #31d7a9;">KHÔNG TỒN TẠI PHIM SẮP CHIẾU</b>
                            </c:if>
                        </div>
                    </div>
                    <div class="row movieMenu mb-2">
                        <c:if test="${top4ComingSoon != null}">
                            <c:forEach var="movie" items="${top4ComingSoon}">
                                <div class="col-3">
                                    <div class="imgContent">
                                        <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img class="card-img-top"
                                                                                                                                                 src="${pageContext.request.contextPath}/resources/images/movies/coming soon/${movie.imageMovie}" alt=""></a>
                                    </div>
                                    <div class="card-body text-left">
                                        <h5 title="${movie.nameByEnglish}" class="card-title">
                                            <c:if test="${movie.nameByEnglish.length() <= 22}">
                                                ${movie.nameByEnglish.substring(0,movie.nameByEnglish.length())}
                                            </c:if>
                                            <c:if test="${movie.nameByEnglish.length() > 22}">
                                                ${movie.nameByEnglish.substring(0,22)}...
                                            </c:if>
                                        </h5>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:if>
                    </div>
                </div>
            </div>
        </li>
        <li class="nav-item less767px">
            <div class="dropdown">
                <a class="nav-link" href="#"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/film-reel.png" alt=""> Phim</a>
                <div class="submenu">
                    <div class="row">
                        <div class="col">
                            <a href="${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=PHIM_DANG_CHIEU">Phim đang chiếu</a> <br>
                            <a href="${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=PHIM_SAP_CHIEU">Phim sắp chiếu</a> <br>
                        </div>
                    </div>
                </div>
            </div>
        </li>
        <li class="nav-item">
            <div class="dropdown">
                <a class="nav-link" <c:if test="${action == 'calendarMovie'}">style="color: #31d7a9;"</c:if> href="#"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/calendar.png" alt=""> Lịch
                        chiếu</a>
                    <div class="submenu">
                        <div class="row">
                            <div class="col">
                                <a href="${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarFilmFollow" <c:if test="${sessionScope.contentNavCalendar == 'calendarFilmFollow'}">style="color: #31d7a9;"</c:if>>Lịch chiếu theo phim</a> <br>
                            <a href="${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarCinemaFollow" <c:if test="${sessionScope.contentNavCalendar == 'calendarCinemaFollow'}">style="color: #31d7a9;"</c:if>>Lịch chiếu theo rạp</a> <br>
                            <a href="${pageContext.request.contextPath}/calendar_movie?contentNavCalendar=calendarDayFollow" <c:if test="${sessionScope.contentNavCalendar == 'calendarDayFollow'}">style="color: #31d7a9;"</c:if>>Lịch chiếu theo ngày</a> <br>
                        </div>
                    </div>
                </div>
            </div>
        </li>
    </ul>
</nav>
</div>
