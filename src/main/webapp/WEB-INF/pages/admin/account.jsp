<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'accounts'}">Accounts</c:if>
            <c:if test="${action == 'search_accounts'}">Search Accounts</c:if>
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
                                                <h4 class="card-title text-center">Accounts</h4>
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
                                                                <b>  accounts </b>

                                                            </div>
                                                        </div>

                                                        <div class="col-sm-12 col-md-6">
                                                            <form action="${pageContext.request.contextPath}/admin/searchAccounts" method="GET">
                                                            <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                <label>
                                                                    <input type="text" class="form-control" name="searchValue"
                                                                           id="searchValue" style="width: 21rem;" placeholder="Input name or email or phone number or role" value="${searchValue}">
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
                                                                        <th>Image</th>
                                                                        <th>Customer Name</th>
                                                                        <th>Email</th>
                                                                        <th>Phone Number</th>
                                                                        <th>Role</th>
                                                                        <th style="text-align: center"><a title="Add New Account" href="${pageContext.request.contextPath}/admin/addAccount"><i class="icon-plus" id="color-icon" style="font-size: 1.25rem;color: white;"></i></a></th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${accounts == null}">
                                                                    <td colspan="6">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${accounts != null}">
                                                                    <c:forEach var="a" items="${accounts.content}">
                                                                        <tr>
                                                                            <td class="py-1">
                                                                                <img src="${pageContext.request.contextPath}/resources/images/user/<c:if test="${a.imageAccount == null}">no_image_user.png</c:if><c:if test="${a.imageAccount != null}">${a.imageAccount}</c:if>" alt="image"/>
                                                                                </td>
                                                                                    <td>${a.customer.customerName}</td>
                                                                            <td>${a.customer.customerEmail}</td>
                                                                            <td>${a.customer.customerPhone}</td>
                                                                            <td>
                                                                                <c:forEach var="roleAccount" items="${a.rolesAccount}">
                                                                                    <c:if test="${roleAccount.role.roleAccount == 'ROLE_USER'}">
                                                                                        User
                                                                                    </c:if>
                                                                                    <c:if test="${roleAccount.role.roleAccount == 'ROLE_ADMIN'}">
                                                                                        Admin
                                                                                    </c:if>
                                                                                    <c:if test="${roleAccount.role.roleAccount == 'ROLE_RECEPTIONIST'}">
                                                                                        Receptionist
                                                                                    </c:if>
                                                                                    <c:if test="${roleAccount.role.roleAccount == 'ROLE_MANAGER'}">
                                                                                        Manager
                                                                                    </c:if>,
                                                                                </c:forEach>
                                                                            </td>
                                                                            <td class="jsgrid-align-center" style="text-align: center">
                                                                                <a href="<c:url value="editAccount/${a.id}" />"><i class="mdi mdi mdi-border-color" id="color-icon"></i></a>
                                                                                    <c:if test="${a.id != accountLogin.id && a.customer.bookings.size() == 0}">
                                                                                    <a onclick="return confirm('Are you sure you want to remove Account [${a.customer.customerEmail}]?')" 
                                                                                       href="<c:url value="deleteAccount/${a.id}" />"><i class="icon-trash" id="color-icon"></i></a>
                                                                                    </c:if>
                                                                                    <c:if test="${a.id == accountLogin.id || a.customer.bookings.size() > 0}">
                                                                                    <a type="button" data-toggle="modal" 
                                                                                       data-target="#confirmModal<c:if test="${a.id == accountLogin.id && a.customer.bookings.size() > 0}">1</c:if><c:if test="${a.id != accountLogin.id && a.customer.bookings.size() > 0}">2</c:if>">
                                                                                           <i class="icon-trash" id="color-icon"></i>
                                                                                       </a>
                                                                                       <div class="modal fade" 
                                                                                            id="confirmModal<c:if test="${a.id == accountLogin.id && a.customer.bookings.size() > 0}">1</c:if><c:if test="${a.id != accountLogin.id && a.customer.bookings.size() > 0}">2</c:if>" tabindex="-1" aria-labelledby="confirmModalLabel" 
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
                                                                                                   <c:if test="${a.id == accountLogin.id}">
                                                                                                       This account is the current account <span style="color:red;">LOGIN</span>. You can not remove it!
                                                                                                   </c:if>
                                                                                                   <c:if test="${a.id != accountLogin.id && a.customer.bookings.size() > 0}">
                                                                                                       This account already has <span style="color:red;">data Booking</span>. You can not remove it!
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
                                                <c:if test="${accounts != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'accounts'}">accounts?</c:if><c:if test="${action == 'search_accounts'}">searchAccounts?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">
                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'accounts'}">accounts?</c:if><c:if test="${action == 'search_accounts'}">searchAccounts?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'accounts'}">accounts?</c:if><c:if test="${action == 'search_accounts'}">searchAccounts?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
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