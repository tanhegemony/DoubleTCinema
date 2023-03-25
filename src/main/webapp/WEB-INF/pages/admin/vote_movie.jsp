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
            <c:if test="${action == 'votes'}">Votes Movie</c:if>
            <c:if test="${action == 'search_votes'}">Search Votes Movie</c:if>
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
                                                <h4 class="card-title text-center">Votes Movie</h4>
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
                                                                <b>  votes movie </b>

                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="searchVotes" method="GET">
                                                                <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                    <label>
                                                                        <input type="text" class="form-control" name="searchValue"
                                                                               id="searchValue" style="min-width: 25rem;" placeholder="Enter NameMovie Or CustomerName Or StarNumber" value="${searchValue}">
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
                                                                        <th>Movie Name</th>
                                                                        <th>Star Number</th>
                                                                        <th>Comment</th>
                                                                        <th>Voter</th>
                                                                        <th>Vote Date</th>
                                                                        <th>Displayed</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${votes == null}">
                                                                    <td colspan="7">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${votes != null}">
                                                                    <c:forEach var="v" items="${votes.content}">
                                                                        <tr>
                                                                            <td>
                                                                                <p title="${v.movie.nameByEnglish}">
                                                                                    <c:if test="${v.movie.nameByEnglish.length() <= 22}">
                                                                                        ${v.movie.nameByEnglish.substring(0,v.movie.nameByEnglish.length())}
                                                                                    </c:if>
                                                                                    <c:if test="${v.movie.nameByEnglish.length() > 22}">
                                                                                        ${v.movie.nameByEnglish.substring(0,22)}...
                                                                                    </c:if>
                                                                                </p>
                                                                            </td>
                                                                            <td>
                                                                                <c:if test="${v.starNumber == null || v.starNumber == 0}">
                                                                                    No Star
                                                                                </c:if>
                                                                                <c:if test="${v.starNumber != null}">
                                                                                    <c:forEach begin="1" end="${v.starNumber}">
                                                                                        <i class="mdi mdi-star-circle"></i>
                                                                                    </c:forEach>
                                                                                </c:if>

                                                                            </td>
                                                                            <td>${v.comment}</td>
                                                                            <td>${v.account.customer.customerName}</td>
                                                                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${v.voteDate}" /></td>
                                                                            <td>
                                                                                <c:if test="${v.display == true}">
                                                                                    Displayed
                                                                                </c:if>
                                                                                <c:if test="${v.display == false}">
                                                                                    Hiddened
                                                                                </c:if>
                                                                            </td>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/admin/displayVoteMovie/${v.id}" >
                                                                                    <c:if test="${v.display == true}">
                                                                                        <i class="fas fa-eye-slash" title="Hidden" style="color: black;"></i>
                                                                                    </c:if>
                                                                                    <c:if test="${v.display == false}">
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
                                                <c:if test="${votes != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'votes'}">votes?</c:if><c:if test="${action == 'search_votes'}">searchVotes?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">

                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'votes'}">votes?</c:if><c:if test="${action == 'search_votes'}">searchVotes?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'votes'}">votes?</c:if><c:if test="${action == 'search_votes'}">searchVotes?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
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