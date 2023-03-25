<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Đăng nhập</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="<c:url value="/resources/style/css/login.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/login_responsive.css" />">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
    </head>
    <body>
        <div class="container-fluid">
            <div class="row ">
                <div class="col-5 imageLogin" >
                    <img src="${pageContext.request.contextPath}/resources/images/gifLogin.gif" alt="">
                </div>
                <div class="col-7 contentLogin">
                    <div class="row logoLogin text-center">
                        <div class="col">
                            <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/resources/images/favicon/favicon.png" class="img-fluid"  alt=""></a>
                            <a href="${pageContext.request.contextPath}/home"><h6>DoubleT Cinema</h6></a>
                        </div>
                    </div>
                    <div class="row formLogin mt-4 justify-content-center">
                        <div class="col-6">
                            <form action="j_spring_security_check"" method="post">
                                <div class="form-group">
                                    <label for="email">Email: </label>
                                    <input type="text" class="form-control" name="email" 
                                           id="email" placeholder="Nhập email đăng nhập" value="${email}" required>
                                </div>
                                <div class="form-group">
                                    <label for="password">Password: </label>
                                    <input type="password" class="form-control" name="password" 
                                           id="password" placeholder="Nhập password đăng nhập" required>
                                </div>
                                <c:if test="${message != null && message != ''}">
                                    <h1  style="color: red;font-size: 15px;">${message}</h1>
                                </c:if>
                                <div class="row mt-4 text-center">
                                    <div class="col-6">
                                        <div class="form-check">
                                            <label class="form-check-label">
                                                <input type="checkbox" class="form-check-input" name="remember" 
                                                       id="remember">
                                                Nhớ mật khẩu
                                            </label>
                                        </div>
                                    </div>
                                    <div class="col-6">
                                        <a href="${pageContext.request.contextPath}/forgotPassword" >Quên mật khẩu</a>
                                    </div>
                                </div>
                                <div class="row buttonLogin mt-3">
                                    <div class="col">
                                        <button class="btn"><i class="fas fa-sign-in-alt"></i> Đăng nhập</button>
                                    </div>
                                </div>
                                <div class="row register text-center">
                                    <div class="col">
                                        Bạn chưa có tài khoản?<a href="${pageContext.request.contextPath}/view_register">Đăng ký ngay!</a>
                                    </div>
                                </div>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            </form>
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