<%-- 
    Document   : booking
    Created on : Jul 28, 2022, 3:32:10 PM
    Author     : tanhegemony
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Booking Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>

        <link rel="stylesheet" href="<c:url value="/resources/style/css/booking.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/booking_responsive.css" />"/>
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
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i> Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="#"><i class="fas fa-money-check-alt"></i> Mua vé</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Thông tin đặt vé</li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row headerContent text-center">
                <div class="col">
                    <h4>Thông tin đặt vé</h4>
                    <hr style="border: 1px solid #032055;width: 10%;">
                </div>
            </div>
            <div class="row tableContent justify-content-center">
                <div class="col-7">
                    <form action="booking" method="get">
                        <input type="hidden" name="movieId" value="${movieId}">
                        <input type="hidden" name="cinemaId" value="${cinemaId}">
                        <input type="hidden" name="showDate" value="${showDate}">
                        <input type="hidden" name="showTime" value="${showTime}">
                        <div class="row">
                            <div class="col">
                                <h5 style="text-decoration: underline;">Chọn vé:</h5>
                                <table class="table table-responsive-sm table-borderless text-center">
                                    <thead>
                                        <tr>
                                            <th scope="col">Loại vé</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Giá vé</th>
                                            <th scope="col">Tổng</th>
                                        </tr>
                                    </thead>
                                    <tbody style="color: white;">
                                        <c:forEach var="ticket" items="${tickets}">
                                            <tr>
                                                <td>${ticket.ticketName}</td>
                                                <td class="quantity">
                                                    <div class="form-inline justify-content-center">
                                                        <button onclick="minusQuantity(${ticket.id}, 'ticket')" <c:if test="${ticket.quantity == 0}">disabled</c:if> class="minus">
                                                                - </button>
                                                            <input type="number" min="0" step="1" onchange="this.form.submit()" 
                                                                   name="quantity_booking_ticket" max="${seats.size() - seatsBooked.size()}" id="quantity_ticket_${ticket.id}" value="${ticket.quantity}">
                                                        <button title="Bạn chỉ được mua tối đa 10 vé cho 1 loại!!" 
                                                                <c:if test="${quantityTicket < (seats.size() - seatsBooked.size())}">
                                                                    onclick="extraQuantity(${ticket.id}, 'ticket')"
                                                                </c:if>

                                                                <c:if test="${quantityTicket == (seats.size() - seatsBooked.size())}">disabled</c:if>
                                                                    class="extra">
                                                                    + </button>
                                                        </div>
                                                    </td>
                                                    <td><fmt:formatNumber type="number" value="${ticket.ticketPrice}"/>đ</td>
                                                <td><fmt:formatNumber type="number" value="${ticket.quantity * ticket.ticketPrice}"/>đ</td>
                                            </tr>

                                        </c:forEach>
                                    <script>
                                        function extraQuantity(id, name) {

                                            for (let i = 1; i <= ${tickets.size()}; i++) {
                                                if (id == i) {
                                                    if (name == "ticket") {
                                                        let number = document.querySelector('#quantity_ticket_' + i);
                                                        let value = number.value++;
                                                        number.addEventListener('change', () => {
                                                        })
                                                    } else if (name == "food") {
                                                        let number = document.querySelector('#quantity_food_' + i);
                                                        let value = number.value++;
                                                        number.addEventListener('change', () => {
                                                        })
                                                    }
                                                }
                                            }
                                        }
                                        function minusQuantity(id, name) {
                                            for (let i = 1; i <= ${tickets.size()}; i++) {
                                                if (id == i) {
                                                    if (name == "ticket") {
                                                        let number = document.querySelector('#quantity_ticket_' + i);
                                                        let value = number.value--;
                                                        number.addEventListener('change', () => {
                                                        })
                                                    } else if (name == "food") {
                                                        let number = document.querySelector('#quantity_food_' + i);
                                                        let value = number.value--;
                                                        number.addEventListener('change', () => {
                                                        })
                                                    }
                                                }
                                            }
                                        }
                                    </script>
                                    <tr style="background-color: #032055;">
                                        <th>Tổng: </th>
                                        <td colspan="3" class="text-right"><fmt:formatNumber type="number" value="${totalPriceTicket}"/>đ</td>
                                    </tr>


                                    </tbody>
                                </table>
                            </div>
                        </div>             
                        <div class="row">
                            <div class="col">
                                <h5 style="text-decoration: underline;">Chọn thức ăn:</h5>
                                <table class="table table-responsive-sm table-borderless text-center">
                                    <thead>
                                        <tr>
                                            <th scope="col">Tên Thức ăn</th>
                                            <th scope="col">Số lượng</th>
                                            <th scope="col">Giá</th>
                                            <th scope="col">Tổng</th>
                                        </tr>
                                    </thead>
                                    <tbody style="color: white;">
                                        <c:forEach var="food" items="${foods}">
                                            <tr>
                                                <td>${food.nameFood}</td>
                                                <td class="quantity">
                                                    <div class="form-inline justify-content-center">
                                                        <button onclick="minusQuantity(${food.id}, 'food')" class="minus" <c:if test="${food.quantity == 0}">disabled</c:if>>
                                                                - </button>
                                                            <input type="number" min="0" max="10" step="1" onchange="this.form.submit()"  name="quantity_booking_food" id="quantity_food_${food.id}" value="${food.quantity}">
                                                        <button title="Bạn chỉ được mua tối đa 10 thức ăn cho 1 loại!!" onclick="extraQuantity(${food.id}, 'food')" 
                                                                <c:if test="${food.quantity == 10 || (seats.size() == seatsBooked.size())}">disabled</c:if> class="extra">
                                                                    + </button>
                                                        </div>
                                                    </td>
                                                    <td><fmt:formatNumber type="number" value="${food.priceFood}"/>đ</td>
                                                <td><fmt:formatNumber type="number" value="${food.quantity * food.priceFood}"/>đ</td>
                                            </tr>
                                        </c:forEach>
                                        <tr style="background-color: #032055;">
                                            <th>Tổng: </th>
                                            <td colspan="3" class="text-right"><fmt:formatNumber type="number" value="${totalPriceFood}"/>đ</td>
                                        </tr>


                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </form>
                </div>

                <div class="col-5 ticketInfo">
                    <h3 class="title-comm"><span class="title-holder">Thông tin Vé</span></h3>
                    <div class="row justify-content-center">
                        <div class="col-4 imageTicketMovie mt-2 mb-2 ">
                            <img class="img-fluid" width="100%" src="resources/images/movies/coming/${movie.imageMovie}" alt="">
                            <c:if test="${seats.size() == seatsBooked.size()}">
                                <p style="color: #31d7a9;text-align: center;font-weight: bolder;">Đã hết ghế</p>
                            </c:if>

                        </div>
                        <div class="col-8 contentTicketMovie mt-2 mb-2" >
                            <table class="table table-borderless">
                                <tbody style="color: white;">
                                    <tr class="text-center">
                                        <th colspan="2">${movie.nameByEnglish}</th>
                                    </tr>
                                    <tr class="text-center">
                                        <td colspan="2">${movie.nameByVietnam}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Rạp: </th>
                                        <td>${cinema.nameCinema}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Phòng chiếu: </th>
                                        <td>${cinemaMovie.cinemaRoom.cinemaRoomName}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Ngày: </th>
                                        <td>${showDate}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Suất chiếu: </th>
                                        <td>${showTime}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Số vé: </th>
                                        <td> 
                                            <c:if test="${ticketCouple == true}">
                                                ${quantityTicket - tickets.get(2).quantity  + (tickets.get(2).quantity * 2)} 
                                                (${quantityTicket - tickets.get(2).quantity} vé thường, ${tickets.get(2).quantity} vé cặp đôi)
                                            </c:if>
                                            <c:if test="${ticketCouple == false}">
                                                ${quantityTicket} vé thường
                                            </c:if>
                                        </td>
                                    </tr>
                                    <tr class="element">
                                        <th>Số ghế còn trống: </th>
                                        <td>${seats.size() - seatsBooked.size()}</td>
                                    </tr>
                                    <tr class="element">
                                        <th>Số ghế đã bán: </th>
                                        <td>${seatsBooked.size()}</td>
                                    </tr>
                                    <tr class="element">
                                        <th style="text-transform: uppercase;">Tổng tiền: </th>
                                        <td style="color: #31d7a9;font-weight: bolder;"><fmt:formatNumber type="number" value="${totalPriceTicket+totalPriceFood}"/>đ</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <div class="row buttonOperation mt-2 text-center" style="background-color: #001232">
                        <div class="col mt-2 mb-2">
                            <button <c:if test="${quantityTicket == 0}">onclick="return confirm('Bạn chưa chọn vé ?')"</c:if>
                                                                        <c:if test="${quantityTicket > 0}"> 
                                                                            onclick="location.href = '${pageContext.request.contextPath}/booking_seat'"
                                                                        </c:if>
                                                                        class="btn nextBooking" 
                                                                        <c:if test="${seats.size() == seatsBooked.size()}">
                                                                            title="Đã bán hết ghế cho ngày hôm nay!"  disabled
                                                                        </c:if>
                                                                        >Tiếp tục <i class="fas fa-angle-double-right"></i></button>
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
        <!-- jQuery first, then Popper.js, then Bootstrap JS -->
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
