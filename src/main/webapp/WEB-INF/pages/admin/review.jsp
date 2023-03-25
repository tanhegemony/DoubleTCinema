<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'reviews'}">Reviews</c:if>
            <c:if test="${action == 'search_reviews'}">Search Reviews</c:if>
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
                                                <h4 class="card-title text-center">Reviews</h4>
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
                                                                <b>  Reviews </b>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="${pageContext.request.contextPath}/admin/searchReviews" method="GET">
                                                            <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                <label>
                                                                    <input type="text" class="form-control" name="searchValue"
                                                                           id="searchValue" style="min-width: 22rem;" placeholder="Enter Name Review Or Name Movie By English" value="${searchValue}">
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
                                                                        <th>Film Image</th>
                                                                        <th>Film Name</th>
                                                                        <th>Review Content</th>
                                                                        <th>Dependence Movie Name</th>
                                                                        <th>Reviewer Name</th>
                                                                        <th style="text-align: center">
                                                                            <a href="${pageContext.request.contextPath}/admin/addReview"><i class="icon-plus" id="color-icon" style="font-size: 1.25rem;color: white;"></i></a>
                                                                        </th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${reviews == null}">
                                                                    <td colspan="6">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${reviews != null}">
                                                                    <c:forEach var="r" items="${reviews.content}">
                                                                        <tr>
                                                                            <td>
                                                                                <img id="image-film"
                                                                                     src="${pageContext.request.contextPath}/resources/images/review/idmovie${r.movie.id}/${r.reviewImages.get(0).imageReview}"
                                                                                     />
                                                                            </td>
                                                                            <td>
                                                                                <p title="${r.nameReview}">
                                                                                    <c:if test="${r.nameReview.length() <= 22}">
                                                                                        ${r.nameReview.substring(0,r.nameReview.length())}
                                                                                    </c:if>
                                                                                    <c:if test="${r.nameReview.length() > 22}">
                                                                                        ${r.nameReview.substring(0,22)}...
                                                                                    </c:if>
                                                                                </p>
                                                                                <p> Vote: 
                                                                                    <c:if test="${r.vote == null || r.vote == 0}">
                                                                                        No Star
                                                                                    </c:if>
                                                                                    <c:if test="${r.vote != null || r.vote > 0}">
                                                                                        <c:forEach var="i" begin="1" end="${r.vote}">
                                                                                            <i class="mdi mdi-star-circle"></i>
                                                                                        </c:forEach>
                                                                                    </c:if>
                                                                                </p>
                                                                                <p>
                                                                                    Like: <i class="mdi mdi-thumb-up-outline"></i> ${r.likeNumber}
                                                                                </p>
                                                                                <p>
                                                                                    View: <i class="mdi mdi-eye"></i> ${r.viewNumber}
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <p class="text">${r.contentReview}</p>
                                                                            </td>
                                                                            <td title="${r.movie.nameByEnglish}">
                                                                                <c:if test="${r.movie.nameByEnglish.length() <= 22}">
                                                                                    ${r.movie.nameByEnglish.substring(0,r.movie.nameByEnglish.length())}
                                                                                </c:if>
                                                                                <c:if test="${r.movie.nameByEnglish.length() > 22}">
                                                                                    ${r.movie.nameByEnglish.substring(0,22)}....
                                                                                </c:if>
                                                                            </td>
                                                                            <td>${r.reviewer}</td>
                                                                            <td class="jsgrid-align-center" style="text-align: center">
                                                                                <a href="${pageContext.request.contextPath}/admin/editReview/${r.id}"><i class="mdi mdi mdi-border-color" id="color-icon"></i></a>
                                                                                <a onclick="return confirm('Are you sure you want to remove review [${r.nameReview}]?')" href="<c:url value="deleteReview/${r.id}" />"><i class="icon-trash" id="color-icon"></i></a>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:if>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${reviews != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'reviews'}">reviews?</c:if><c:if test="${action == 'search_reviews'}">searchReviews?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">

                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'reviews'}">reviews?</c:if><c:if test="${action == 'search_reviews'}">searchReviews?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'reviews'}">reviews?</c:if><c:if test="${action == 'search_reviews'}">searchReviews?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
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