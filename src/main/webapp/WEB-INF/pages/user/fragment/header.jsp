<%-- 
    Document   : header
    Created on : Jul 23, 2022, 5:12:05 PM
    Author     : tanhegemony
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<link rel="stylesheet" href="<c:url value="/resources/style/fragment/header.css" />"/>
<link rel="stylesheet" href="<c:url value="/resources/style/fragment/header_responsive.css" />"/>
<div class="container-fluid header">
    <div class="row justify-content-center">
        <div class="col-2 logo mt-2 mb-2">
            <a href="${pageContext.request.contextPath}"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/doubleTCinesmaLogo.png" alt=""></a>
        </div>
        <div class="col-7 mt-4 search">
            <form action="${pageContext.request.contextPath}/search_movie" method="GET">
                <div class="form-inline">
                    <input type="text" class="form-control" name="searchValue" id="searchValue" value="${searchValue}"
                           placeholder="Tìm kiếm diễn viên hoặc tên phim bằng tiếng việt / tiếng anh">
                    <button class="btn" style="color: white;"><i class="fas fa-search"></i></button>
                </div>
            </form>
        </div>
        <div class="col-3 menu1">
            <div class="row">
                <div class="col">
                    <ul class="nav">
                        <li class="nav-item dropleft userLogin">
                            <sec:authorize access="isAuthenticated()">
                                <div class="dropdown dropleft">
                                    <button class="btn dropdown-toggle" type="button" data-toggle="dropdown" aria-expanded="false">
                                        <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/user/<c:if test="${account.imageAccount == null}">no_image_user.png</c:if><c:if test="${account.imageAccount != null}">${account.imageAccount}</c:if>" alt=""> ${username}
                                        </button>
                                        <div class="dropdown-menu text-center">
                                        <sec:authorize access="hasRole('ROLE_ADMIN')">
                                            <a class="dropdown-item" target="_blank" href="${pageContext.request.contextPath}/admin/home">
                                                <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/admin.png" alt=""> Quản trị dành cho Admin</a>
                                            <div class="dropdown-divider"></div>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_MANAGER')">
                                            <a class="dropdown-item" target="_blank" href="${pageContext.request.contextPath}/admin/home">
                                                <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/manager.png" alt=""> Quản trị dành cho Manager</a>
                                            <div class="dropdown-divider"></div>
                                        </sec:authorize>
                                        <sec:authorize access="hasRole('ROLE_RECEPTIONIST')">
                                            <a class="dropdown-item" target="_blank" href="${pageContext.request.contextPath}/admin/home">
                                                <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/receptionist.png" alt=""> Quản trị dành cho Receptionist</a>
                                            <div class="dropdown-divider"></div>
                                        </sec:authorize>

                                        <a <c:if test="${contentNavManageUser == 'manageCustomer'}">style="background-color: #a9a6a6;"</c:if> class="dropdown-item" href="${pageContext.request.contextPath}/manage_user?contentNavManageUser=manageCustomer">
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/user-info.png" alt=""> Quản lý thông tin cá nhân</a>
                                        <div class="dropdown-divider"></div>
                                        <a <c:if test="${contentNavManageUser == 'manageTransactionHistory'}">style="background-color: #a9a6a6;"</c:if> class="dropdown-item" href="${pageContext.request.contextPath}/manage_user?contentNavManageUser=manageTransactionHistory">
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/transaction-history.png" alt=""> Quản lý lịch sử giao dịch</a>
                                        <div class="dropdown-divider"></div>
                                        <a <c:if test="${contentNavManageUser == 'manageAccountBanking'}">style="background-color: #a9a6a6;"</c:if> class="dropdown-item" href="${pageContext.request.contextPath}/manage_user?contentNavManageUser=manageAccountBanking"> 
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/account-banking.png" alt=""> Quản lý tài khoản ngân hàng</a>
                                        <div class="dropdown-divider"></div>
                                        <a class="dropdown-item" href="<c:url value="/logout?logoutStatus=true" />">
                                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/logout.png" alt=""> Đăng xuất</a>
                                    </div>
                                </div>
                            </sec:authorize>
                            <sec:authorize access="!isAuthenticated()">
                                <a class="nav-link" href="<c:url value="/login" />"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/login.png" alt=""> Đăng nhập</a> <br>

                            </sec:authorize>
                        </li>
                        <sec:authorize access="!isAuthenticated()">
                        <li class="nav-item dropleft userLogin">
                            <a class="nav-link" href="<c:url value="/view_register" />"><img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/register.png" alt=""> Đăng ký</a>
                        </li>
                        </sec:authorize>
                    </ul>
                </div>
            </div>

        </div>
    </div>
</div>
