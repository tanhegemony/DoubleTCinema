<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>Buy Food</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
              integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <jsp:include page="../../include/management/css.jsp" />
        
        <style>
            .quantity>.form-inline>.minus{
                border: 1px solid #343a40;
                width: 2rem;
                height: 2.3rem;
                border-radius: 5px 0px 0px 5px;
                background-color: #001232;
                color: white;
            }
            .quantity>.form-inline>.extra{
                border: 1px solid #343a40;
                width: 2rem;
                height: 2.3rem;
                border-radius: 0px 5px 5px 0px;
                background-color: #001232;
                color: white;
            }
            .quantity>.form-inline>input{
                width: 5rem;
                height: 2.3rem;
                border: 1px solid #343a40;
                text-align: center;

            }
        </style>
    </head>

    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <!-- header -->
            <jsp:include page="../../include/management/header.jsp" />
            <!-- partial -->
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="../../include/management/menu.jsp" />
                <!-- partial -->
                <div class="main-panel">
                    <div class="content-wrapper ">
                        <div class="row grid-margin ">
                            <div class="col-sm-12 ">
                                <div class="home-tab ">
                                    <div class="col-12 grid-margin">
                                        <div class="card">
                                            <div class="card-body">
                                                <div class="row">
                                                    <div class="col-4">
                                                        <h3 class="text-center">Customer Information</h3>
                                                        <table class="table table-responsive table-borderless">
                                                            <tr>
                                                                <th>Customer:</th>
                                                                <td>${invoice.booking.customer.customerName}</td>
                                                            </tr>
                                                            <tr>
                                                                <th>Phone Number:</th>
                                                                <td>${invoice.booking.customer.customerPhone}</td>
                                                            </tr>
                                                            <tr>
                                                                <th>Email:</th>
                                                                <td>${invoice.booking.customer.customerEmail}</td>
                                                            </tr>
                                                        </table>
                                                        <hr style="border: 1px dotted black;">
                                                        <h3 class="text-center">Ticket Information</h3>
                                                        <table class="table table-responsive table-borderless">
                                                            <tr>
                                                                <th>Movie:</th>
                                                                <td>${invoice.booking.bookingDetail.movie.nameByEnglish}</td>
                                                            </tr>
                                                            <tr>
                                                                <th>ShowTime:</th>
                                                                <td>${invoice.booking.bookingDetail.showDate} ${invoice.booking.bookingDetail.showTime}</td>
                                                            </tr>
                                                            <tr>
                                                                <th>Cinema:</th>
                                                                <td>${invoice.booking.bookingDetail.cinema.nameCinema} - ${invoice.booking.bookingDetail.cinema.cinemaAddress}</td>
                                                            </tr>
                                                            <tr>
                                                                <th>CinemaRoom:</th>
                                                                <td>${invoice.booking.bookingDetail.cinemaRoom.cinemaRoomName}</td>
                                                            </tr>
                                                            <tr>
                                                                <th>Seats: </th>
                                                                <td>
                                                                    <c:forEach var="seat" items="${invoice.booking.bookingSeats}">
                                                                        ${seat}, 
                                                                    </c:forEach>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th>Invoice Date:</th>
                                                                <td>${invoice.invoiceDate}</td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <div class="col-8">
                                                        <c:if test="${stage == 'buyFood'}">
                                                            <h3 class="text-center">Buy Foods</h3>
                                                            <form action="${pageContext.request.contextPath}/admin/resultBuyFood" method="POST">
                                                                <div class="form-group mt-4 mb-4">
                                                                    <label for="" class="mr-5">Foods: </label>
                                                                    <div class="form-check-inline">
                                                                        <c:forEach var="f" items="${sessionScope.foods}">
                                                                            <label class="form-check-label mr-3">
                                                                                <input type="radio" class="form-check-input" onchange="this.form.submit();" name="food" id="food" value="${f.id}"
                                                                                       <c:if test="${food == f.id}">checked</c:if>>
                                                                                ${f.nameFood}
                                                                            </label>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                                <p class="card-description" style="color: red;">
                                                                    <c:if test="${messageFood != ''}">
                                                                        ${messageFood}
                                                                    </c:if>
                                                                </p>
                                                                <div class="form-inline quantity">
                                                                    <label for="" class="mr-5">Quantity: </label>
                                                                    <div class="form-inline justify-content-center">
                                                                        <button onclick="minusQuantity(${food})" class="minus" <c:if test="${quantityBuyFood == 1}">disabled</c:if>>
                                                                                - </button>
                                                                            <input type="number" min="0" max="10" step="1" onchange="this.form.submit()"  name="quantity_buy_food" id="quantity_food_${food}" value="<c:if test="${quantityBuyFood == '' || quantityBuyFood == null}">1</c:if><c:if test="${quantityBuyFood != '' || quantityBuyFood != null}">${quantityBuyFood}</c:if>">
                                                                        <button title="Bạn chỉ được mua tối đa 10 thức ăn cho 1 loại!!" onclick="extraQuantity(${food})" 
                                                                                <c:if test="${quantityBuyFood == 10}">disabled</c:if> class="extra">
                                                                                    + </button>
                                                                        </div>
                                                                    </div>

                                                                    <script>
                                                                        function extraQuantity(id) {
                                                                            for (let i = 1; i <= ${foods.size()}; i++) {
                                                                                if (id == i) {
                                                                                    let number = document.querySelector('#quantity_food_' + i);
                                                                                    let value = number.value++;
                                                                                    number.addEventListener('change', () => {
                                                                                    })
                                                                                }
                                                                            }
                                                                        }
                                                                        function minusQuantity(id, name) {
                                                                            for (let i = 1; i <= ${foods.size()}; i++) {
                                                                                if (id == i) {
                                                                                    let number = document.querySelector('#quantity_food_' + i);
                                                                                    let value = number.value--;
                                                                                    number.addEventListener('change', () => {
                                                                                    })
                                                                                }
                                                                            }
                                                                        }
                                                                </script>
                                                                <p class="mt-3"><b style="font-size: 15px;">Total price of selected food: <b style="color: red;"><fmt:formatNumber type="number" value="${subtotalFood}" />đ</b></b></p>
                                                                <button class="btn btn-secondary mt-1 mb-3" name="buttonAdd" value="addFood" style="background-color: grey;color: white;" ><i class="fas fa-plus"></i> Add</button>
                                                            </form>
                                                            <c:if test="${buyFoodsAtCinema.size() > 0}">
                                                                <div class="row">
                                                                    <div class="col">
                                                                        <h6>List Add Foods: </h6>
                                                                        <c:forEach var="bfac" items="${buyFoodsAtCinema}">
                                                                            <button class="btn btn-light">${bfac.quantityFood} ${bfac.food.nameFood} <a href="${pageContext.request.contextPath}/admin/deleteFoodInListBuy/${bfac.food.id}" class="ml-2" style="color: red;"><i class="fas fa-times-circle"></i></a></button> 
                                                                                </c:forEach>
                                                                        <div class="row">
                                                                            <div class="col">
                                                                                Subtotal: <b><fmt:formatNumber type="number" value="${subtotal}" />đ</b>
                                                                                <button onclick="location.href = '${pageContext.request.contextPath}/admin/completeBuyFood'" class="btn btn-success ml-3" style="background-color: green;color: white;"><i class="fas fa-shopping-cart"></i> Buy Foods</button>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                            </c:if>
                                                        </c:if>
                                                        <c:if test="${stage == 'completeBuyFood'}">
                                                            <div class="row">
                                                                <div class="col">
                                                                    <h3 class="text-center">Foods Order</h3>
                                                                    <p><b>List Foods: 
                                                                            <c:forEach var="bfac" items="${buyFoodsAtCinema}">
                                                                                <button class="btn btn-light">${bfac.quantityFood} ${bfac.food.nameFood}</button>
                                                                            </c:forEach>
                                                                        </b></p>
                                                                    <p><b>Subtotal: <span style="color: red;"><fmt:formatNumber type="number" value="${subtotal}" />đ</span></b></p>
                                                                    <form action="${pageContext.request.contextPath}/admin/resultCompleteBuyFood" method="POST">
                                                                        <div class="form-group">
                                                                            <label for="cinema">Cinema:</label>
                                                                            <select class="form-control" name="cinema" id="cinema" style="color: black;">
                                                                                <option value="">Select Cinema...</option>
                                                                                <c:forEach var="c" items="${cinemas}">
                                                                                    <option value="${c.id}" <c:if test="${c.id == cinemaId}">selected</c:if>>${c.nameCinema} - ${c.cinemaAddress}</option>
                                                                                </c:forEach>
                                                                            </select>
                                                                            <p class="card-description" style="color: red;">
                                                                                <c:if test="${messageCinema != ''}">
                                                                                    ${messageCinema}
                                                                                </c:if>
                                                                            </p>
                                                                        </div>
                                                                        <div class="form-group">
                                                                            <label for="staff">Staff:</label>
                                                                            <input type="text" class="form-control" name="staff" value="${accountLogin.customer.customerName}" readonly>
                                                                            <input type="text" class="form-control" name="staff" value="${accountLogin.customer.customerEmail}" readonly>
                                                                            <input type="text" class="form-control" name="staff" value="${accountLogin.customer.customerPhone}" readonly>
                                                                        </div>
                                                                        <button class="btn btn-success" style="color: white;"><i class="fas fa-check"></i> Payment</button>
                                                                    </form>
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
                        </div>
                    </div>
                    <!-- content-wrapper ends -->
                    <!-- partial:partials/_footer.html -->
                    <!-- footer -->
                    <jsp:include page="../../include/management/footer.jsp" />
                    <!-- partial -->
                </div>
                <!-- main-panel ends -->
            </div>
            <!-- page-body-wrapper ends -->
        </div>
        <jsp:include page="../../include/management/js.jsp" />
        <!-- Optional JavaScript -->
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