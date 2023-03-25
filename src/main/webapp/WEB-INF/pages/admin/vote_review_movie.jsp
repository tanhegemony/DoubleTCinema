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
            <c:if test="${action == 'votes_review_movie'}">Votes Review Movie</c:if>
            <c:if test="${action == 'search_votes_review_movie'}">Search Votes Review Movie</c:if>
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
                                    <div class="col-12 grid-margin stretch-card mt-2">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center">Votes Review Movie</h4>
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
                                                                <b>  votes review movie </b>

                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="searchVotesReviewMovie" method="GET">
                                                                <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                    <label>
                                                                        <input type="text" class="form-control" name="searchValue"
                                                                               id="searchValue" style="min-width: 25rem;" placeholder="Enter NameReview Or CustomerName Or StarNumber" value="${searchValue}">
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
                                                                        <th>Review</th>
                                                                        <th>Star Number</th>
                                                                        <th>Comment</th>
                                                                        <th>Voter</th>
                                                                        <th>Vote Date</th>
                                                                        <th>Displayed</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${votesReviewMovie == null}">
                                                                    <td colspan="7">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${votesReviewMovie != null}">
                                                                    <c:forEach var="vrm" items="${votesReviewMovie.content}">
                                                                        <tr>
                                                                            <td>
                                                                                <p title="${vrm.review.nameReview}">
                                                                                    <c:if test="${vrm.review.nameReview.length() <= 22}">
                                                                                        ${vrm.review.nameReview.substring(0,vrm.review.nameReview.length())}
                                                                                    </c:if>
                                                                                    <c:if test="${vrm.review.nameReview.length() > 22}">
                                                                                        ${vrm.review.nameReview.substring(0,22)}...
                                                                                    </c:if>
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <c:if test="${vrm.starNumber == null || vrm.starNumber == 0}">
                                                                                    No Star
                                                                                </c:if>
                                                                                <c:if test="${vrm.starNumber != null}">
                                                                                    <c:forEach begin="1" end="${vrm.starNumber}">
                                                                                        <i class="mdi mdi-star-circle"></i>
                                                                                    </c:forEach>
                                                                                </c:if>

                                                                            </td>
                                                                            <td>${vrm.comment}</td>
                                                                            <td>${vrm.account.customer.customerName}</td>
                                                                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${vrm.voteDate}" /></td>
                                                                            <td>
                                                                                <c:if test="${vrm.display == true}">
                                                                                    Displayed
                                                                                </c:if>
                                                                                <c:if test="${vrm.display == false}">
                                                                                    Hiddened
                                                                                </c:if>
                                                                            </td>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/admin/displayVoteReviewMovie/${vrm.id}" >
                                                                                    <c:if test="${vrm.display == true}">
                                                                                        <i class="fas fa-eye-slash" title="Hidden" style="color: black;"></i>
                                                                                    </c:if>
                                                                                    <c:if test="${vrm.display == false}">
                                                                                        <i class="fas fa-eye" title="Display" style="color: black;"></i>
                                                                                    </c:if>

                                                                                </a>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:if>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${votesReviewMovie != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'votes_review_movie'}">votesReviewMovie?</c:if><c:if test="${action == 'search_votes_review_movie'}">searchVotesReviewMovie?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">

                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'votes_review_movie'}">votesReviewMovie?</c:if><c:if test="${action == 'search_votes_review_movie'}">searchVotesReviewMovie?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'votes_review_movie'}">votesReviewMovie?</c:if><c:if test="${action == 'search_votes_review_movie'}">searchVotesReviewMovie?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
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