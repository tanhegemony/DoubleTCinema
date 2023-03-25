<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Home -- Dashboard</title>
        <jsp:include page="../include/management/css.jsp" />
    </head>

    <body>
        <div class="container-scroller">
            <jsp:include page="../include/management/header.jsp" />
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="../include/management/menu.jsp" />
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <div class="tab-content tab-content-basic">
                                        <div class="tab-pane fade show active" id="overview" role="tabpanel" aria-labelledby="overview">
                                            <div class="row mb-4">
                                                <div class="col-3">
                                                    <div class="text-center" style="background-color: #F96167;padding: 5px;border-radius: 5px; box-shadow: 5px 5px 5px grey; border: 1px solid grey;">
                                                        <p class="statistics-title text-light" style="font-size: 18px;">Total income / 1 
                                                            <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                month
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                year
                                                            </c:if>
                                                            </p>
                                                        <p class="text-light text-center" style="font-size: 16px;">
                                                            <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                -- <fmt:formatDate pattern="M / yyyy" value="${now}" /> vs <fmt:formatDate pattern="M / yyyy" value="${yesterday}" /> --
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                -- ${yearNumber} vs  <fmt:formatDate pattern="yyyy" value="${beforeYear}" />-- 
                                                            </c:if>
                                                        </p>
                                                        <h2 class="rate-percentage text-light" style="font-weight: bolder;"><fmt:formatNumber type="number" value="${subtotalPaymentMonth}" />đ</h2>
                                                        <c:if test="${resultComparePayment < 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-down"></i><span><fmt:formatNumber type="number" value="${0 - resultComparePayment}" />đ</span>
                                                            </p>
                                                        </c:if>
                                                        <c:if test="${resultComparePayment >= 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-up"></i><span><fmt:formatNumber type="number" value="${resultComparePayment}" />đ</span>
                                                            </p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="text-center" style="background-color: #FCE77D;padding: 5px;border-radius: 10px; box-shadow: 5px 5px 5px grey; border: 1px solid grey;">
                                                        <p class="statistics-title text-dark" style="font-size: 18px;">Total ticket sales / 1 
                                                        <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                month
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                year
                                                            </c:if></p>
                                                        <p class="text-dark text-center" style="font-size: 16px;">
                                                            <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                -- <fmt:formatDate pattern="M / yyyy" value="${now}" /> vs <fmt:formatDate pattern="M / yyyy" value="${yesterday}" /> --
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                -- ${yearNumber} vs  <fmt:formatDate pattern="yyyy" value="${beforeYear}" />-- 
                                                            </c:if>
                                                        </p>
                                                        <h2 class="rate-percentage text-dark" style="font-weight: bolder;"><fmt:formatNumber type="number" value="${subtotalBuyTicket}" /></h2>
                                                        <c:if test="${resultCompareQuantityBuyTicket < 0}">
                                                            <p class="text-dark d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-down"></i><span><fmt:formatNumber type="number" value="${0 - resultCompareQuantityBuyTicket}" /></span></p>
                                                                </c:if>
                                                                <c:if test="${resultCompareQuantityBuyTicket >= 0}">
                                                            <p class="text-dark d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-up"></i><span><fmt:formatNumber type="number" value="${resultCompareQuantityBuyTicket}" /></span></p>
                                                                </c:if>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="text-center" style="background-color: #4A274F;padding: 5px;border-radius: 10px; box-shadow: 5px 5px 5px grey; border: 1px solid grey;">
                                                        <p class="statistics-title text-light" style="font-size: 18px;">Total drinks sold / 1 
                                                        <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                month
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                year
                                                            </c:if></p>
                                                        <p class="text-light text-center" style="font-size: 16px;">
                                                            <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                -- <fmt:formatDate pattern="M / yyyy" value="${now}" /> vs <fmt:formatDate pattern="M / yyyy" value="${yesterday}" /> --
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                -- ${yearNumber} vs  <fmt:formatDate pattern="yyyy" value="${beforeYear}" />-- 
                                                            </c:if>
                                                        </p>
                                                        <h2 class="rate-percentage text-light" style="font-weight: bolder;"><fmt:formatNumber type="number" value="${subtotalBuyFood}" /></h2>
                                                        <c:if test="${resultCompareQuantityBuyFood < 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-down"></i><span><fmt:formatNumber type="number" value="${0 - resultCompareQuantityBuyFood}" /></span></p>
                                                                </c:if>
                                                                <c:if test="${resultCompareQuantityBuyFood >= 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-up"></i><span><fmt:formatNumber type="number" value="${resultCompareQuantityBuyFood}" /></span></p>
                                                                </c:if>
                                                    </div>
                                                </div>
                                                <div class="col-3">
                                                    <div class="text-center" style="background-color: #EC8B5E;padding: 5px;border-radius: 10px; box-shadow: 5px 5px 5px grey; border: 1px solid grey;">
                                                        <p class="statistics-title text-dark" style="font-size: 18px;">New Users / 1 
                                                        <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                month
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                year
                                                            </c:if></p>
                                                        <p class="text-dark text-center" style="font-size: 16px;">
                                                            <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                -- <fmt:formatDate pattern="M / yyyy" value="${now}" /> vs <fmt:formatDate pattern="M / yyyy" value="${yesterday}" /> --
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                -- ${yearNumber} vs  <fmt:formatDate pattern="yyyy" value="${beforeYear}" />-- 
                                                            </c:if>
                                                        </p>
                                                        <h2 class="rate-percentage" style="font-weight: bolder;"><fmt:formatNumber type="number" value="${newAccountNumber}" /></h2>
                                                        <c:if test="${resultCompareAccount < 0}">
                                                            <p class="text-dark d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-down"></i><span><fmt:formatNumber type="number" value="${0 - resultCompareAccount}" /></span></p>
                                                                </c:if>
                                                                <c:if test="${resultCompareAccount >= 0}">
                                                            <p class="text-dark d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-up"></i><span><fmt:formatNumber type="number" value="${resultCompareAccount}" /></span></p>
                                                                </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row mt-4 mb-4 justify-content-center">
                                                <div class="col-5">
                                                    <div class="text-center" style="background-color: #4831D4;padding: 5px;border-radius: 10px; box-shadow: 5px 5px 5px grey; border: 1px solid grey;">
                                                        <p class="statistics-title text-light" style="font-size: 18px;">Total ticket income / 1 
                                                        <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                month
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                year
                                                            </c:if></p>
                                                        <p class="text-light text-center" style="font-size: 16px;">
                                                            <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                -- <fmt:formatDate pattern="M / yyyy" value="${now}" /> vs <fmt:formatDate pattern="M / yyyy" value="${yesterday}" /> --
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                -- ${yearNumber} vs  <fmt:formatDate pattern="yyyy" value="${beforeYear}" />-- 
                                                            </c:if>
                                                        </p>
                                                        <h2 class="rate-percentage text-light" style="font-weight: bolder;"><fmt:formatNumber type="number" value="${subtotalPaymentBuyTicket}" />đ</h2>
                                                        <c:if test="${resultCompareBookingBuyTicket < 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-down"></i><span><fmt:formatNumber type="number" value="${0 - resultCompareBookingBuyTicket}" />đ</span>
                                                            </p>
                                                        </c:if>
                                                        <c:if test="${resultCompareBookingBuyTicket >= 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-up"></i><span><fmt:formatNumber type="number" value="${resultCompareBookingBuyTicket}" />đ</span>
                                                            </p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="col-5">
                                                    <div class="text-center" style="background-color: #4831D4;padding: 5px;border-radius: 10px; box-shadow: 5px 5px 5px grey; border: 1px solid grey;">
                                                        <p class="statistics-title text-light" style="font-size: 18px;">Total income of drinks / 1 
                                                        <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                month
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                year
                                                            </c:if></p>
                                                        <p class="text-light text-center" style="font-size: 16px;">
                                                            <c:if test="${yearNumber == '' || yearNumber == nowYear}">
                                                                -- <fmt:formatDate pattern="M / yyyy" value="${now}" /> vs <fmt:formatDate pattern="M / yyyy" value="${yesterday}" /> --
                                                            </c:if>
                                                            <c:if test="${yearNumber != '' && yearNumber != nowYear}">
                                                                -- ${yearNumber} vs  <fmt:formatDate pattern="yyyy" value="${beforeYear}" />-- 
                                                            </c:if>
                                                        </p>
                                                        <h2 class="rate-percentage text-light" style="font-weight: bolder;"><fmt:formatNumber type="number" value="${subtotalPaymentBuyFood}" />đ</h2>
                                                        <c:if test="${resultCompareBookingBuyFood < 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-down"></i><span><fmt:formatNumber type="number" value="${0 - resultCompareBookingBuyFood}" />đ</span>
                                                            </p>
                                                        </c:if>
                                                        <c:if test="${resultCompareBookingBuyFood >= 0}">
                                                            <p class="text-light d-flex justify-content-center" style="font-size: 16px;">
                                                                <i class="mdi mdi-menu-up"></i><span><fmt:formatNumber type="number" value="${resultCompareBookingBuyFood}" />đ</span>
                                                            </p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col d-flex flex-column">
                                                    <div class="row flex-grow">
                                                        <div class="col-12 grid-margin stretch-card">
                                                            <div class="card card-rounded">
                                                                <div class="card-body">
                                                                    <div class="d-sm-flex justify-content-between align-items-start">
                                                                        <div>
                                                                            <h4 class="card-title card-title-dash">Monthly income chart</h4>
                                                                        </div>
                                                                        <div>
                                                                            <a href="${pageContext.request.contextPath}/admin/changeYearPaymentChart/<fmt:formatDate pattern="yyyy" value="${datePresent}" />" class="btn btn-group <c:if test="${yearNumber == yearPresent || yearNumber == null}">btn-danger</c:if>" <c:if test="${yearNumber == yearPresent || yearNumber == null}">style="color: white;"</c:if>>Year <fmt:formatDate pattern="yyyy" value="${datePresent}" /></a>
                                                                            <a href="${pageContext.request.contextPath}/admin/changeYearPaymentChart/<fmt:formatDate pattern="yyyy" value="${dateOneBefore}" />" class="btn btn-group <c:if test="${yearNumber == yearOneBefore}">btn-danger</c:if>" <c:if test="${yearNumber == yearOneBefore}">style="color: white;"</c:if>>Year <fmt:formatDate pattern="yyyy" value="${dateOneBefore}" /></a>
                                                                            <a href="${pageContext.request.contextPath}/admin/changeYearPaymentChart/<fmt:formatDate pattern="yyyy" value="${dateTwoBefore}" />" class="btn btn-group <c:if test="${yearNumber == yearTwoBefore}">btn-danger</c:if>" <c:if test="${yearNumber == yearTwoBefore}">style="color: white;"</c:if>>Year <fmt:formatDate pattern="yyyy" value="${dateTwoBefore}" /></a>
                                                                            </div>
                                                                        </div>
                                                                        <div class="d-sm-flex align-items-center mt-1 justify-content-between">
                                                                            <div class="d-sm-flex align-items-center mt-4 justify-content-between">
                                                                                    <h2 class="me-2 fw-bold"><fmt:formatNumber type="number" value="${yeartotalAmount}" /></h2>
                                                                            <h4 class="me-2">đ</h4>
                                                                        </div>
                                                                    </div>
                                                                    <div class="chartjs-bar-wrapper mt-3">
                                                                        <canvas id="marketingOverview"></canvas>
                                                                        <!--dashboard.js dòng 374 - 454-->
                                                                    </div>
                                                                    <script>
                                                                        var marketingOverviewChart = document.getElementById("marketingOverview");
                                                                        var marketingOverviewData = {
                                                                            labels: ["JAN", "FEB", "MAR", "APR", "MAY", "JUN", "JUL", "AUG", "SEP", "OCT", "NOV", "DEC"],
                                                                            datasets: [{
                                                                                    data: ${paymentChart},
                                                                                    backgroundColor: "#1F3BB3",
                                                                                    borderColor: [
                                                                                        '#1F3BB3',
                                                                                    ],
                                                                                    borderWidth: 0,
                                                                                    fill: true, // 3: no fill
                                                                                }]
                                                                        };
                                                                    </script>
                                                                </div>
                                                            </div>
                                                        </div>
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