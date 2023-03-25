
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Checkout Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/checkout.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/checkout_responsive.css" />"/>


    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container content mt-3">
            <div class="row breadcrumbContent">
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i> Trang chủ</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="#"><i class="fas fa-money-check-alt"></i> Mua vé</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/booking?movieId=${sessionScope.movie.id}&cinemaId=${sessionScope.cinema.id}&showDate=${sessionScope.cinemaMovie.showDate}&showTime=${sessionScope.cinemaMovie.showTime}"><i class="fas fa-pen"></i> Thông tin đặt vé</a>
                            </li>
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/booking?movieId=${sessionScope.movie.id}&cinemaId=${sessionScope.cinema.id}&showDate=${sessionScope.cinemaMovie.showDate}&showTime=${sessionScope.cinemaMovie.showTime}"> <i class="fas fa-couch"></i> Chọn ghế</a>
                            </li>
                            <li class="breadcrumb-item active" aria-current="page">
                                <i class="fas fa-money-check"></i> Thanh toán -- Thông tin thanh toán
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row headerContent text-center">
                <div class="col">
                    <h4>Thông tin thanh toán</h4>
                    <hr style="border: 1px solid #032055; width: 10%" />
                </div>
            </div>
            <div class="row bodyCheckout">
                <div class="col-7 infoCustomer">
                    <h3 class="title-comm">
                        <span class="title-holder">Thông tin Khách hàng</span>
                    </h3>
                    <div class="row clock float-right">
                        <div class="col">
                            <div>
                                <span id="time">05:00</span>
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
                                            window.location.href = 'home';
                                        }
                                    }, 1000);
                                }

                                window.onload = function () {
                                    var fifteenMinutes = 60 * 5,
                                            display = document.querySelector('#time');
                                    startTimer(fifteenMinutes, display);
                                };
                            </script>
                        </div>
                    </div>

                    <div class="row" style="margin-top: 5rem;">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="customerName">Họ và tên: </label>
                                <input type="text" class="form-control" name="customerName" id="customerName" value="${customer.customerName}"
                                       readonly>
                            </div>
                        </div>
                        <div class="col-6">
                            <div class="form-group">
                                <label for="customerEmail">Email: </label>
                                <input type="email" class="form-control" name="customerEmail" id="customerEmail" value="${customer.customerEmail}"
                                       readonly>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-6">
                            <div class="form-group">
                                <label for="customerPhone">Số điện thoại: </label>
                                <input type="text" class="form-control" name="customerPhone" id="customerPhone" value="${customer.customerPhone}"
                                       aria-describedby="customerPhoneHid" readonly>
                            </div>
                        </div>
                    </div>
                    <h3 class="title-comm">
                        <span class="title-holder">Mã giảm giá</span>
                    </h3>
                    <mvc:form action="${pageContext.request.contextPath}/applyPromotion" method="POST">
                        <div class="row">
                            <div class="col">
                                <div class="form-inline">
                                    <label for="promotionCode">Mã giảm giá: </label>
                                    <input type="promotionCode" class="form-control ml-3" name="promotionCode" id="promotionCode"
                                           aria-describedby="promotionCodeHid" placeholder="Nhập Mã giảm giá" value="${promotion.code}">
                                    <button type="submit" onclick="location.href = '${pageContext.request.contextPath}/checkout'" class="applyCode btn ml-3">Apply</button>
                                </div>
                                <p style="color: #31d7a9;font-size: 20px;">${messagePromotion}</p>
                            </div>
                        </div>
                        <div class="row mt-3">
                            <div class="col">
                                <div class="form-inline">
                                    <label for="discount">Giá trị giảm giá: </label>
                                    <input type="discount" class="form-control ml-3" name="discount" id="discount" 
                                           value="<c:if test="${valuePromotion == 0}">0</c:if><c:if test="${valuePromotion != 0}"><fmt:formatNumber type="number" value="${valuePromotion}"/></c:if> đ"  readonly><span>/bill</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                </mvc:form>
                <div class="col-5 ticketInfo">
                    <h3 class="title-comm">
                        <span class="title-holder">Thông tin Vé</span>
                    </h3>
                    <div class="row justify-content-center">
                        <div class="col-4 imageTicketMovie mt-2 mb-2">
                            <img class="img-fluid" width="100%" src="${pageContext.request.contextPath}/resources/images/movies/coming/${sessionScope.movie.imageMovie}"
                                 alt="" />
                        </div>
                        <div class="col-8 contentTicketMovie mt-2 mb-2">
                            <table class="table table-borderless">
                                <tbody style="color: white">
                                    <tr class="text-center">
                                        <th colspan="2">${sessionScope.movie.nameByEnglish}</th>
                                    </tr>
                                    <tr class="text-center">
                                        <td colspan="2">${sessionScope.movie.nameByVietnam}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Rạp:</th>
                                        <td>${sessionScope.cinema.nameCinema}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Phòng chiếu:</th>
                                        <td>${sessionScope.cinemaMovie.cinemaRoom.cinemaRoomName}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Ngày:</th>
                                        <td>${sessionScope.cinemaMovie.showDate}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Suất chiếu:</th>
                                        <td>${sessionScope.cinemaMovie.showTime}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Số vé: </th>
                                        <td> 
                                            <c:if test="${sessionScope.ticketCouple == true}">
                                                ${sessionScope.quantityTicket - sessionScope.tickets.get(2).quantity  + (sessionScope.tickets.get(2).quantity * 2)} 
                                                (${sessionScope.quantityTicket - sessionScope.tickets.get(2).quantity} vé thường, ${sessionScope.tickets.get(2).quantity} vé cặp đôi)
                                            </c:if>
                                            <c:if test="${sessionScope.ticketCouple == false}">
                                                ${sessionScope.quantityTicket} vé thường
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr class="element">
                                        <th>Ghế:</th>
                                        <td>
                                            <c:forTokens var="selectedSeat" items="${sessionScope.selectedSeatsStr}" delims="[]">
                                                ${selectedSeat}
                                            </c:forTokens>
                                        </td>
                                    </tr>
                                    <tr class="element">
                                        <th style="text-transform: uppercase">Tổng tiền:</th>
                                        <td style="color: #31d7a9; font-weight: bolder">
                                            <fmt:formatNumber type="number" value="${totalBooking}"/>đ

                                        </td>
                                    </tr>
                                    <tr class="element">
                                        <th style="text-transform: uppercase">Giảm giá:</th>
                                        <td style="color: #31d7a9; font-weight: bolder">
                                            <c:if test="${valuePromotion == 0}">0</c:if><c:if test="${valuePromotion != 0}"><fmt:formatNumber type="number" value="${valuePromotion}"/></c:if> đ

                                        </td>
                                    </tr>
                                    <tr class="element">
                                        <th style="text-transform: uppercase">Thanh toán:</th>
                                        <td style="color: #31d7a9; font-weight: bolder">
                                            <fmt:formatNumber type="number" value="${subtotal}"/>đ

                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <mvc:form action="${pageContext.request.contextPath}/checkout" method="POST">
                        <div class="row">
                            <div class="col">
                                <div class="form-group">
                                    <label for="note">Ghi chú: </label>
                                    <textarea class="form-control" style="width: 100%;" name="note" id="note" rows="3" placeholder="Bạn muốn ghi chú gì tới rạp">${note}</textarea>
                                </div>
                            </div>
                        </div>
                        <div class="row buttonOperation mt-2 text-center" style="background-color: #001232">
                            <div class="col mt-2 mb-2">
                                <button onclick="location.href = '${pageContext.request.contextPath}/checkout'" class="btn nextBooking">
                                    Tiếp tục <i class="fas fa-angle-double-right"></i>
                                </button>
                            </div>
                        </div>
                    </mvc:form>

                </div>
            </div>
        </div>
        <!-- footer -->
        <jsp:include page="../user/fragment/footer.jsp" />
        <!-- scroll -->
        <jsp:include page="../user/fragment/scroll.jsp" />
        <script src="<c:url value="/webjars/jquery/3.6.0/jquery.min.js"/>"></script>
        <!--jQuery first, then Popper.js, then Bootstrap JS--> 
        <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
        </script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
        </script>
    </body>
</html>
