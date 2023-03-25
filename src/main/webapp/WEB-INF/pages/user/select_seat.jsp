
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Booking Seat Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/select_seat.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/select_seat_responsive.css" />"/>

        <style>
            .seatBuyed{
                border: 1px solid white;
                background-color: white;
                color: black;
            }
        </style>
    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <c:url var="home" value="/" scope="request" />
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
                            <li class="breadcrumb-item active" aria-current="page">
                                <i class="fas fa-couch"></i> Chọn ghế
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row headerContent text-center">
                <div class="col">
                    <h4>Chọn ghế</h4>
                    <hr style="border: 1px solid #032055; width: 10%" />
                </div>
            </div>
            <div class="row bodyChooseSeat">
                <div class="col-7 chooseSeat text-center">
                    <hr style="border: 1px solid #032055; width: 20%" />
                    <p>MÀN HÌNH CHIẾU</p>
                    <hr style="border: 1px solid #032055; width: 40%" />
                    <div class="row imgScreen">
                        <div class="col">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/screen-thumb.png" alt="" />
                        </div>
                    </div>
                    <div class="row noteSeat">
                        <div class="col-3">
                            <div class="box canChoose"></div>
                            <i>: Có thể chọn</i>
                        </div>
                        <div class="col-3">
                            <div class="box canNotChoose"></div>
                            <i>: Không thể chọn</i>
                        </div>
                        <div class="col-3">
                            <div class="box seatChoosing"></div>
                            <i>: Ghế đang chọn</i>
                        </div>
                        <div class="col-3">
                            <div class="box seatBuyed"></div>
                            <i>: Ghế đã bán</i>
                        </div>
                    </div>
                    <hr style="border: 1px solid #032055; width: 20%" />
                    <p>GHẾ NGỒI</p>
                    <hr style="border: 1px solid #032055; width: 40%" />
                    <table class="table table-borderless table-responsive justify-content-center">
                        <tr >
                            <td>
                                <div class="row choose">
                                    <div class="col">
                                        <div class="main">
                                            <div class="boxes" style="grid-template-columns: repeat(${cinemaRoom.columnCinemaRoom}, 1fr);">
                                                <c:forEach var="seat" items="${seats}">
                                                    <div class="items
                                                         <c:if test="${seat.selected == true}">activeSeat</c:if>
                                                         <c:if test="${seat.canNotSelected == true}">notChoose</c:if>
                                                         <c:if test="${seat.booked == true}">seatBuyed</c:if>"
                                                         <c:if test="${seat.canNotSelected == false && seat.booked == false}">onclick="selectSeat(this, '${seat.seatNumber}')"</c:if>
                                                         >${seat.seatNumber}</div>
                                                </c:forEach>

                                            </div>
                                        </div>

                                        <script>
                                            function selectSeat(e, value) {
                                                e.classList.toggle('activeSeat');
                                                var cinemaRoomId = ${sessionScope.cinemaMovie.cinemaRoom.id};
                                                console.log("SUCCESS: ", 1);
                                                $.ajax({
                                                    type: 'GET',
                                                    contentType: "application/json",
                                                    data: {
                                                        seat: value,
                                                        cinemaRoomId: cinemaRoomId},
                                                    dataType: 'json',
                                                    url: "${home}select-seat",
                                                    success: function (result) {
                                                    },
                                                    error: function (e) {
                                                        window.location.href = e.responseText;
                                                    }
                                                });

                                            }
                                        </script>

                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </div>
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
                                        <td style="color: #31d7a9; font-weight: bolder"><fmt:formatNumber type="number" value="${sessionScope.totalBooking}"/>đ</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="row buttonOperation mt-2 text-center" style="background-color: #001232">
                        <div class="col mt-2 mb-2">
                            <button <c:if test="${selectedSeats.size() == quantityTicket}">onclick="location.href = '${pageContext.request.contextPath}/view_checkout'"</c:if>
                                                                                           <c:if test="${selectedSeats.size() < quantityTicket || selectedSeats.size() == 0 || selectedSeats == null}">onclick="return confirm('Bạn chưa chọn đủ ghế?')"</c:if>
                                                                                               class="btn nextBooking">
                                                                                               Tiếp tục <i class="fas fa-angle-double-right"></i>
                                                                                           </button>
                            </div>
                        </div>
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
