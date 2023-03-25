<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'add_cinema_movie'}">Add Cinema Movie</c:if>
            <c:if test="${action == 'update_cinema_movie'}">Update Cinema Movie</c:if>
            </title>
        <jsp:include page="../../include/management/css.jsp" />
    </head>

    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <!-- header -->
            <jsp:include page="../../include/management/header.jsp" />
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="../../include/management/menu.jsp" />
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <!-- Nhập nội dung -->
                                    <div class="col-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center"> 
                                                    <c:if test="${action == 'add_cinema_movie'}">Add Cinema Movie</c:if>
                                                    <c:if test="${action == 'update_cinema_movie'}">View Cinema Movie</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveCinemaMovie" method="post"
                                                          modelAttribute="cinema_movie">
                                                    <c:if test="${action == 'update_cinema_movie'}">
                                                        <input type="hidden" name="id" value="${cinemaMovie.id}">
                                                        <input type="hidden" name="movie.id" value="${cinemaMovie.movie.id}">
                                                    </c:if>
                                                    <div class="form-group">
                                                        <label for="movie">Movie: </label>
                                                        <select class="form-control" id="movie" name="movie.id" onchange="this.form.submit();" style="color: black;" <c:if test="${action == 'update_cinema_movie'}">disabled</c:if>>
                                                                <option value="">Select Movie...</option>
                                                            <c:forEach var="m" items="${movies}"> 
                                                                <c:if test="${cinemaMovie.movie.id == m.id}">
                                                                    <option value="${m.id}" selected>${m.nameByEnglish}</option>
                                                                </c:if>
                                                                <c:if test="${cinemaMovie.movie.id != m.id}">
                                                                    <option value="${m.id}">${m.nameByEnglish}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                        <p class="card-description" style="color: red;">
                                                            <c:if test="${messageMovie != ''}">
                                                                ${messageMovie}
                                                            </c:if>
                                                        </p>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="cinema">Cinema: </label>
                                                        <select class="form-control" id="cinema" name="cinema.id" style="color: black;" onchange="this.form.submit();">
                                                            <option value="">Select Cinema...</option>
                                                            <c:forEach var="c" items="${cinemas}"> 
                                                                <c:if test="${cinemaMovie.cinema.id == c.id}">
                                                                    <option value="${c.id}" selected>${c.nameCinema}</option>
                                                                </c:if>
                                                                <c:if test="${cinemaMovie.cinema.id != c.id}">
                                                                    <option value="${c.id}">${c.nameCinema}</option>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                        <p class="card-description" style="color: red;">
                                                            <c:if test="${messageCinema != ''}">
                                                                ${messageCinema}
                                                            </c:if>
                                                        </p>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="cinemaRoom">Cinema Room: </label>
                                                        <select class="form-control" id="cinemaRoom" name="cinemaRoom.id" style="color: black;">
                                                            <option value="0">Select Cinema Room...</option>
                                                            <c:if test="${cinemaMovie.cinema.id > 0}">
                                                                <c:forEach var="cr" items="${cinemaRooms}"> 
                                                                    <c:if test="${cinemaMovie.cinemaRoom.id == cr.id}">
                                                                        <option value="${cr.id}" selected>${cr.cinemaRoomName}</option>
                                                                    </c:if>
                                                                    <c:if test="${cinemaMovie.cinemaRoom.id != cr.id}">
                                                                        <option value="${cr.id}">${cr.cinemaRoomName}</option>
                                                                    </c:if>
                                                                </c:forEach>
                                                            </c:if>
                                                        </select>
                                                        <p class="card-description" style="color: red;">
                                                            <c:if test="${messageCinemaRoom != ''}">
                                                                ${messageCinemaRoom}
                                                            </c:if>
                                                        </p>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="showDate">Show Date: </label>
                                                        <input type="date" min="${dateFormat}" class="form-control" id="showDate" 
                                                               placeholder="yyyy-MM-dd" value="<c:if test="${action == 'add_cinema_movie'}">${dateFormat}</c:if><c:if test="${action == 'update_cinema_movie'}">${showDateFormat}</c:if>" name="showDate">
                                                               <p class="card-description" style="color: red;">
                                                               <c:if test="${messageShowDate != ''}">
                                                                   ${messageShowDate}
                                                               </c:if>
                                                        </p>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="showTime">Show Time: </label>
                                                        <input type="time" class="form-control" id="showTime" placeholder="HH:mm:ss" value="<c:if test="${action == 'add_cinema_movie'}">${timeFormat}:00</c:if><c:if test="${action == 'update_cinema_movie'}">${showTimeFormat}</c:if>" name="showTime">
                                                            <p class="card-description" style="color: red;">
                                                            <c:if test="${messageShowTime != ''}">
                                                                ${messageShowTime}
                                                            </c:if>
                                                        </p>
                                                    </div>
                                                    <c:if test="${messageCinemaMovie != null}">
                                                        <p style="color: red;">${messageCinemaMovie}</p>
                                                    </c:if>
                                                    <c:if test="${action == 'update_cinema_movie'}">
                                                        <button type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_cinema_movie'}">
                                                        <button type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/cinemaMovies" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
                                                </mvc:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <!-- footer -->
                    <jsp:include page="../../include/management/footer.jsp" />
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <jsp:include page="../../include/management/js.jsp" />
    </body>

</html>