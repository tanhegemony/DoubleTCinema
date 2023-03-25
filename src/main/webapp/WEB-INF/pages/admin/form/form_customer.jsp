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
        <title>Update Customer</title>
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
                                                <h5 class="card-title text-center">Update Customer Information</h5>
                                                <div class="row">
                                                    <div class="col-2">
                                                        <div class="form-group">
                                                            <label for="customerID">Customer ID: </label>
                                                            <input type="text" class="form-control" value="${customer.id}" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-4">
                                                        <div class="form-group">
                                                            <label for="customerEmail">Customer Email: </label>
                                                            <input type="text" class="form-control" value="${customer.customerEmail}" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-2">
                                                        <div class="form-group">
                                                            <label for="customerPhone">Customer Phone: </label>
                                                            <input type="text" class="form-control" value="${customer.customerPhone}" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-4">
                                                        <div class="form-group">
                                                            <label for="customerName">Customer Name: </label>
                                                            <input type="text" class="form-control" value="${customer.customerName}" readonly>
                                                        </div>
                                                    </div>
                                                    <div class="col-4">
                                                        <div class="form-group">
                                                            <label for="birthDate">Birthdate: </label>
                                                            <input type="date" pattern="yyyy-MM-dd" class="form-control" value="${customer.birthDate}" readonly>
                                                        </div> 
                                                    </div>
                                                    <div class="col-4">
                                                        <div class="form-group">
                                                            <label for="gender">Gender: </label>
                                                            <input type="text" class="form-control" value="${customer.gender}" readonly>
                                                        </div> 
                                                    </div>
                                                    <div class="col-4" style="margin-top: 2rem;">
                                                        <a onclick="return alert('The action is beyond the scope of the account. You need to be logged in as ROLE ADMIN to be able to manipulate this content!')"   class="btn btn-danger" style="color: white;"><i class="fas fa-user-edit"></i> Edit</a>
                                                    </div>
                                                </div>
                                                <h5 class="card-title text-center">Information Other Of Customer</h5>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveCustomer" 
                                                          modelAttribute="customer">
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <input type="hidden" class="form-control" name="id" value="${customer.id}">
                                                                <input type="hidden" class="form-control" name="customerEmail" value="${customer.customerEmail}">
                                                                <input type="hidden" class="form-control" name="customerPhone" value="${customer.customerPhone}">
                                                                <input type="hidden" class="form-control" name="customerName" value="${customer.customerName}">
                                                                <input type="hidden" class="form-control" name="birthDate" value="${customer.birthDate}">
                                                                <input type="hidden" class="form-control" name="gender" value="${customer.gender}">
                                                                <input type="hidden" class="form-control" name="account.id" value="${customer.account.id}">
                                                            </div>
                                                            <div class="form-group">
                                                                <label for="customerAddress">Customer Address: </label>
                                                                <textarea class="form-control" name="customerAddress" id="customerAddress" style="height: 8rem;"
                                                                          placeholder="Nhập address của bạn">${customer.customerAddress}</textarea>
                                                                <p class="card-description text-danger" >
                                                                    <mvc:errors path="customerAddress" />
                                                                </p>
                                                            </div>
                                                            <c:if test="${message != null}">
                                                                <p style="color: red;">${message}</p>
                                                            </c:if>
                                                            <button type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>
                                                            <a href="${pageContext.request.contextPath}/admin/customers" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
                                                        </div>
                                                    </div>
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