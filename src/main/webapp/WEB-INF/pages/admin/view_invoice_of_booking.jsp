<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>View Invoices Of Booking</title>
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
                                                <h4 class="card-title text-center">View Invoices Of Booking -- ID Booking: ${id}</h4>   
                                                <div class="row">   
                                                    <div class="col-sm-12 mt-2" >
                                                        <div class="table-responsive">
                                                            <table class="table table-hover table-bordered">
                                                                <thead class="text-center">
                                                                    <tr style="background-color: #1f3bb3; color: white;">
                                                                        <th>Customer</th>
                                                                        <th>Booking ID</th>
                                                                        <th>Total</th>
                                                                        <th>Invoice Date</th>
                                                                        <th>Payment Type</th>
                                                                        <th>Staff</th>
                                                                        <th>Status</th>
                                                                        <th style="text-align: center">Actions</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:if test="${invoices == null || invoices.size() <= 0}">
                                                                    <td colspan="8">
                                                                        <div style="text-align: center">
                                                                            <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                        </div>
                                                                    </td>
                                                                </c:if>
                                                                <c:if test="${invoices != null}">
                                                                    <c:forEach var="i" items="${invoices}">
                                                                        <tr style="overflow-x: auto;">
                                                                            <td>
                                                                                <p>Name: ${i.accountBankingName}</p>
                                                                                <p>Email: ${i.accountBankingEmail}</p>
                                                                            </td>
                                                                            <td class="text-center">${i.booking.id}</td>
                                                                            <td class="text-center">
                                                                                <fmt:formatNumber type="number" value="${i.amount}"/>đ
                                                                            </td>
                                                                            <td class="text-center"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${i.invoiceDate}" /></td>
                                                                            <td class="text-center">${i.paymentType}</td>
                                                                            <td class="text-center">
                                                                                <c:if test="${i.paymentType == 'ONLINE'}">
                                                                                    <p class="text-danger" style="font-weight: bolder;">Made By CUSTOMER</p>
                                                                                    <p>ONLINE SYSTEM</p>
                                                                                </c:if>
                                                                                <c:if test="${i.paymentType == 'DIRECT'}">
                                                                                    <p class="text-danger" style="font-weight: bolder;">Made By STAFF</p>
                                                                                    <p>Staff Name: ${i.staffName}</p>
                                                                                    <p>Staff Phone: ${i.staffPhone}</p>
                                                                                </c:if>
                                                                            </td>
                                                                            <td class="text-center">${i.status}</td>
                                                                            <td class="jsgrid-align-center" style="text-align: center">
                                                                                <a href="<c:url value="viewBookingInvoice/${i.booking.id}" />"><i class="mdi mdi-eye" id="color-icon"></i></a>
                                                                                <div id="printBill${i.id}" style="display: none;">
                                                                                    <div id="bill" class="container-fluid">
                                                                                        <div class="row justify-content-center">
                                                                                            <div class="col-5" style="border: 2px solid black;">
                                                                                                <div class="row justify-content-center">
                                                                                                    <div class="col text-center">
                                                                                                        <img class="img-fluid" width="45%" src="${pageContext.request.contextPath}/resources/images/logo-print.png" alt=""/>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <h3 class="mt-1" style="text-transform: uppercase; text-align: center;font-weight: bolder;">Vé xem phim</h3>
                                                                                                <div class="row">
                                                                                                    <div class="col">
                                                                                                        <h5>${i.booking.bookingDetail.cinema.nameCinema} - ${i.booking.bookingDetail.cinema.cinemaAddress}</h5>
                                                                                                        <h6><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${i.booking.bookingDate}" /> / VN</h6>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <hr style="border: 1px dotted black;">
                                                                                                <div class="row">
                                                                                                    <div class="col">
                                                                                                        <h4 style="text-transform: uppercase;">${i.booking.bookingDetail.movie.nameByEnglish}</h4>
                                                                                                        <h5>${i.booking.bookingDetail.showDate} ${i.booking.bookingDetail.showTime}</h5>
                                                                                                        <div class="row">
                                                                                                            <div class="col-6">
                                                                                                                <h6>Phòng chiếu: ${i.booking.bookingDetail.cinemaRoom.cinemaRoomName}</h6>
                                                                                                            </div>
                                                                                                            <div class="col-6 text-right">
                                                                                                                <h6>Ghế: 
                                                                                                                    <c:forEach var="bookingSeat" items="${i.booking.bookingSeats}">
                                                                                                                        ${bookingSeat.seatNumber},
                                                                                                                    </c:forEach></h6>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                        <div class="row">
                                                                                                            <div class="col-4">
                                                                                                                <h6>Loại vé: </h6>
                                                                                                            </div>
                                                                                                            <div class="col-6">
                                                                                                                <c:forEach var="t" items="${i.booking.bookingTickets}">
                                                                                                                    <p style="font-size: 12px;">${t.quantityTicket} ${t.ticket.ticketName}</p>
                                                                                                                </c:forEach>
                                                                                                            </div>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <c:if test="${i.booking.bookingFoods.size() > 0}">
                                                                                                    <hr style="border: 1.5px dotted black;">
                                                                                                    <div class="row">
                                                                                                        <div class="col">
                                                                                                            <h6 style="text-transform: uppercase; font-weight: bold;">Thức ăn, thức uống</h6>
                                                                                                            <h6> 
                                                                                                                <div class="row">
                                                                                                                    <c:forEach var="f" items="${i.booking.bookingFoods}">
                                                                                                                        <div class="col-6">
                                                                                                                            <p style="font-size: 12px;">${f.quantityFood} ${f.food.nameFood}</p>
                                                                                                                        </div>
                                                                                                                    </c:forEach>
                                                                                                                </div>
                                                                                                            </h6>
                                                                                                        </div>
                                                                                                    </div>
                                                                                                </c:if>
                                                                                                <hr style="border: 2px solid black;">
                                                                                                <div class="row">
                                                                                                    <div class="col-6">
                                                                                                        <h5 style="text-transform: uppercase; font-weight: bold;text-align: left;">Giá vé: </h5>
                                                                                                    </div>
                                                                                                    <div class="col-6 text-right">
                                                                                                        <h5 style="font-weight: bold; font-size: 20px;"><fmt:formatNumber type="number" value="${i.booking.subtotal}" />đ</h5>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <hr style="border: 1.5px dotted black;">   
                                                                                                <div class="row text-center">
                                                                                                    <div class="col">
                                                                                                        <b>Double T Cinema - ${i.id}</b>
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="row mb-1 justify-content-center">
                                                                                                    <div class="col text-center">
                                                                                                        <img class="img-fluid" width="80%" src="${pageContext.request.contextPath}/resources/images/barcode_double_t_cinema.png" alt=""/>
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <button class="btn btn-dark" style="color: white;" onclick="printOut('printBill${i.id}');"><i class="fas fa-print"></i> In vé</button>
                                                                                <script>
                                                                                    function printOut(divId) {
                                                                                        var printOutContent = document.getElementById(divId).innerHTML;
                                                                                        var originalContent = document.body.innerHTML;
                                                                                        document.body.innerHTML = printOutContent;
                                                                                        setTimeout(function () {
                                                                                            window.print();
                                                                                            document.body.innerHTML = originalContent;
                                                                                        }, 250);
                                                                                    }
                                                                                </script>

                                                                                <c:if test="${i.status == 'PAYMENT_DONE'}">
                                                                                    <br>
                                                                                    <a style="color: white;" class="btn btn-success" href="${pageContext.request.contextPath}/admin/checkViewed/${i.id}">Check in</a>
                                                                                    <a style="color: white;" class="btn btn-danger" href="${pageContext.request.contextPath}/admin/buyFoods/${i.id}"><i class="fas fa-glass-martini-alt"></i> Buy Foods</a>
                                                                                </c:if>
                                                                            </td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </c:if>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                        <p class="text-center">
                                                            <a href="<c:url value="/admin/bookings" />" class="btn btn-dark" style="color: white;"><i class="fas fa-backward"></i> Back to List Bookings</a>
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