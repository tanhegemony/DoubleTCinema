<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'customers'}">Customers</c:if>
            <c:if test="${action == 'search_customers'}">Search Customers</c:if>
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
                <!-- Menu -->
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
                                                <h4 class="card-title text-center">Customers</h4>
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
                                                                <b>  customers </b>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="searchCustomers" method="GET">
                                                                <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                    <label>
                                                                        <input type="text" class="form-control" name="searchValue"
                                                                               id="searchValue" style="min-width: 15rem;" placeholder="Input Name Or Email Or Phone" value="${searchValue}">
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
                                                                        <th>Customer Name</th>
                                                                        <th>Customer Email</th>
                                                                        <th>Customer Phone</th>
                                                                        <th>BirthDate</th>
                                                                        <th>Gender</th>
                                                                        <th>Customer Address</th>
                                                                        <th>Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${customers == null}">
                                                                    <td colspan="7">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${customers != null}">
                                                                    <c:forEach var="c" items="${customers.content}">
                                                                        <tr>
                                                                            <td>${c.customerName}</td>
                                                                            <td>${c.customerEmail}</td>
                                                                            <td>0${c.customerPhone}</td>
                                                                            <td>
                                                                                <c:if test="${c.birthDate != null}">
                                                                                    <p>${c.birthDate}</p>
                                                                                </c:if>
                                                                                <c:if test="${c.birthDate == null || c.birthDate == ''}">
                                                                                    <p style="color: red;">No Data BirthDate</p>
                                                                                </c:if> 
                                                                            </td>
                                                                            <td>
                                                                                <c:if test="${c.gender != null}">
                                                                                    <p>${c.gender}</p>
                                                                                </c:if>
                                                                                <c:if test="${c.gender == null || c.gender == ''}">
                                                                                    <p style="color: red;">No Data Gender</p>
                                                                                </c:if> 
                                                                            </td>
                                                                            <td style="
                                                                                   max-width: 200px;
                                                                                   overflow-x:auto;">
                                                                                <c:if test="${c.customerAddress != null}">
                                                                                    <p>${c.customerAddress}</p>
                                                                                </c:if>
                                                                                <c:if test="${c.customerAddress == null || c.customerAddress == ''}">
                                                                                    <p style="color: red;">No Data CustomerAddress</p>
                                                                                </c:if> 
                                                                            </td>
                                                                            <td>
                                                                                <a href="${pageContext.request.contextPath}/admin/viewBookingsOfCustomer/${c.id}" style="color: black;text-decoration: none;"><i class="fas fa-eye"></i> View Bookings</a> <br>
                                                                                <a class="btn mt-2" title="Edit Customer" href="<c:url value="editCustomer/${c.id}" />"><i class="mdi mdi mdi-border-color" id="color-icon"></i></a>
                                                                                <c:if test="${c.account.id != accountLogin.id && c.bookings.size() == 0}">
                                                                                <a class="btn mt-2" title="Delete Customer" onclick="return confirm('Are you sure you want to remove Customer [${c.customerEmail}]?')" 
                                                                                       href="<c:url value="deleteCustomer/${c.id}" />"><i class="icon-trash" id="color-icon"></i></a>
                                                                                    </c:if>
                                                                                    <c:if test="${c.account.id == accountLogin.id || c.bookings.size() > 0}">
                                                                                    <a type="button" data-toggle="modal" class="btn mt-2" title="Delete Customer"
                                                                                       data-target="#confirmModal<c:if test="${c.account.id == accountLogin.id && c.bookings.size() > 0}">1</c:if><c:if test="${c.account.id != accountLogin.id && c.bookings.size() > 0}">2</c:if>">
                                                                                           <i class="icon-trash" id="color-icon"></i>
                                                                                       </a>
                                                                                       <div class="modal fade" 
                                                                                            id="confirmModal<c:if test="${c.account.id == accountLogin.id && c.bookings.size() > 0}">1</c:if><c:if test="${c.account.id != accountLogin.id && c.bookings.size() > 0}">2</c:if>" tabindex="-1" aria-labelledby="confirmModalLabel" 
                                                                                           aria-hidden="true">
                                                                                           <div class="modal-dialog">
                                                                                               <div class="modal-content">
                                                                                                   <div class="modal-header">
                                                                                                       <h5 class="modal-title" id="confirmModalLabel">Notify</h5>
                                                                                                       <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                                                                           <span aria-hidden="true">&times;</span>
                                                                                                       </button>
                                                                                                   </div>
                                                                                                   <div class="modal-body">
                                                                                                   <c:if test="${c.account.id == accountLogin.id}">
                                                                                                       This customer is the current account <span style="color:red;">LOGIN</span>. You can not remove it!
                                                                                                   </c:if>
                                                                                                   <c:if test="${c.account.id != accountLogin.id && c.bookings.size() > 0}">
                                                                                                       This customer already has <span style="color:red;">data Booking</span>. You can not remove it!
                                                                                                   </c:if>
                                                                                               </div>
                                                                                               <div class="modal-footer">
                                                                                                   <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                                                                                               </div>
                                                                                           </div>
                                                                                       </div>
                                                                                    </div>
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
                                                <c:if test="${customers != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'customers'}">customers?</c:if><c:if test="${action == 'search_customers'}">searchCustomers?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">
                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'customers'}">customers?</c:if><c:if test="${action == 'search_customers'}">searchCustomers?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'customers'}">customers?</c:if><c:if test="${action == 'search_customers'}">searchCustomers?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
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