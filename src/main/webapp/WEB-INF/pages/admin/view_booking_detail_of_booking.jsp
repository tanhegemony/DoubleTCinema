<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>View Booking Detail</title>
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
                                                <h4 class="card-title text-center">View Booking Detail -- ID Booking: ${booking.id}</h4>        
                                                
                                                    <div class="row">   
                                                        <div class="col-sm-12 mt-2" >
                                                            <div class="table-responsive">
                                                                <table class="table table-hover table-bordered mb-3 text-center">
                                                                    <thead>
                                                                        <tr class="text-center" style="background-color: #1f3bb3; color: white;">
                                                                            <th>Food</th>
                                                                            <th>Ticket Price</th>
                                                                            <th>Food Price</th>
                                                                            <th>Total</th>
                                                                        </tr>
                                                                    </thead>
                                                                    <tbody>
                                                                        <c:if test="${booking.id <= 0}">
                                                                        <td colspan="4">
                                                                            <div style="text-align: center">
                                                                                <h5 style="text-transform: uppercase;color: red;">No data displayed ! Please check again !</h5>
                                                                            </div>
                                                                        </td>
                                                                    </c:if>
                                                                    <c:if test="${booking.id > 0}">
                                                                        <tr class="text-center">
                                                                            <td>
                                                                                <c:if test="${booking.bookingFoods.size() > 0}">
                                                                                    <c:forEach items="${booking.bookingFoods}" var="bf">
                                                                                        ${bf.food.nameFood},
                                                                                    </c:forEach>
                                                                                </c:if>
                                                                                <c:if test="${booking.bookingFoods.size() <= 0 }">
                                                                                    <p>No Foods</p>
                                                                                </c:if>

                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatNumber type="number" value=" ${booking.bookingDetail.totalPriceTicket}"/>đ 
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatNumber type="number" value=" ${booking.bookingDetail.totalPriceFood}"/>đ
                                                                            </td>
                                                                            <td>
                                                                                <fmt:formatNumber type="number" value=" ${booking.bookingDetail.totalPriceTicket + booking.bookingDetail.totalPriceFood}"/>đ
                                                                            </td>
                                                                        </tr>
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