<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Quên mật khẩu</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="<c:url value="/resources/style/css/forgot_password.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/forgot_password_responsive.css" />">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
    </head>
    <body>
        <div class="container-fluid">
            <div class="row ">
                <div class="col-4 imageLogin" >
                    <img src="${pageContext.request.contextPath}/resources/images/banner_forgot_pass.gif" alt="">
                </div>
                <div class="col-8 contentLogin">
                    <div class="row logoLogin text-center">
                        <div class="col">
                            <img src="${pageContext.request.contextPath}/resources/images/favicon.png" class="img-fluid"  alt="">
                            <h6>DoubleT Cinema</h6>
                        </div>
                    </div>
                    <hr style="border: 10px double black;">
                    <div class="row headerPage text-center">
                        <div class="col">
                            <h5>Quên mật khẩu</h5>
                        </div>
                    </div>
                    <hr style="border: 10px double black;width: 55%;">
                    <div class="row formForgotPass mt-4 justify-content-center">
                        <div class="col-7">
                            <c:if test="${enterEmail == true}">
                                <mvc:form action="${pageContext.request.contextPath}/sendCodeByEmail" method="POST">
                                    <div class="form-group">
                                        <label for="email">Email: </label>
                                        <input type="text" class="form-control" name="email" id="email" 
                                               placeholder="Nhập email của bạn" value="${sessionScope.email}">
                                        <small  class="form-text text-danger">${messageEmail}</small>
                                    </div>
                                    <div class="row buttonConfirm mt-3 mb-3">
                                        <div class="col">
                                            <button class="btn"><i class="fas fa-check-circle"></i> Gửi mã xác nhận</button>
                                        </div>
                                    </div>
                                </mvc:form>
                            </c:if>
                            <c:if test="${sendConfirmCode == true}">
                                <mvc:form action="${pageContext.request.contextPath}/sendConfirmCode" method="POST">
                                    <div class="form-group">
                                        <label for="confirmCode">Mã xác nhận: </label>
                                        <input type="text" class="form-control" name="confirmCode" 
                                               id="confirmCode" 
                                               placeholder="Nhập mã xác nhận đã được gửi về email của bạn"
                                               value="${confirmCode}">
                                        <small class="form-text text-danger">${messageConfirmCode}</small>
                                    </div>
                                    <div class="row buttonConfirm mt-3 mb-3">
                                        <div class="col">
                                            <button class="btn"><i class="fas fa-check-circle"></i> Xác nhận</button>
                                        </div>
                                    </div>
                                </mvc:form>
                            </c:if>
                            <c:if test="${enterNewPassword == true}">
                                <mvc:form action="${pageContext.request.contextPath}/setAgainPassword" method="POST">
                                    <div class="form-group">
                                        <label for="newPassword">Mật khẩu mới: </label>
                                        <input type="password" class="form-control" name="newPassword" id="newPassword" 
                                               placeholder="Nhập mật khẩu mới" value="${newPassword}">
                                        <small  class="form-text text-danger">${messageNewPassword}</small>
                                    </div>
                                    <div class="form-group">
                                        <label for="confirmNewPassword">Xác nhận mật khẩu mới: </label>
                                        <input type="password" class="form-control" name="confirmNewPassword" id="confirmNewPassword"
                                               placeholder="Nhập lại mật khẩu mới"
                                               value="${confirmNewPassword}">
                                        <small class="form-text text-danger">${messageConfirmNewPassword}</small>
                                    </div>
                                    <div class="row buttonConfirm mt-3 mb-3">
                                        <div class="col">
                                            <button class="btn"><i class="fas fa-wrench"></i> Đặt lại mật khẩu</button>
                                        </div>
                                    </div>
                                </mvc:form>

                                <div class="row" >
                                    <div class="col">
                                        <button onclick="location.href = '${pageContext.request.contextPath}/login'" class="btn btn-danger" style="width: 100%;"><i class="fas fa-backward"></i> Quay lại đăng nhập</button>
                                    </div>
                                </div>
                                <div class="row register text-center">
                                    <div class="col">
                                        Bạn chưa có tài khoản?<a href="${pageContext.request.contextPath}/view_register">Đăng ký ngay!</a>
                                    </div>
                                </div>
                            </c:if>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Optional JavaScript -->
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
    </body>
</html>