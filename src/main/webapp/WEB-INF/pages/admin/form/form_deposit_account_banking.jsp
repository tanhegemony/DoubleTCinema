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
        <title>Deposit In Customer Credit Card</title>
        <jsp:include page="../../include/management/css.jsp" />
    </head>

    <body>
        <div class="container-scroller">
            <!-- header -->
            <jsp:include page="../../include/management/header.jsp" />
            <div class="container-fluid page-body-wrapper">
                <!-- Menu -->
                <jsp:include page="../../include/management/menu.jsp" />
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <!-- Nhập nội dung -->
                                    <div class="col-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center">Deposit for Customer Credit Card</h4>
                                                <c:if test="${action == 'deposit'}">
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <h5 class="text-center">Customer Credit Card Information</h5>
                                                            <div class="form-group">
                                                                <label>Card Number: </label>
                                                                <input type="text" class="form-control" value="${sessionScope.accountBanking.cardNumber}" disabled>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Owner Name: </label>
                                                                <input type="text" class="form-control" value="${sessionScope.accountBanking.cardName}" disabled>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <h5 class="text-center">Deposit Information</h5>
                                                            <mvc:form action="${pageContext.request.contextPath}/admin/resultDeposit" method="POST">
                                                                <input type="hidden" class="form-control" name="abId" value="${sessionScope.accountBanking.id}">
                                                                <div class="form-group">
                                                                    <label>Deposit Balance: </label>
                                                                    <input type="text" class="form-control" name="depositBalance" id="formatBalance" 
                                                                           value="<c:if test="${depositBalance != ''}">${depositBalance}</c:if><c:if test="${depositBalance == ''}">0</c:if>">
                                                                    <c:if test="${messageDeposit != ''}">
                                                                        <p class="card-description" style="color: red;">
                                                                            ${messageDeposit} 
                                                                        </p>
                                                                    </c:if>
                                                                </div>
                                                                <div class="form-group">
                                                                    <label >Staff: </label>
                                                                    <input type="text" class="form-control"  value="${accountLogin.customer.customerName}" readonly>
                                                                </div>
                                                                <button class="btn btn-primary me-2" style="color: white;"><i class="fas fa-money-bill-wave"></i> Deposit</button>
                                                            </mvc:form>
                                                        </div>
                                                    </div>
                                                </c:if>
                                                <c:if test="${action == 'completeTransaction'}">
                                                    <div class="row">
                                                        <div class="col">
                                                            <h5 class="text-center">Transaction Complete</h5>
                                                            <div class="text-center">
                                                                <img src="${pageContext.request.contextPath}/resources/images/icon/complete.png" style="width: 10%;" class="img-fluid" alt="">
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Card Number: </label>
                                                                <input type="text" class="form-control" value="${sessionScope.accountBanking.cardNumber}" disabled>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Owner Name: </label>
                                                                <input type="text" class="form-control" value="${sessionScope.accountBanking.cardName}" disabled>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Deposit Balance: </label>
                                                                <input type="text" class="form-control" value="<fmt:formatNumber type="number" value="${transactionCinema.depositBalance}" />đ" disabled>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Transaction Staff: </label>
                                                                <input type="text" class="form-control" value="${accountLogin.customer.customerName}" disabled>
                                                            </div>
                                                            <div class="form-group">
                                                                <label>Transaction Date: </label>
                                                                <input type="text" class="form-control" value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${transactionDate}" />" disabled>
                                                            </div>
                                                            <div id="printBill" style="display: none;">
                                                                <div id="bill" class="row justify-content-center">
                                                                    <div class="col-7 mt-5" style="border: 2px solid black;">
                                                                        <div class="row justify-content-center">
                                                                            <div class="col text-center">
                                                                                <img class="img-fluid" width="30%" src="${pageContext.request.contextPath}/resources/images/logo-print.png" alt=""/>
                                                                            </div>
                                                                        </div>
                                                                            <h5 class="text-center mt-3" style="text-transform: uppercase;">Transaction Bill</h5>
                                                                        <table class="table table-borderless mb-3">
                                                                            <tr>
                                                                                <th>Card Number: </th>
                                                                                <td>${sessionScope.accountBanking.cardNumber}</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Owner Name: </th>
                                                                                <td>${sessionScope.accountBanking.cardName}</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Deposit Balance: </th>
                                                                                <td><fmt:formatNumber type="number" value="${transactionCinema.depositBalance}" />đ</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Transaction Staff: </th>
                                                                                <td>${accountLogin.customer.customerName}</td>
                                                                            </tr>
                                                                            <tr>
                                                                                <th>Transaction Date: </th>
                                                                                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${transactionDate}" /></td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </div>
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
                                                            <button class="btn btn-warning" style="color: black;" onclick="printOut('printBill');"><i class="fas fa-print"></i> Print</button>
                                                        </div>
                                                    </div>
                                                </c:if>

                                                <script>
                                                    var number = document.getElementById("formatBalance");
                                                    number.addEventListener('keyup', function (evt) {
                                                        var n = parseFloat(this.value.replace(/\D/g, ''), 10);
                                                        number.value = n.toLocaleString("en-AU");
                                                    }, false);
                                                </script>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- footer -->
                    <jsp:include page="../../include/management/footer.jsp" />
                </div>
            </div>
        </div>
        <jsp:include page="../../include/management/js.jsp" />
    </body>

</html>