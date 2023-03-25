<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>View Bookings Of Promotion</title>
        <jsp:include page="../include/management/css.jsp" />
    </head>

    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <!-- header -->
            <jsp:include page="../include/management/header.jsp" />
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="../include/management/menu.jsp" />
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <!-- Nhập nội dung -->
                                    <div class="col-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center">View Bookings Of Promotion -- Code : <c:if test="${promotion != null}">${promotion.code}</c:if><c:if test="${promotion == null}">${promotion.code} does not exist</c:if></h4>     
                                                <div class="row">   
                                                    <div class="col-sm-12 mt-2" >
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-bordered text-center">
                                                                <thead>
                                                                    <tr style="background-color: #1f3bb3; color: white;">
                                                                        <th>Movie</th>
                                                                        <th>Ticket Information</th>
                                                                        <th>Subtotal</th>
                                                                        <th>Booking Date</th>
                                                                        <th>Note </th>
                                                                        <th>Discount</th>
                                                                        <th>Status</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${bookings == null || bookings.size() <= 0}">
                                                                    <td colspan="7">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${bookings != null}">
                                                                    <c:forEach var="booking" items="${bookings}">
                                                                        <tr>
                                                                            <td class="text-center">
                                                                                <p><img id="image-movie" 
                                                                                        src="${pageContext.request.contextPath}/resources/images/movies/coming/${booking.bookingDetail.movie.imageMovie}"/></p>
                                                                                <p>Movie: <span style="color: red;font-weight: bolder;">
                                                                                        <c:if test="${booking.bookingDetail.movie.nameByEnglish.length() <= 22}">
                                                                                            ${booking.bookingDetail.movie.nameByEnglish.substring(0,booking.bookingDetail.movie.nameByEnglish.length())}
                                                                                        </c:if>
                                                                                        <c:if test="${booking.bookingDetail.movie.nameByEnglish.length() > 22}">
                                                                                            ${booking.bookingDetail.movie.nameByEnglish.substring(0,22)}...
                                                                                        </c:if>
                                                                                    </span>
                                                                                </p>
                                                                                <p><a href="${pageContext.request.contextPath}/admin/viewBookingDetail/${booking.bookingDetail.id}" style="color: black; text-decoration: none;"><i class="fas fa-eye"></i> View Detail More...</a> </p>
                                                                                <p><a href="${pageContext.request.contextPath}/admin/viewInvoiceOfBooking/${booking.id}" style="color: black; text-decoration: none;"><i class="fas fa-file-invoice"></i> View Invoice Of This Booking</a> </p>
                                                                                <c:if test="${booking.status == 'Canceled'}">
                                                                                    <p><a href="${pageContext.request.contextPath}/admin/deleteBooking/${booking.id}" style="color: red; text-decoration: none;"><i class="fas fa-trash-alt"></i> Delete Booking</a> </p>
                                                                                </c:if> 
                                                                            </td>
                                                                            <td>
                                                                                <p>Cinema: <span style="color: red;font-weight: bolder;">${booking.bookingDetail.cinema.nameCinema}</span> - Room: <span style="color: red;font-weight: bolder;">${booking.bookingDetail.cinemaRoom.cinemaRoomName}</span></p>
                                                                                <p>ShowTime: <span style="color: red;font-weight: bolder;">${booking.bookingDetail.showDate} ${booking.bookingDetail.showTime}</span></p>
                                                                                <p>QuantityTicket: <span style="color: red;font-weight: bolder;">${booking.bookingDetail.quantityTicket}</span></p>
                                                                                <p>Seats: 
                                                                                    <span style="color: red;font-weight: bolder;">
                                                                                        <c:forEach var="bs" items="${booking.bookingSeats}">
                                                                                            ${bs.seatNumber},
                                                                                        </c:forEach>
                                                                                    </span>
                                                                                </p>
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <fmt:formatNumber type="number" value=" ${booking.subtotal}"/>đ
                                                                            </td>
                                                                            <td class="text-center">${booking.bookingDate}</td>
                                                                            <td class="text-center">
                                                                                <p style="
                                                                                   max-width: 200px;
                                                                                   overflow-x:auto;">
                                                                                    <c:if test="${booking.note == ''}">
                                                                                        No note
                                                                                    </c:if>
                                                                                    <c:if test="${booking.note != ''}">
                                                                                        ${booking.note}
                                                                                    </c:if>
                                                                                </p>
                                                                            </td>
                                                                            <td class="text-center">
                                                                                <p>
                                                                                    <c:if test="${booking.code == null}">No code</c:if>
                                                                                    <c:if test="${booking.code != null}">${booking.code}</c:if>
                                                                                    </p>
                                                                                    <p>
                                                                                        - <fmt:formatNumber type="number" value=" ${booking.discount}"/>đ
                                                                                </p>
                                                                            </td>
                                                                            <td class="text-center">${booking.status}</td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:if>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <p class="text-center mt-2">
                                                                <a  href="<c:url value="/admin/promotions" />" class="btn btn-dark" style="color: white;"><i class="fas fa-backward"></i> Back to List Promotions</a>
                                                        </p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <!-- footer -->
                    <jsp:include page="../include/management/footer.jsp" />
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <jsp:include page="../include/management/js.jsp" />
    </body>

</html>