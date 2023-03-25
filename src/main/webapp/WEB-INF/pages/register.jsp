<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>
<html lang="en">
    <head>
        <title>Đăng ký</title>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" href="<c:url value="/resources/style/css/login.css" />">
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/register_responsive.css" />">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
    </head>
    <body>
        <div class="container-fluid">
            <div class="row ">
                <div class="col-5 imageLogin" >
                    <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/resources/images/gifLogin.gif" alt=""></a>
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
                            <c:if test="${displayCheckAccountBySendMail == false}">
                                <form action="${pageContext.request.contextPath}/register" method="post">
                                    <div class="form-group">
                                        <label for="customerEmail">Email: </label>
                                        <input type="email" class="form-control" name="customerEmail" id="customerEmail"  value="${customerEmail}"
                                               placeholder="Nhập email của bạn" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="customerPhone">Phone Number: </label>
                                        <input type="text" class="form-control" name="customerPhone" id="customerPhone"
                                               value="${customerPhone}" placeholder="Nhập số điện thoại của bạn" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="customerName">FullName: </label>
                                        <input type="text" class="form-control" name="customerName"
                                                value="${customerName}" id="customerName" placeholder="Nhập tên của bạn" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="password">Password: (Minimum 6 characters, least one uppercase, least one lowercase, least one digit, least one special character!!)</label>
                                        <input type="password" class="form-control" name="password" id="password" placeholder="Nhập password đăng nhập" required>
                                    </div>
                                    <div class="form-group">
                                        <label for="confirmPassword">Confirm Password: </label>
                                        <input type="password" class="form-control" name="confirmPassword" id="confirmPassword" placeholder="Nhập lại password" required>
                                    </div>
                                    <c:if test="${message != null && message != ''}">
                                        <h1  style="color: red;font-size: 15px;">${message}</h1>
                                    </c:if>
                                    <div class="row buttonLogin mt-3">
                                        <div class="col">
                                            <button class="btn"><i class="fas fa-sign-in-alt"></i> Đăng ký</button>
                                        </div>
                                    </div>
                                    <div class="row register text-center">
                                        <div class="col">
                                            Bạn đã có tài khoản?<a href="${pageContext.request.contextPath}/login">Đăng nhập ngay!</a>
                                        </div>
                                    </div>
                                </form>
                            </c:if>
                            <c:if test="${displayCheckAccountBySendMail == true}">
                                <form action="${pageContext.request.contextPath}/checkAccountBySendEmail" method="post" >
                                    <div>
                                        <span id="time">01:00</span><b style="color: red;font-size: 13px;">(Mã có hiệu lực trong vòng 1 phút - sau 1 phút sẽ quay lại trang <a href="view_register" style="color: #31d7a9;">đăng ký</a>)</b>
                                    </div>
                                    <script>
                                        function startTimer(duration, display) {
                                            var timer = duration,
                                                    minutes, seconds;
                                            setInterval(function () {
                                                minutes = parseInt(timer / 60, 10);
                                                seconds = parseInt(timer % 60, 10);

                                                minutes = minutes < 10 ? "0" + minutes : minutes;
                                                seconds = seconds < 10 ? "0" + seconds : seconds;

                                                display.textContent = minutes + ":" + seconds;

                                                if (--timer < 0) {
                                                    timer = duration;
                                                }
                                                if (timer == 0) {
                                                    window.location.href = 'view_register';
                                                }
                                            }, 1000);
                                        }

                                        window.onload = function () {
                                            var fifteenMinutes = 60 * 1,
                                                    display = document.querySelector('#time');
                                            startTimer(fifteenMinutes, display);
                                        };
                                    </script>
                                    <div class="form-group">
                                        <label style="color: red;">Bạn vui lòng kiểm tra Email mà bạn vừa đăng ký để nhận mã xác nhận!</label>
                                        <input type="text" style="color: black;border: 1px solid gray;"  
                                               class="form-control" maxlength="6" name="codeRandomCheck" 
                                               placeholder="Code Confirm Register" required>

                                    </div>

                                    <c:if test="${message != null && message != ''}">
                                        <h1  style="color: red;font-size: 15px;">${message}</h1>
                                    </c:if>
                                    <div class="mt-3">
                                        <input  class="btn" 
                                                style="background-color: #001232;border: 1px solid #001232;color: white;" 
                                                type="submit" value="Xác nhận">
                                    </div>
                                </form>
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