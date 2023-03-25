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
        <title>
            <c:if test="${action == 'add_ticket'}">Add Ticket Type</c:if>
            <c:if test="${action == 'update_ticket'}">Update Ticket Type</c:if>
            </title>
        <jsp:include page="../../include/management/css.jsp" />
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
                    <div class="content-wrapper">
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <div class="col-12 grid-margin">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center"> 
                                                    <c:if test="${action == 'add_ticket'}">Add Ticket Type</c:if>
                                                    <c:if test="${action == 'update_ticket'}">Update Ticket Type</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveTicket" method="post"
                                                          modelAttribute="ticket">
                                                    <div class="row">
                                                        <c:if test="${action == 'update_ticket'}">
                                                            <input type="hidden" name="id" value="${ticket.id}">
                                                            <input type="hidden" name="ticketName" value="${ticket.ticketName}">
                                                        </c:if> 
                                                        <div class="form-group">
                                                            <label for="ticketName">Ticket Type Name:</label>
                                                            <input type="text" class="form-control" placeholder="Enter Ticket Type Name" id="ticketName"
                                                                   value="${ticket.ticketName}" name="ticketName" <c:if test="${action == 'update_ticket'}">disabled</c:if>  />
                                                                   <p class="card-description" style="color: red;">
                                                                   <mvc:errors path="ticketName" />
                                                            </p>
                                                        </div>
                                                        <div class="form-group">
                                                            <label for="ticketTypeIdString">Ticket Type Price:</label>
                                                            <input type="text" class="form-control" id="ticketTypeIdString"
                                                                   value="<c:if test="${action == 'add_ticket'}"><fmt:formatNumber type="number" value="0" /></c:if><c:if test="${action == 'update_ticket'}"><fmt:formatNumber type="number" value="${ticket.ticketPrice}" /></c:if>"/>
                                                            <input type="hidden" class="form-control" id="ticketTypeId"
                                                                   value="<c:if test="${action == 'add_ticket'}">0</c:if><c:if test="${action == 'update_ticket'}">${ticket.ticketPrice}</c:if>" name="ticketPrice"/>
                                                                <p class="card-description" style="color: red;">
                                                                <mvc:errors path="ticketPrice" />
                                                            </p>
                                                            <script>
                                                                var numberString = document.getElementById("ticketTypeIdString");
                                                                var number = document.getElementById("ticketTypeId");
                                                                numberString.addEventListener('keyup', function (evt) {
                                                                    var n = parseFloat(this.value.replace(/\D/g, ''), 10);
                                                                    numberString.value = n.toLocaleString("en-AU");
                                                                    number.value = n;
                                                                }, false);

                                                            </script>
                                                        </div>
                                                        <c:if test="${messageTicket != null}">
                                                            <p style="color: red;">${messageTicket}</p>
                                                        </c:if>
                                                    </div>
                                                    <c:if test="${action == 'update_ticket'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveTicket'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_ticket'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveTicket'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/tickets" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
                                                </mvc:form>

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
    </body>

</html>