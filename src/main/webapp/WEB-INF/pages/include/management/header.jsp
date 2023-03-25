<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!-- partial:partials/_navbar.html -->
<nav class="navbar default-layout col-lg-12 col-12 p-0 fixed-top d-flex align-items-top flex-row">
    <div class="text-center navbar-brand-wrapper d-flex align-items-center justify-content-start">
        <div class="me-3">
            <button class="navbar-toggler navbar-toggler align-self-center" type="button" data-bs-toggle="minimize">
                <span class="icon-menu"></span>
            </button>
        </div>
        <div>
            <a class="navbar-brand brand-logo" href="${pageContext.request.contextPath}/admin/home">
                <h4>DoubleT Cinema</h4>
            </a>
        </div>
    </div>
    <div class="navbar-menu-wrapper d-flex align-items-top">

        <ul class="navbar-nav ms-auto">
            <li class="nav-item dropdown d-none d-lg-block user-dropdown">
                <a class="nav-link" id="UserDropdown" href="#" data-bs-toggle="dropdown" aria-expanded="false">
                    <img class="img-xs rounded-circle" src="${pageContext.request.contextPath}/resources/images/user/${accountLogin.imageAccount}" alt="Profile image"> </a>
                <div class="dropdown-menu dropdown-menu-right navbar-dropdown" aria-labelledby="UserDropdown">
                    <div class="dropdown-header text-center">
                        <img class="img-xs rounded-circle" src="<c:url value="/resources/images/user/${accountLogin.imageAccount}"/>" alt="Profile image">
                        <p class="mb-1 mt-3 font-weight-semibold">${accountLogin.customer.customerName}</p>
                        <p class="fw-light text-muted mb-0">${accountLogin.customer.customerEmail}</p>
                    </div>
                        <a href="${pageContext.request.contextPath}/manage_user" target="_blank" class="dropdown-item"><i class="dropdown-item-icon mdi mdi-account-outline text-primary me-2"></i> Manage Your Profile</a>
                        <a class="dropdown-item" href="<c:url value="/logout?logoutStatus=true" />"><i class="dropdown-item-icon mdi mdi-power text-primary me-2"></i>Logout</a>
                </div>
            </li>
        </ul>
        <button class="navbar-toggler navbar-toggler-right d-lg-none align-self-center" type="button" data-bs-toggle="offcanvas">
            <span class="mdi mdi-menu"></span>
        </button>
    </div>
</nav>