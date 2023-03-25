

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Complete Checkout Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <style>
            body {
                font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
                background-color: #001232;
            }
        </style>

    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container content mt-3">
            <div class="row" style="margin-top: 2rem;">
                <div class="col" style="padding: 5px 5px 5px 5px;box-shadow: 5px 5px 5px 5px white;">
                    <p style="color: white;">Chúc mừng bạn, bạn đã mua vé thành công ! Bạn có thể xem trong 
                        <a href="#" style="color: #31d7a9;text-transform: uppercase;font-weight: bolder;font-family: monospace;">Lịch sử giao dịch</a> để nắm thông tin mà bạn đã mua vé ! <br>
                        Mọi chi tiết thắc mặc, bạn có thể liên hệ tới tổng đài 
                        của DoubleT Cinema <a href="tel:0376160960" style="color: #31d7a9;">0376160960 (Tấn Hegemony)</a> hoặc 
                        <a href="tel:0795768338" style="color: #31d7a9;">0795768338 (Tự Chicken)</a></p>
                    <a href="${pageContext.request.contextPath}" style="color: #31d7a9;">Quay lại trang chủ</a>

                </div>
            </div>
            <div class="row text-center">
                <div class="col">
                    <img class="img-fluid" style="width: 20rem;" src="${pageContext.request.contextPath}/resources/images/complete-checkout.gif" alt="">
                </div>
            </div>
        </div>
        <!-- footer -->
        <jsp:include page="../user/fragment/footer.jsp" />
        <!-- scroll -->
        <jsp:include page="../user/fragment/scroll.jsp" />
        <script src="<c:url value="/webjars/jquery/3.6.0/jquery.min.js"/>"></script>
        <!--jQuery first, then Popper.js, then Bootstrap JS--> 
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
        </script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
        </script>
    </body>
</html>
