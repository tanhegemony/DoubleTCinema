<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'add_account'}">Add Account</c:if>
            <c:if test="${action == 'update_account'}">Update Account</c:if>
            </title>
        <jsp:include page="../../include/management/css.jsp" />
    </head>

    <body>
        <div class="container-scroller">
            <!-- header -->
            <jsp:include page="../../include/management/header.jsp" />
            <div class="container-fluid page-body-wrapper">
                <!-- Menu -->
                <jsp:include page="../../include/management/menu.jsp" />
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <!-- Nhập nội dung -->
                                    <div class="col-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center">
                                                    <c:if test="${action == 'add_account'}">Add Account</c:if>
                                                    <c:if test="${action == 'update_account'}">Update Account</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveAccount" 
                                                          modelAttribute="account"
                                                          enctype="multipart/form-data" method="POST">
                                                    <c:if test="${action == 'update_account'}">
                                                        <input type="hidden" name="id" value="${account.id}">
                                                        <input type="hidden" name="password" value="${account.password}">
                                                        <input type="hidden" name="createDate" value="${createdDate}">
                                                        <input type="hidden" name="customer.birthDate" value="${birthDate}">
                                                        <input type="hidden" name="imageAccount" value="${account.imageAccount}">
                                                        <input type="hidden" name="customer.id" value="${account.customer.id}">
                                                    </c:if>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="customer.customerEmail">Email: </label>
                                                                <input type="email" class="form-control" name="customer.customerEmail" 
                                                                       id="customer.customerEmail"  
                                                                       value="${account.customer.customerEmail}"
                                                                       placeholder="Nhập email của bạn">
                                                                <p class="card-description text-danger" >
                                                                    <mvc:errors path="customer.customerEmail" />
                                                                </p>
                                                                <c:if test="${messageCustomerEmail != ''}">
                                                                    <p class="card-description text-danger" >
                                                                        ${messageCustomerEmail}
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="customer.customerPhone">Phone Number: </label>
                                                                <input type="text" class="form-control" name="customer.customerPhone" id="customer.customerPhone"
                                                                       value="${account.customer.customerPhone}" placeholder="Nhập số điện thoại của bạn">
                                                                <p class="card-description text-danger" >
                                                                    <mvc:errors path="customer.customerPhone" />
                                                                </p>
                                                                <c:if test="${messagePhoneNumber != ''}">
                                                                    <p class="card-description text-danger" >
                                                                        ${messagePhoneNumber}
                                                                    </p>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <c:if test="${action == 'add_account'}">
                                                        <div class="form-group">
                                                            <label for="password">Password:</label>
                                                            <input type="password" class="form-control" placeholder="Password" name="password">
                                                            <p class="card-description text-danger">
                                                                <mvc:errors path="password" />
                                                            </p>
                                                            <c:if test="${messagePassword != ''}">
                                                                <p class="card-description text-danger" >
                                                                    ${messagePassword}
                                                                </p>
                                                            </c:if>
                                                        </div>
                                                    </c:if>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="customer.customerName">Customer Name: </label>
                                                                <input type="text" class="form-control" name="customer.customerName"
                                                                       value="${account.customer.customerName}" id="customer.customerName" 
                                                                       placeholder="Nhập tên của bạn">
                                                                <p class="card-description text-danger" >
                                                                    <mvc:errors path="customer.customerName" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="customer.birthDate">Birthdate: </label>
                                                                <input type="date" pattern="yyyy-MM-dd" class="form-control" name="customer.birthDate"
                                                                       value="<c:if test="${birthDate != null}">${birthDate}</c:if>" id="customer.birthDate">
                                                                       <p class="card-description text-danger" >
                                                                       <mvc:errors path="customer.birthDate" />
                                                                </p>
                                                            </div> 
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="imageAcc">Image Account:</label>
                                                                <input type="file" class="form-control-file" name="imageAcc" id="imageAcc">
                                                                <small class="text-danger">${messageImageAcc}</small>
                                                            </div>
                                                        </div>
                                                        <c:if test="${action == 'update_account'}">
                                                            <div class="col-6 text-center">
                                                                <img style="width: 30%;" src="${pageContext.request.contextPath}/resources/images/user/${account.imageAccount}" class="img-fluid" alt="">
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="form-inline">
                                                        <p for="birthDate">Gender: </p>
                                                        <div class="row">
                                                            <c:forEach var="gd" items="${genders}">
                                                                <div class="col-2">
                                                                    <div class="form-check">
                                                                        <label class="form-check-label">
                                                                            <input type="radio" class="form-check-input" name="customer.gender" id="customer.gender" 
                                                                                   value="${gd}" <c:if test="${gd == 'MALE' || gd == account.customer.gender}">checked</c:if>>
                                                                            ${gd}
                                                                        </label>
                                                                    </div>
                                                                </div>
                                                            </c:forEach>
                                                            <p class="card-description text-danger" >
                                                                <mvc:errors path="customer.gender" />
                                                            </p>
                                                        </div>
                                                    </div>

                                                    <p>Chọn Roles:  <span style="color: red;">*</span>By default, every account has the USER role</p>
                                                    <c:forEach var="r" items="${roles}">
                                                        <div class="form-check">
                                                            <label class="form-check-label">
                                                                <input type="checkbox" class="form-check-input" name="rolesAcc" 
                                                                       <c:forEach var="roleAcc" items="${rolesAcc}">
                                                                           <c:if
                                                                               test="${r.id == roleAcc}">checked</c:if>
                                                                       </c:forEach>
                                                                       <c:if
                                                                           test="${r.existRoleAccount == true}">checked</c:if>
                                                                       <c:if test="${r.roleAccount == 'ROLE_USER'}">
                                                                           disabled checked
                                                                       </c:if>
                                                                       value="${r.id}">
                                                                ${r.roleAccount}
                                                            </label>
                                                        </div>
                                                    </c:forEach>
                                                    <c:if test="${message != null}">
                                                        <p style="color: red;">${message}</p>
                                                    </c:if>
                                                    <c:if test="${action == 'update_account'}">
                                                        <button type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>
                                                    </c:if>
                                                    <c:if test="${action == 'add_account'}">
                                                        <button type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/accounts" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
                                                </mvc:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- footer -->
                    <jsp:include page="../../include/management/footer.jsp" />
                </div>
            </div>
        </div>
        <jsp:include page="../../include/management/js.jsp" />
    </body>

</html>