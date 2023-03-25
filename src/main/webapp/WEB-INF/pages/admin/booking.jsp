<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'bookings'}">Bookings</c:if>
            <c:if test="${action == 'search_bookings'}">Search Bookings</c:if>
            </title>
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
                                                <h4 class="card-title text-center">Bookings</h4>
                                                <div class="row">
                                                    <div class="col-sm-12 col-md-4">
                                                        <div class="dataTables_length" id="order-listing_length">
                                                            <b> Display </b> 
                                                            <label>
                                                                <form action="">
                                                                    <input type="hidden" name="searchValue" value="${searchValue}">
                                                                    <select name="size" id="size" class="custom-select custom-select-sm form-control" 
                                                                            aria-controls="order-listing" onchange="this.form.submit()">
                                                                        <option value="5" <c:if test="${pageSize == 5}">selected</c:if>> 5 </option>
                                                                        <option value="10" <c:if test="${pageSize == 10}">selected</c:if>> 10 </option>
                                                                        <option value="15" <c:if test="${pageSize == 15}">selected</c:if>> 15 </option>
                                                                        </select>
                                                                    </form>
                                                                </label>
                                                                <b>  bookings </b>
                                                            </div>
                                                        </div>
                                                        <div class="col-sm-12 col-md-8">
                                                            <form action="searchBookings" method="GET">
                                                                <div class="dataTables_filter" id="order-listing_filter" style="text-align: right">
                                                                    <label>
                                                                        <b>* Input Date With Format:</b><b class="text-danger"> yyyy-MM-dd HH:mm:ss</b>
                                                                        <br>
                                                                        <b>* Example:</b><b class="text-danger"> 2002-10-06 06:10:22</b>
                                                                        <input type="text" class="form-control" name="searchValue"
                                                                               style="min-width: 32rem;"   id="searchValue" placeholder="Input Movie Name English Or Customer Name Or Booking Date Or Show Date" value="${searchValue}">
                                                                </label>
                                                                <label>
                                                                    <button class="btn btn-sm btn-primary form-control my-2"  ><i class="ti-search"></i></button>
                                                                </label>

                                                            </div>
                                                        </form>
                                                    </div>
                                                </div>       
                                                <div class="row">   
                                                    <div class="col-sm-12 mt-2" >
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-bordered">
                                                                <thead>
                                                                    <tr class="text-center" style="background-color: #1f3bb3; color: white;">
                                                                        <th>Booking ID</th>
                                                                        <th>Movie</th>
                                                                        <th>Ticket Information</th>
                                                                        <th>Subtotal</th>
                                                                        <th>Booking Time</th>
                                                                        <th>Note </th>
                                                                        <th>Status</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${bookings == null}">
                                                                    <td colspan="7">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${bookings != null}">
                                                                    <c:forEach var="booking" items="${bookings.content}">
                                                                        <tr>
                                                                            <td class="text-center">${booking.id}</td>
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
                                                                                <p><a href="${pageContext.request.contextPath}/admin/viewBookingDetail/${booking.bookingDetail.id}" style="color: black; text-decoration: none;"><i class="fas fa-eye"></i> View Booking Details </a> </p>
                                                                                <p><a href="${pageContext.request.contextPath}/admin/viewInvoiceOfBooking/${booking.id}" style="color: black; text-decoration: none;"><i class="fas fa-file-invoice"></i> View Invoice Of This Booking</a> </p>
                                                                                <c:if test="${booking.status == 'Canceled'}">
                                                                                    <p><a href="${pageContext.request.contextPath}/admin/deleteBooking/${booking.id}" style="color: red; text-decoration: none;"><i class="fas fa-trash-alt"></i> Delete Booking</a> </p>
                                                                                </c:if> 
                                                                            </td>
                                                                            <td>
                                                                                <p>CustomerName: <span style="color: red;font-weight: bolder;">${booking.customer.customerName}</span></p>
                                                                                <p>Cinema: <span style="color: red;font-weight: bolder;">${booking.bookingDetail.cinema.nameCinema}</span></p>
                                                                                <p>Room: <span style="color: red;font-weight: bolder;">${booking.bookingDetail.cinemaRoom.cinemaRoomName}</span></p>
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
                                                                            <td>
                                                                                <p>Total: <span style="color: red;font-weight: bolder;"><fmt:formatNumber type="number" value=" ${booking.subtotal + booking.discount}"/>đ</span></p>
                                                                                <hr>
                                                                                <p>Discount:</p>
                                                                                    <p>Code = <span style="color: red;font-weight: bolder;">
                                                                                    <c:if test="${booking.code == null}">No code</c:if>
                                                                                    <c:if test="${booking.code != null}">${booking.code}</c:if>
                                                                                    </span></p>    
                                                                                <p>Value = - <span style="color: red;font-weight: bolder;"><fmt:formatNumber type="number" value=" ${booking.discount}"/>đ</span></p>
                                                                                    <hr>
                                                                                    <p>Payment: <span style="color: red;font-weight: bolder;"><fmt:formatNumber type="number" value=" ${booking.subtotal}"/>đ</span></p>
                                                                            </td>
                                                                            <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${booking.bookingDate}" /></td>
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
                                                                            <td class="text-center">${booking.status}</td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:if>

                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </div>
                                                </div>
                                                <c:if test="${bookings != null}">
                                                    <div class="row">
                                                        <div class="col mt-2">
                                                            <nav aria-label="Page  navigation example">
                                                                <ul class="pagination justify-content-end">
                                                                    <li class="page-item <c:if test="${currentPage == 1}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'bookings'}">bookings?</c:if><c:if test="${action == 'search_bookings'}">searchBookings?searchValue=${searchValue}&</c:if>page=${currentPage - 1}&size=${pageSize}" aria-label="Previous">
                                                                                <span aria-hidden="true">&laquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    <c:forEach var="page" begin="1"  end="${totalPages}">

                                                                        <li class="page-item <c:if test="${currentPage == page}">active</c:if>">
                                                                            <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'bookings'}">bookings?</c:if><c:if test="${action == 'search_bookings'}">searchBookings?searchValue=${searchValue}&</c:if>page=${page}&size=${pageSize}">${page}</a>
                                                                            </li>
                                                                    </c:forEach>
                                                                    <li class="page-item <c:if test="${currentPage == totalPages}">disabled</c:if>">
                                                                        <a class="page-link" href="${pageContext.request.contextPath}/admin/<c:if test="${action == 'bookings'}">bookings?</c:if><c:if test="${action == 'search_bookings'}">searchBookings?searchValue=${searchValue}&</c:if>page=${currentPage + 1}&size=${pageSize}" aria-label="Next">
                                                                                <span aria-hidden="true">&raquo;</span>
                                                                            </a>
                                                                        </li>
                                                                    </ul>
                                                                </nav>
                                                            </div>
                                                        </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

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