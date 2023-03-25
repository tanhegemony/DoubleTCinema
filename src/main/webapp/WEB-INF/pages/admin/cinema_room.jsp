<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'cinema_rooms'}">Cinema Rooms</c:if>
            <c:if test="${action == 'search_cinema_rooms'}">Search Cinema Rooms</c:if>
            </title>
        <jsp:include page="../include/management/css.jsp" />
    </head>

    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <!-- header -->
            <jsp:include page="../include/management/header.jsp" />
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="../include/management/menu.jsp" />
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <!-- Nhập nội dung -->
                                    <div class="col-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center">Cinema Rooms</h4>
                                                <div class="row">
                                                    <div class="col-sm-12 col-md-6">
                                                        <div class="dataTables_length" id="order-listing_length">
                                                            <b> Display </b> 
                                                            <label>
                                                                <form action="">
                                                                    <input type="hidden" name="searchValue" value="${searchValue}">
                                                                    <select name="size" id="size" class="custom-select custom-select-sm form-control" 
                                                                            aria-controls="order-listing" onchange="this.form.submit()">
                                                                        <option value="5" <c:if test="${pageSize == 5}">selected</c:if>> 5 </option>
                                                                        <option value="10" <c:if test="${pageSize == 10}">selected</c:if>> 10 </option>
                                                                        <option value="15" <c:if test="${pageSize == 15}">selected</c:if>> 15 </option>
                                                                        </select>
                                                                    </form>
                                                                </label>
                                                                <b>  cinema rooms </b>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="searchCinemaRooms" method="GET">
                                                                <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                    <label>
                                                                        <input type="text" class="form-control" name="searchValue"
                                                                               id="searchValue" style="min-width: 20rem;" placeholder="Input Cinema Room Name And Cinema Name" value="${searchValue}">
                                                                </label>
                                                                <label>
                                                                    <button class="btn btn-sm btn-primary form-control my-2"  ><i class="ti-search"></i></button>
                                                                </label>

                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>                         
                                                <div class="row">   
                                                    <div class="col-sm-12 mt-2" >
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-bordered text-center">
                                                                <thead>
                                                                    <tr style="background-color: #1f3bb3; color: white;">
                                                                        <th>Room Name</th>
                                                                        <th>Number Of Row</th>
                                                                        <th>Number Of Column</th>
                                                                        <th>Cinema Name</th>
                                                                        <th style="text-align: center"><a href="${pageContext.request.contextPath}/admin/addCinemaRoom"><i class="icon-plus" id="color-icon" style="font-size: 1.25rem;color: white"></i></a></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${cinemaRooms == null}">
                                                                    <td colspan="5">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${cinemaRooms != null}">
                                                                    <c:forEach var="cr" items="${cinemaRooms}">
                                                                        <tr>
                                                                            <td>${cr.cinemaRoomName}</td>
                                                                            <td>${cr.rowCinemaRoom}</td>
                                                                            <td>${cr.columnCinemaRoom}</td>
                                                                            <td>${cr.cinema.nameCinema}</td>
                                                                            <td class="jsgrid-align-center" style="text-align: center">
                                                                                <a href="<c:url value="editCinemaRoom/${cr.id}" />"><i class="mdi mdi mdi-border-color" id="color-icon"></i></a>
                                                                                    <c:if test="${cr.checkExistCinemaMovies == true}">
                                                                                    <a onclick="return confirm('Can not to remove CinemaRoom [${cr.cinemaRoomName}]! Because CinemaRoom [${cr.cinemaRoomName}] exists the upcoming movie!')"><i class="icon-trash" id="color-icon"></i></a>
                                                                                    </c:if>
                                                                                    <c:if test="${cr.checkExistCinemaMovies == false}">
                                                                                    <a onclick="return confirm('Are you sure you want to remove CinemaRoom [${cr.cinemaRoomName}]?')" href="<c:url value="deleteCinemaRoom/${cr.id}" />"><i class="icon-trash" id="color-icon"></i></a>
                                                                                    </c:if>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:if>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${cinemaRooms != null}">          
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'cinema_rooms'}">cinemaRooms?</c:if><c:if test="${action == 'search_cinema_rooms'}">searchCinemaRooms?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">

                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'cinema_rooms'}">cinemaRooms?</c:if><c:if test="${action == 'search_cinema_rooms'}">searchCinemaRooms?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'cinema_rooms'}">cinemaRooms?</c:if><c:if test="${action == 'search_cinema_rooms'}">searchCinemaRooms?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
                                                                                <span aria-hidden="true">&raquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                </nav>
                                                            </div>

                                                        </div>
                                                </c:if>
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
                    <jsp:include page="../include/management/footer.jsp" />
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <jsp:include page="../include/management/js.jsp" />
    </body>

</html>