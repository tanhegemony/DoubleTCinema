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
            <c:if test="${action == 'promotions'}">Promotions</c:if>
            <c:if test="${action == 'search_promotions'}">Search Promotions</c:if>
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
                                                <h4 class="card-title text-center">Promotions</h4>
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
                                                                <b>  promotions </b>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="searchPromotions" method="GET">
                                                                <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                    <label>
                                                                        <input type="text" class="form-control" name="searchValue"
                                                                               id="searchValue" placeholder="Enter Promotion Code" value="${searchValue}">
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
                                                        <a href="<c:url value="/admin/addPromotion" />"><i class="icon-plus" id="color-icon" style="font-size: 1.25rem;color: white;"></i></a>
                                                    </div>
                                                </div>                            
                                                <div class="row">   
                                                    <div class="col-sm-12 mt-2" >
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-bordered text-center">
                                                                <thead>
                                                                    <tr style="background-color: #1f3bb3; color: white;">
                                                                        <th>Promotion ID</th>
                                                                        <th>Promotion Code</th>
                                                                        <th>Promotion Value</th>
                                                                        <th>Effective Date</th>
                                                                        <th>Expiry Date</th>
                                                                        <th><a href="${pageContext.request.contextPath}/admin/addPromotion"><i class="icon-plus" id="color-icon" style="font-size: 1.25rem;color: white"></i></a></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${promotions == null}">
                                                                    <td colspan="6">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${promotions != null}">
                                                                    <c:forEach var="p" items="${promotions}">
                                                                        <tr>
                                                                            <td>${p.id}</td>
                                                                            <td>
                                                                                <p>${p.code}</p>
                                                                                <p><a style="color: black;text-decoration: none;" href="${pageContext.request.contextPath}/admin/viewBookingsOfPromotion/${p.id}"><i class="fas fa-eye"></i> View Bookings</a></p>
                                                                            </td>
                                                                            <td><fmt:formatNumber  type="number" value="${p.valuePromotion}"/>đ</td>
                                                                            <td>${p.effectiveDate}</td>
                                                                            <td>
                                                                                <c:if test="${p.expiryDate == null}">
                                                                                    <b class="text-danger">No Expiry Date</b>
                                                                                </c:if>
                                                                                <c:if test="${p.expiryDate != null}">
                                                                                    ${p.expiryDate}
                                                                                </c:if>
                                                                            </td>
                                                                            <td class="jsgrid-align-center" style="text-align: center">
                                                                                <a href="${pageContext.request.contextPath}/admin/editPromotion/${p.id}"><i class="mdi mdi mdi-border-color" id="color-icon"></i></a>
                                                                                <c:if test="${p.used == true}">
                                                                                    <a onclick="return confirm('Can not to removie promotion [${p.code}]! Because Promotion [${p.code}] is already in use!')"><i class="icon-trash" id="color-icon"></i></a>
                                                                                    </c:if>
                                                                                    <c:if test="${p.used == false}">
                                                                                    <a onclick="return confirm('Are you sure you want to remove promotion [${p.code}]?')" href="<c:url value="deletePromotion/${p.id}" />"><i class="icon-trash" id="color-icon"></i></a>
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
                                                <c:if test="${promotions != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'promotions'}">promotions?</c:if><c:if test="${action == 'search_promotions'}">searchPromotions?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">

                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'promotions'}">promotions?</c:if><c:if test="${action == 'search_promotions'}">searchPromotions?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'promotions'}">promotions?</c:if><c:if test="${action == 'search_promotions'}">searchPromotions?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
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
                    <jsp:include page="../include/management/footer.jsp" />
                </div>
            </div>
        </div>
        <jsp:include page="../include/management/js.jsp" />
    </body>
</html>