<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'movies'}">Movies</c:if>
            <c:if test="${action == 'search_movies'}">Search Movies</c:if>
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
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <!-- Nhập nội dung -->
                                    <div class="col-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center">Movies</h4>
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
                                                                <b>  movies </b>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="searchMovies" method="GET">
                                                                <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                    <label>
                                                                        <input type="text" class="form-control" name="searchValue"
                                                                               id="searchValue" style="min-width: 19rem;" placeholder="Enter NameEnglish Or NameVietNam" value="${searchValue}">
                                                                </label>
                                                                <label>
                                                                    <button class="btn btn-sm btn-primary form-control my-2"  ><i class="ti-search"></i></button>
                                                                </label>
                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="col">
                                                        <a href="<c:url value="/admin/addMovie" />" style="color: black; text-decoration: none;font-weight: bolder;"><i class="icon-plus" id="color-icon" style="font-size: 1.25rem;"></i> Add New Movie</a>
                                                    </div>
                                                </div>    
                                                <div class="row">   
                                                    <div class="col-sm-12 mt-2" >
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-bordered ">
                                                                <thead class="text-center">
                                                                    <tr style="background-color: #1f3bb3; color: white;">
                                                                        <th>Avatar</th>
                                                                        <th>Movie Information</th>
                                                                        <th>Production Information</th>
                                                                        <th>Status</th>
                                                                        <th>Movie Trailer</th>
                                                                        <th style="text-align: center">
                                                                            Actions
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${movies == null}">
                                                                    <td colspan="6">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${movies != null}">
                                                                    <c:forEach var="m" items="${movies}">
                                                                        <tr>
                                                                            <td class="text-center"><img title="${m.nameByEnglish}" id="image-movie" 
                                                                                     src="${pageContext.request.contextPath}/resources/images/movies/<c:if test="${m.filmItem == 'PHIM_DANG_CHIEU'}">coming</c:if><c:if test="${m.filmItem == 'PHIM_SAP_CHIEU'}">coming soon</c:if>/${m.imageMovie}"
                                                                                         />
                                                                                         <p class="mt-3"><i class="fas fa-eye"></i>Viewed Movie Detail Number: ${m.viewedNumber} <i class="fas fa-user"></i></p>
                                                                            </td>
                                                                                <td>
                                                                                    <p title="${m.nameByEnglish}">
                                                                                    <c:if test="${m.nameByEnglish.length() <= 22}">
                                                                                        <span style="color: red">${m.nameByEnglish.substring(0,m.nameByEnglish.length())}</span>
                                                                                    </c:if>
                                                                                    <c:if test="${m.nameByEnglish.length() > 22}">
                                                                                         <span style="color: red">${m.nameByEnglish.substring(0,22)}...</span>
                                                                                    </c:if>
                                                                                </p>
                                                                                <p title="${m.nameByVietnam}">
                                                                                    <c:if test="${m.nameByVietnam.length() <= 22}">
                                                                                        <span style="color: red">${m.nameByVietnam.substring(0,m.nameByVietnam.length())}</span>
                                                                                    </c:if>
                                                                                    <c:if test="${m.nameByVietnam.length() > 22}">
                                                                                        <span style="color: red">${m.nameByVietnam.substring(0,22)}...</span>
                                                                                    </c:if>
                                                                                </p>
                                                                                <p><b>Duration:</b> ${m.duration} phút - <b>Premiere:</b> ${m.premiere}</p>
                                                                                <p><b>Producer:</b> ${m.producer}</p>
                                                                                <p><b>Quốc gia:</b> ${m.nation}</p>
                                                                                <p><b>Thể loại: </b>
                                                                                    <c:forEach var="mc" items="${m.movieCategories}">
                                                                                    <span>${mc.category.categoryName}, </span>
                                                                                    </c:forEach>
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="text"><b>Director:</b> <span style="color: red">${m.director}</span></p>
                                                                                <p class="text"><b>Cast:</b> <span style="color: red">${m.cast}</span></p>
                                                                            </td>
                                                                            <td>${m.filmItem}</td>
                                                                            <td>
                                                                                <a href="${m.trailer}" target="_blank" style="color: red;font-weight: bold;text-decoration: none;">View Trailer</a>
                                                                            </td>
                                                                            <td class="jsgrid-align-center" style="text-align: center">
                                                                                <a href="<c:url value="editMovie/${m.id}" />"><i class="mdi mdi mdi-border-color" id="color-icon"></i></a>
                                                                                
                                                                                 <c:if test="${m.checkExistCinemaMovies == true}">
                                                                                    <a onclick="return confirm('Can not to remove with movie [${m.nameByEnglish}]! Because movie [${m.nameByEnglish}] is showing!')"><i class="icon-trash" id="color-icon"></i></a>
                                                                                    </c:if>
                                                                                    <c:if test="${m.checkExistCinemaMovies == false}">
                                                                                    <a onclick="return confirm('Are you sure you want to remove movie [${m.nameByEnglish}]?')" href="<c:url value="deleteMovie/${m.id}" />"><i class="icon-trash" id="color-icon"></i></a>
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
                                                <c:if test="${movies != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'movies'}">movies?</c:if><c:if test="${action == 'search_movies'}">searchMovies?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">

                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'movies'}">movies?</c:if><c:if test="${action == 'search_movies'}">searchMovies?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'movies'}">movies?</c:if><c:if test="${action == 'search_movies'}">searchMovies?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
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