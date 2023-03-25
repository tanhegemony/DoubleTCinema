
<%@page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Manage User Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/manage_user.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/manage_user_responsive.css" />"/>


    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container content mt-3">
            <div class="row">
                <div class="col content1">
                    <nav>
                        <div class="nav nav-tabs justify-content-center" id="nav-tab" role="tablist">
                            <form action="${pageContext.request.contextPath}/manage_user" method="get">
                                <input type="hidden" name="contentNavManageUser" value="manageCustomer">
                                <button class="nav-link
                                        <c:if test="${contentNavManageUser == 'manageCustomer'}">
                                            active
                                        </c:if>
                                        " id="nav-manageProfile-tab" 
                                        onclick="location.href = '${pageContext.request.contextPath}/manage_user#manageCustomer'"
                                        role="tab"  aria-controls="nav-manageProfile"
                                        aria-selected="true">Quản lý thông tin cá nhân</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/manage_user" method="get">
                                <input type="hidden" name="contentNavManageUser" value="manageTransactionHistory">
                                <button class="nav-link
                                        <c:if test="${contentNavManageUser == 'manageTransactionHistory'}">
                                            active
                                        </c:if>
                                        " id="nav-manageTransactionHistory-tab" 
                                        onclick="location.href = '${pageContext.request.contextPath}/manage_user#manageTransactionHistory'"
                                        role="tab"
                                        aria-controls="nav-manageTransactionHistory" aria-selected="false">Quản lý lịch sử giao
                                    dịch</button>
                            </form>
                            <form action="${pageContext.request.contextPath}/manage_user" method="get">
                                <input type="hidden" name="contentNavManageUser" value="manageAccountBanking">
                                <button class="nav-link
                                        <c:if test="${contentNavManageUser == 'manageAccountBanking'}">
                                            active
                                        </c:if>
                                        " id="nav-manageAccountBanking-tab" 
                                        onclick="location.href = '${pageContext.request.contextPath}/manage_user#manageAccountBanking'"
                                        role="tab"
                                        aria-controls="nav-manageAccountBanking" aria-selected="false">Quản lý tài khoản ngân
                                    hàng</button>
                            </form>

                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade
                             <c:if test="${contentNavManageUser == 'manageCustomer'}">
                                 show active
                             </c:if>
                             " id="nav-manageProfile" role="tabpanel"
                             aria-labelledby="nav-manageProfile-tab">
                            <div class="row breadcrumbContent">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item">
                                                <a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i> Trang chủ</a>
                                            </li>
                                            <li class="breadcrumb-item active" aria-current="page"> Quản lý tài khoản : Quản
                                                lý thông tin cá nhân
                                            </li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                            <div class="row userInfo">
                                <div class="col">
                                    <c:if test="${displayUpdateAccountBySendMail == false}">
                                        <mvc:form action="${pageContext.request.contextPath}/result_save_customer" method="post"
                                                  modelAttribute="customer" enctype="multipart/form-data">
                                            <div class="row">
                                                <div class="col">
                                                    <input type="hidden" name="id" value="${customer.id}">
                                                    <input type="hidden" name="account.id" value="${account.id}">
                                                    <input type="hidden" name="password" value="${account.password}">
                                                    <input type="hidden" name="contentNavManageUser" value="${contentNavManageUser}">
                                                    <input type="hidden" value="${account.imageAccount}" name="account.imageAccount">
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-6 imgAccount">
                                                    <script>
                                                        function chooseFile(fileInput) {
                                                            if (fileInput.files && fileInput.files[0]) {
                                                                var reader = new FileReader();

                                                                reader.onload = function (e) {
                                                                    $('#image').attr('src', e.target.result);
                                                                }

                                                                reader.readAsDataURL(fileInput.files[0]);
                                                            }
                                                        }
                                                    </script>
                                                    <img id="image" class="mt-2" src="${pageContext.request.contextPath}/resources/images/user/<c:if test="${account.imageAccount == null || account.imageAccount == ''}">no_image_user.png</c:if><c:if test="${account.imageAccount != null}">${account.imageAccount}</c:if>" alt="">
                                                        <div class="form-group mt-2">
                                                            <label for="account.imageAcc">Image Account: </label>
                                                            <input type="file" onchange="chooseFile(this)" name="account.imageAcc"
                                                                   id="account.imageAcc">
                                                        </div>

                                                    </div>
                                                    <div class="col-6 infoCustomer">
                                                        <div class="row">
                                                            <div class="col">
                                                                <div class="form-group">
                                                                    <label for="customerName">CustomerName: </label>
                                                                    <input type="text" class="form-control" name="customerName"
                                                                           id="customerName" value="${customer.customerName}">
                                                                <small class="form-text text-muted">
                                                                    <mvc:errors path="customerName" />
                                                                </small>

                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label for="customerEmail">CustomerEmail: </label>
                                                                <input type="text" class="form-control" name="customerEmail"
                                                                       id="customerEmail" value="${customer.customerEmail}">
                                                                <small class="form-text text-muted">
                                                                    <c:if test="${messageEmail != null}">
                                                                        <h1  style="color: red;font-size: 15px;">${messageEmail}</h1>
                                                                    </c:if>
                                                                    <mvc:errors path="customerEmail" />
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label for="customerPhone">CustomerPhone: </label>
                                                                <input type="text" class="form-control" name="customerPhone"
                                                                       id="customerPhone" value="${customer.customerPhone}">
                                                                <small class="form-text text-muted">
                                                                    <c:if test="${messagePhone != null}">
                                                                        <h1  style="color: red;font-size: 15px;">${messagePhone}</h1>
                                                                    </c:if>
                                                                    <mvc:errors path="customerPhone" />
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label for="birthDate">BirthDate: </label>
                                                                <input type="date" max="${maxDate}" pattern="yyyy-MM-dd" class="form-control" name="birthDate" id="birthDate"
                                                                       value="${birthDate}" aria-describedby="birthDateHid">
                                                                <small id="birthDateHid" class="form-text text-muted">
                                                                    <mvc:errors path="birthDate" />
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label for="gender">Gender: </label>
                                                                <select id="gender" class="form-control" name="gender" aria-describedby="genderHid">
                                                                    <option value="">Chọn giới tính</option>
                                                                    <c:forEach var="gender" items="${genders}">
                                                                        <c:if test="${customer.gender == gender}">
                                                                            <option value="${gender}" selected>
                                                                                <c:if test="${gender == 'MALE'}">Nam</c:if>
                                                                                <c:if test="${gender == 'FEMALE'}">Nữ</c:if>
                                                                                <c:if test="${gender == 'OTHER'}">Khác</c:if>
                                                                                </option>
                                                                        </c:if>
                                                                        <c:if test="${customer.gender != gender}">
                                                                            <option value="${gender}">
                                                                                <c:if test="${gender == 'MALE'}">Nam</c:if>
                                                                                <c:if test="${gender == 'FEMALE'}">Nữ</c:if>
                                                                                <c:if test="${gender == 'OTHER'}">Khác</c:if>
                                                                                </option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                                <small id="genderHid" class="form-text text-muted">
                                                                    <mvc:errors path="gender" />
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col">
                                                            <div class="form-group">
                                                                <label for="customerAddress">CustomerAddress: </label>
                                                                <textarea name="customerAddress" id="customerAddress"
                                                                          placeholder="Nhập địa chỉ của bạn" aria-describedby="customerAddressHid">${customer.customerAddress}</textarea>
                                                                <small id="customerAddressHid" class="form-text text-muted">
                                                                    <mvc:errors path="customerAddress" />
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row text-center updateButton">
                                                        <div class="col">   
                                                            <button onclick="location.href = '<c:url value="/result_save_customer" />'" class="btn">Cập nhật thông tin người dùng</button>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </mvc:form>
                                    </c:if>
                                    <c:if test="${displayUpdateAccountBySendMail == true}">
                                        <mvc:form action="${pageContext.request.contextPath}/updateAccountBySendEmail" method="post" >
                                            <div style="color: white;text-align: center; ">
                                                <span id="time">01:00</span>
                                                <b style="color: red;font-size: 13px;">(Mã có hiệu lực trong vòng 1 phút - sau 1 phút sẽ quay lại trang <a href="manage_user?contentNavManageUser=manageCustomer" style="color: #31d7a9;">quản lý thông tin</a>)</b>
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
                                                            window.location.href = 'manage_user?contentNavManageUser=manageCustomer';
                                                        }
                                                    }, 1000);
                                                }

                                                window.onload = function () {
                                                    var fifteenMinutes = 60 * 1,
                                                            display = document.querySelector('#time');
                                                    startTimer(fifteenMinutes, display);
                                                };
                                            </script>

                                            <div class="row justify-content-center">
                                                <div class="col-6">
                                                    <div class="form-group">
                                                        <label style="color: red;">Bạn vui lòng kiểm tra Email mà bạn vừa thay đổi để nhận mã xác nhận!</label>
                                                        <input type="text" style="color: black;border: 1px solid gray;"  
                                                               class="form-control" maxlength="6" name="codeRandomCheck" placeholder="Code Confirm Update" required>
                                                    </div>
                                                    <c:if test="${message != null && message != ''}">
                                                        <h1  style="color: red;font-size: 15px;">${message}</h1>
                                                    </c:if>
                                                    <button type="submit" class="btn confirmButton">Xác nhận</button>
                                                </div>
                                            </div>
                                        </mvc:form>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="tab-pane fade
                             <c:if test="${contentNavManageUser == 'manageTransactionHistory'}">
                                 show active
                             </c:if>
                             " id="nav-manageTransactionHistory" role="tabpanel"
                             aria-labelledby="nav-manageTransactionHistory-tab">
                            <c:if test="${viewDetail == false}">
                                <div class="row breadcrumbContent">
                                    <div class="col">
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item">
                                                    <a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i> Trang chủ</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page"> Quản lý tài khoản : Quản
                                                    lý lịch sử giao dịch
                                                </li>
                                            </ol>
                                        </nav>
                                    </div>
                                </div>
                                <form action="manage_user" method="get">
                                    <input type="hidden" name="contentNavManageUser" value="manageTransactionHistory">
                                    <div class="row filterBooking">
                                        <div class="col-3">
                                            <div class="form-group">
                                                <label for="startDate">Từ ngày: </label>
                                                <input type="date" class="form-control" max="${toDate}" name="startDate" onchange="this.form.submit();" id="startDate"
                                                       value="${startDate}">
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-group">
                                                <label for="toDate">Đến hết ngày: </label>
                                                <input type="date" class="form-control" min="${startDate}" onchange="this.form.submit();" name="toDate" id="toDate"
                                                       value="${toDate}">
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-group">
                                                <label for="sortStatus">Hiển thị theo trạng thái: </label>
                                                <select class="form-control" name="sortStatus" id="sortStatus" onchange="this.form.submit();">
                                                    <option value="">Chọn trạng thái</option>
                                                    <c:forEach var="bookingStt" items="${bookingStatus}">
                                                        <c:if test="${sortStatus == bookingStt}">
                                                            <option value="${bookingStt}" selected>
                                                                <c:if test="${bookingStt == 'Completed'}">
                                                                    Đã hoàn thành
                                                                </c:if>
                                                                <c:if test="${bookingStt == 'Canceled'}">
                                                                    Đã huỷ
                                                                </c:if>
                                                            </option>
                                                        </c:if>

                                                        <c:if test="${sortStatus != bookingStt}">
                                                            <option value="${bookingStt}">
                                                                <c:if test="${bookingStt == 'Completed'}">
                                                                    Đã hoàn thành
                                                                </c:if>
                                                                <c:if test="${bookingStt == 'Canceled'}">
                                                                    Đã huỷ
                                                                </c:if>
                                                            </option>
                                                        </c:if>
                                                    </c:forEach>

                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-3">
                                            <div class="form-group">
                                                <label for="sortBy">Sắp xếp theo: </label>
                                                <select class="form-control" name="sortBy" id="sortBy" onchange="this.form.submit();">
                                                    <option value="bookingDate"
                                                            <c:if test="${sortBy == 'bookingDate'}">
                                                                selected
                                                            </c:if>
                                                            >Ngày mua vé</option>
                                                    <option value="bookingDetail.movie.nameByEnglish"
                                                            <c:if test="${sortBy == 'bookingDetail.movie.nameByEnglish'}">
                                                                selected
                                                            </c:if>>Tên phim</option>
                                                    <option value="subtotal"
                                                            <c:if test="${sortBy == 'subtotal'}">
                                                                selected
                                                            </c:if>>Tổng tiền</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                </form>
                                <div class="row tableBooking">
                                    <div class="col">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th class="bookingDate">Ngày mua vé</th>
                                                    <th class="infomationTicket">Thông tin vé</th>
                                                    <th class="subtotal">Tổng tiền</th>
                                                    <th class="status">Trạng thái</th>
                                                    <th>&nbsp;</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:if test="${bookings.size() <= 0}">
                                                    <tr>
                                                        <td class="text-center" colspan="5">
                                                            <b style="color: #31d7a9;">Bạn chưa mua vé nào! Hãy bắt đầu mua vé tại DoubleT Cinema đi nhé ! Love 3000 !</b>
                                                        </td>
                                                    </tr>
                                                </c:if>
                                                <c:if test="${bookings.size() > 0}">
                                                    <c:forEach var="booking" items="${bookings}">
                                                        <tr>
                                                            <td class="text-center"><fmt:formatDate type="date" pattern="yyyy-MM-dd HH:mm:ss" value="${booking.bookingDate}"  /></td>
                                                            <td>
                                                                <div class="row justify-content-center">
                                                                    <div class="col-5 imgMovieTicket">
                                                                        <img class="img-fluid"
                                                                             src="${pageContext.request.contextPath}/resources/images/movies/coming/${booking.bookingDetail.movie.imageMovie}" alt="">
                                                                    </div>
                                                                    <div class="col-7 infoTicket">
                                                                        <h6 class="nameMovie">Phim: <span>${booking.bookingDetail.movie.nameByEnglish}</span>
                                                                        </h6>
                                                                        <h6 class="element">Rạp: <span>${booking.bookingDetail.cinema.nameCinema}</span></h6>
                                                                        <h6 class="element">Phòng chiếu: <span>${booking.bookingDetail.cinemaRoom.cinemaRoomName}</span></h6>
                                                                        <h6 class="element">Ngày chiếu: <span>${booking.bookingDetail.showDate}</span></h6>
                                                                        <h6 class="element">Giờ chiếu: <span>${booking.bookingDetail.showTime}</span></h6>
                                                                        <h6 class="element">Số lượng vé: <span>${booking.bookingDetail.quantityTicket}</span></h6>
                                                                        <h6 class="element">Ghế: 
                                                                            <span>
                                                                                <c:forEach var="bookingSeat" items="${booking.bookingSeats}">
                                                                                    ${bookingSeat.seatNumber},
                                                                                </c:forEach>
                                                                            </span>
                                                                        </h6>
                                                                    </div>
                                                                </div>
                                                            </td>
                                                            <td class="text-center"><fmt:formatNumber type="number" value="${booking.subtotal}" />đ</td>
                                                            <td class="text-center">
                                                                <c:if test="${bookingStt == 'Completed'}">
                                                                    Đã hoàn thành
                                                                </c:if>
                                                                <c:if test="${booking.status == 'Canceled'}">
                                                                    Đã huỷ
                                                                </c:if>
                                                            </td>

                                                            <td class="text-center viewBookingDetail">
                                                                <a href="${pageContext.request.contextPath}/viewBookingDetail/${booking.id}" title="Xem chi tiết đơn hàng" style="color: #31d7a9;"><i
                                                                        class="fas fa-eye"></i></a>
                                                                <div id="printBill${booking.id}" style="display: none;">
                                                                    <div id="bill" class="container-fluid">
                                                                        <div class="row justify-content-center">
                                                                            <div class="col-5" style="border: 2px solid black;">
                                                                                <h3 class="mt-5" style="text-transform: uppercase; text-align: center;">Vé xem phim</h3>
                                                                                <div class="row">
                                                                                    <div class="col">
                                                                                        <h5 style="text-transform: uppercase; font-weight: bold;">Khách hàng</h5>
                                                                                        <h6>DoubleT Cinema</h6>
                                                                                        <h5>${booking.bookingDetail.cinema.nameCinema} - ${booking.bookingDetail.cinema.cinemaAddress}</h5>
                                                                                    </div>
                                                                                </div>
                                                                                <hr style="border: 1px dotted black;">
                                                                                <h6><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${booking.bookingDate}" /> / VN</h6>
                                                                                <hr style="border: 1px dotted black;">
                                                                                <div class="row">
                                                                                    <div class="col">
                                                                                        <h4 style="text-transform: uppercase;">${booking.bookingDetail.movie.nameByEnglish}</h4>
                                                                                        <h5>${booking.bookingDetail.showDate} ${booking.bookingDetail.showTime}</h5>
                                                                                        <div class="row">
                                                                                            <div class="col-5">
                                                                                                <h6>Phòng chiếu: ${booking.bookingDetail.cinemaRoom.cinemaRoomName}</h6>
                                                                                            </div>
                                                                                            <div class="col-7 text-right">
                                                                                                <h6>Ghế: 
                                                                                                    <c:forEach var="bookingSeat" items="${booking.bookingSeats}">
                                                                                                        ${bookingSeat.seatNumber},
                                                                                                    </c:forEach></h6>
                                                                                            </div>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <c:if test="${booking.bookingFoods.size() > 0}">
                                                                                    <hr style="border: 1.5px dotted black;">
                                                                                    <div class="row">
                                                                                        <div class="col">
                                                                                            <h6 style="text-transform: uppercase; font-weight: bold;">Thức ăn, thức uống</h6>
                                                                                            <h6>Tên: 
                                                                                                <div class="row">
                                                                                                    <c:forEach var="f" items="${booking.bookingFoods}">
                                                                                                        <div class="col-6">
                                                                                                            ${f.quantityFood} ${f.food.nameFood}
                                                                                                        </div>
                                                                                                    </c:forEach>
                                                                                                </div>
                                                                                            </h6>
                                                                                        </div>
                                                                                    </div>
                                                                                </c:if>
                                                                                <hr style="border: 2px solid black;">
                                                                                <div class="row mb-5">
                                                                                    <div class="col-6">
                                                                                        <h5 style="text-transform: uppercase; font-weight: bold;text-align: left;">Thanh toán</h5>
                                                                                    </div>
                                                                                    <div class="col-6 text-right">
                                                                                        <h5 style="font-weight: bold; font-size: 25px;"><fmt:formatNumber type="number" value="${booking.subtotal}" />đ</h5>
                                                                                    </div>
                                                                                </div>

                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <button class="btn btn-secondary" onclick="printOut('printBill${booking.id}');">In vé</button>
                                                                <script>
                                                                    function printOut(divId) {
                                                                        var printOutContent = document.getElementById(divId).innerHTML;
                                                                        var originalContent = document.body.innerHTML;
                                                                        document.body.innerHTML = printOutContent;
                                                                        window.print();
                                                                        document.body.innerHTML = originalContent;
                                                                    }
                                                                </script>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>

                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>
                            <c:if test="${viewDetail == true}">
                                <div class="row breadcrumbContent">
                                    <div class="col">
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item">
                                                    <a href="${pageContext.request.contextPath}/manage_user?contentNavManageUser=manageTransactionHistory">Quản lý lịch sử giao dịch</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page"> Ngày mua vé: <fmt:formatDate type="date" pattern="yyyy-MM-dd HH:mm:ss" value="${booking.bookingDate}"  /> 
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page"> Phim: ${booking.bookingDetail.movie.nameByEnglish}
                                                </li>
                                            </ol>
                                        </nav>
                                    </div>
                                </div>
                                <div class="row tableBookingDetail">
                                    <div class="col">
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th class="ticketInfo">Thông tin vé</th>
                                                    <th class="foodInfo">Thức ăn & Đồ uống</th>
                                                    <th class="seat">Chỗ ngồi</th>
                                                    <th class="promotion">Mã giảm giá</th>
                                                    <th class="emailCus">Email khách hàng</th>
                                                    <th class="phoneCus">Phone khách hàng</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="bd" items="${bookingDetails}">
                                                    <tr>
                                                        <td>
                                                            <p><span style="color: #31d7a9;font-weight: bold;">Tổng số vé:</span> ${bd.quantityTicket}</p>
                                                            <p><span style="color: #31d7a9;font-weight: bold;">Loại vé:</span> <br>
                                                                <c:forEach var="bt" items="${bd.booking.bookingTickets}">
                                                                    ${bt.quantityTicket} - ${bt.ticket.ticketName} <br>
                                                                </c:forEach>
                                                            </p>
                                                            <p><span style="color: #31d7a9;font-weight: bold;">Tổng tiền vé:</span> <fmt:formatNumber type="number" value="${bd.totalPriceTicket}" />đ</p>
                                                        </td>
                                                        <td>
                                                            <p><span style="color: #31d7a9;font-weight: bold;">Các loại foods:</span> <br>
                                                                <c:if test="${bd.booking.bookingFoods.size() <= 0}">
                                                                    No Foods
                                                                </c:if>
                                                                <c:if test="${bd.booking.bookingFoods.size() > 0}">
                                                                    <c:forEach var="bf" items="${bd.booking.bookingFoods}">
                                                                        ${bf.quantityFood} - ${bf.food.nameFood} <br>
                                                                    </c:forEach>
                                                                </c:if>
                                                            </p>
                                                            <p><span style="color: #31d7a9;font-weight: bold;">Tổng tiền foods:</span> <fmt:formatNumber type="number" value="${bd.totalPriceFood}" />đ</p>
                                                        </td>
                                                        <td>
                                                            <p><span style="color: #31d7a9;font-weight: bold;">Tổng số ghế:</span> ${bd.booking.bookingSeats.size()}</p>
                                                            <p><span style="color: #31d7a9;font-weight: bold;">Các ghế đã chọn:</span> <br>
                                                                <c:forEach var="bs" items="${bd.booking.bookingSeats}">
                                                                    ${bs.seatNumber} ,
                                                                </c:forEach></p>
                                                        </td>
                                                        <td class="text-center">
                                                            <h6>
                                                                <c:if test="${booking.code != null}">
                                                                    ${booking.code}
                                                                </c:if>
                                                                <c:if test="${booking.code == null || booking.code == ''}">
                                                                    No Apply Promotion
                                                                </c:if>
                                                            </h6>
                                                            <h6>
                                                                -
                                                                <c:if test="${booking.code != null}">
                                                                    <fmt:formatNumber type="number" value="${booking.discount}" />
                                                                </c:if>
                                                                <c:if test="${booking.code == null || booking.code == ''}">
                                                                    <fmt:formatNumber type="number" value="0" />
                                                                </c:if>đ
                                                            </h6>
                                                        </td>
                                                        <td class="text-center email"><a href="#">${booking.customer.customerEmail}</a></td>
                                                        <td class="text-center phone"><a href="#">${booking.customer.customerPhone}</a></td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                        <div class="tab-pane fade
                             <c:if test="${contentNavManageUser == 'manageAccountBanking'}">
                                 show active
                             </c:if>
                             " id="nav-manageAccountBanking" role="tabpanel"
                             aria-labelledby="nav-manageAccountBanking-tab">
                            <div class="row breadcrumbContent">
                                <div class="col">
                                    <nav aria-label="breadcrumb">
                                        <ol class="breadcrumb">
                                            <li class="breadcrumb-item">
                                                <a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i> Trang chủ</a>
                                            </li>
                                            <li class="breadcrumb-item active" aria-current="page"> Quản lý tài khoản : Quản
                                                lý tài khoản ngân hàng
                                            </li>
                                        </ol>
                                    </nav>
                                </div>
                            </div>
                            <div class="row headerContent text-center">
                                <div class="col">
                                    <h4>Thông tin tài khoản ngân hàng của bạn</h4>
                                    <hr style="border: 1px solid #032055; width: 30%" />
                                </div>
                            </div>
                            <div class="row justify-content-center">
                                <div class="col-4 cardAccountBanking">
                                    <div class="box">
                                        <div class="row">
                                            <div class="col-6 logoCard">
                                                <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/SacombankLogo.png" alt="">
                                            </div>
                                            <div class="col-6 text-right debitCard">
                                                <p>debit</p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-6 chipCard">
                                                <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/chipSacom.PNG" alt="">
                                            </div>
                                        </div>
                                        <div class="row text-center">
                                            <div class="col cardNumber">
                                                <h3>
                                                    <c:if test="${accountBanking.cardNumber != null}">${cardNumber}</c:if>
                                                    <c:if test="${accountBanking.cardNumber == null || accountBanking.cardNumber == ''}">0000 0000 0000</c:if>
                                                    </h3>
                                                </div>
                                            </div>
                                            <div class="row ml-2">
                                                <div class="col-6 exAndCardName">
                                                    <b>Expiry Date: <span>
                                                        <c:if test="${accountBanking.monthExpiryDate != null && accountBanking.yearExpiryDate != null}">${accountBanking.monthExpiryDate}/${accountBanking.yearExpiryDate}</c:if>
                                                        <c:if test="${accountBanking.monthExpiryDate == null && accountBanking.yearExpiryDate == null || accountBanking.monthExpiryDate == '' && accountBanking.yearExpiryDate == ''}">00/00</c:if>
                                                        </span>
                                                    </b>
                                                    <h6>
                                                    <c:if test="${accountBanking.cardName != null}">${accountBanking.cardName}</c:if>
                                                    <c:if test="${accountBanking.cardName == null || accountBanking.cardName == ''}">Your Card Name</c:if>
                                                    </h6>
                                                </div>
                                                <div class="col-6 text-right visaCard">
                                                    <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/visa.PNG" alt="">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-2 text-center deduceIcon">
                                    <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/icon/arrow-right.png" alt="">
                                </div>
                                <div class="col-6 addAccountBanking">
                                    <c:if test="${accountBanking.id > 0}">
                                        <h6>Card Number : <span>${accountBanking.cardNumber}</span></h6>
                                        <h6>Card Name : <span>${accountBanking.cardName}</span></h6>
                                        <h6>Email Banking : <span>${accountBanking.emailBanking}</span></h6>
                                        <h6>ExpiryDate : <span>${accountBanking.monthExpiryDate}/${accountBanking.yearExpiryDate}</span></h6>
                                        <h6>CVV Code : <span>${accountBanking.cvvCode}</span></h6>
                                        <h6>Balance : <span><fmt:formatNumber type="number" value="${accountBanking.balance}" />đ</span></h6>
                                        <h6>Status : <span>
                                                <c:if test="${accountBanking.status == 'ACTIVE'}">
                                                    <b style="color: #31a14c;"><i class="fas fa-circle"></i> Hoạt động</b>
                                                </c:if>
                                                <c:if test="${accountBanking.status == 'UNACTIVE'}">
                                                    <b style="color: #d80027;"><i class="fas fa-circle"></i> Không hoạt động</b>
                                                </c:if>
                                            </span>
                                        </h6>
                                        <a href="${pageContext.request.contextPath}/deleteAccountBanking" onclick="return confirm('Bạn chắc chắn muốn huỷ liên kết với tài khoản ngân hàng này?')" class="btn deleteAccountBanking">Huỷ liên kết</a>
                                        <a type="button" data-toggle="modal" class="btn btn-success"
                                           data-target="#confirmModal">
                                               Nạp tiền
                                           </a>
                                           <div class="modal fade" 
                                                id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" 
                                               aria-hidden="true">
                                               <div class="modal-dialog">
                                                   <div class="modal-content">
                                                       <div class="modal-header">
                                                           <h5 class="modal-title" id="confirmModalLabel">Thông báo</h5>
                                                           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                               <span aria-hidden="true">&times;</span>
                                                           </button>
                                                       </div>
                                                       <div class="modal-body text-center">
                                                           <p>Bạn cần liên hệ <span style="color: red; font-weight: bold;">Hotline của DoubleT-Cinema <a href="tel:0376160960">0376160960</a></span> hoặc tới <span style="color: red; font-weight: bold;">trực tiếp rạp DoubleT-Cinema gần nhất</span> để thực hiện nạp tiền vào tài khoản ngân hàng của bạn dùng cho mục đích mua vé xem phim tại DoubleT-Cinema!</p>
                                                   </div>
                                                   <div class="modal-footer">
                                                       <button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
                                                   </div>
                                               </div>
                                           </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${accountBanking.id <= 0}">
                                        <h5 class="text-center">Liên kết tài khoản ngân hàng</h5>
                                        <mvc:form action="${pageContext.request.contextPath}/addAccountBanking" method="post"
                                                  modelAttribute="accountBanking">
                                            <div class="form-group">
                                                <label for="cardNumber">CardNumber (Số thẻ - 12 số): </label>
                                                <input type="text" class="form-control" name="cardNumber" id="cardNumber"
                                                       aria-describedby="cardNumberHid" placeholder="Nhập CardNumber" value="${accountBanking.cardNumber}">
                                                <small id="cardNumberHid" class="form-text text-muted">
                                                    <mvc:errors path="cardNumber" />
                                                </small>
                                            </div>
                                            <div class="form-group">
                                                <label for="cardName">CardName: </label>
                                                <input type="text" class="form-control" name="cardName" id="cardName"
                                                       aria-describedby="cardNameHid" placeholder="Nhập CardName" value="${accountBanking.cardName}">
                                                <small id="cardNameHid" class="form-text text-muted" >
                                                    <mvc:errors path="cardName" />
                                                </small>
                                            </div>
                                            <div class="form-group">
                                                <label for="emailBanking">EmailBanking: </label>
                                                <input type="email" class="form-control" name="emailBanking" id="emailBanking"
                                                       aria-describedby="emailBankingHid" placeholder="Nhập Email Banking" value="${accountBanking.emailBanking}">
                                                <small id="emailBankingHid" class="form-text text-muted">
                                                    <mvc:errors path="emailBanking" />
                                                </small>
                                                <c:if test="${messageEmail != null}">
                                                    <small id="emailBankingHid" class="form-text text-muted">
                                                        ${messageEmail}
                                                    </small>
                                                </c:if>
                                            </div>
                                            <div class="form-group">
                                                <label for="expiryDate">Expiry Date (Ngày hết hạn): </label>
                                                <div class="form-check-inline">
                                                    <input type="number" maxlength="2" class="form-control" name="monthExpiryDate"
                                                           id="monthExpiryDate" aria-describedby="monthExpiryDateHid"
                                                           placeholder="mm" value="01" > <span style="color: white;"> / </span>
                                                    <input type="number" maxlength="2" class="form-control" name="yearExpiryDate"
                                                           id="yearExpiryDate" aria-describedby="yearExpiryDateHid"
                                                           placeholder="YY" value="${yearCurrent}">
                                                </div>
                                                <small id="monthExpiryDateHid" class="form-text text-muted">
                                                    <mvc:errors path="monthExpiryDate" />
                                                </small>
                                                <small id="yearExpiryDateHid" class="form-text text-muted">
                                                    <mvc:errors path="yearExpiryDate" />
                                                </small>
                                                <c:if test="${messageExpiryDate != null}">
                                                    <small id="yearExpiryDateHid" class="form-text text-muted">
                                                        ${messageExpiryDate}
                                                    </small>
                                                </c:if>

                                            </div>
                                            <div class="form-group">
                                                <label for="cvvCode">CVV Code (Mã CVV): </label>
                                                <input type="cvvCode" class="form-control" name="cvvCode" id="cvvCode"
                                                       aria-describedby="cvvCodeHid" placeholder="Nhập Mã CVV" value="${accountBanking.cvvCode}">
                                                <small id="cvvCodeHid" class="form-text text-muted">
                                                    <mvc:errors path="cvvCode" />
                                                </small>
                                            </div>
                                            <button onclick="location.href = '${pageContext.request.contextPath}/addAccountBanking'" class="btn connectionAccountBanking">Liên kết</button>
                                        </mvc:form>
                                    </c:if>


                                </div>
                            </div>
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
