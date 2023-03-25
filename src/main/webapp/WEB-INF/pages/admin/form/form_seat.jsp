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
            <c:if test="${action == 'add_seat'}">
                Add Seat Place
            </c:if>
            <c:if test="${action == 'update_seat'}">
                Update Seat Place
            </c:if>
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
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <div class="col-12 grid-margin stretch-card">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center"> 
                                                    <c:if test="${action == 'add_seat'}">Add Seat Place</c:if>
                                                    <c:if test="${action == 'update_seat'}">View Seat Place</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveSeat" method="post"
                                                          modelAttribute="seat">
                                                    <c:if test="${action == 'update_seat'}">
                                                        <input type="hidden" name="id" value="${seat.id}">
                                                    </c:if> 
                                                    <div class="form-group">
                                                        <label for="seatNumber">Seat Number: </label>
                                                        <input type="text"  class="form-control" id="seatNumber" placeholder="Enter Seat Number"
                                                               value="${seat.seatNumber}" name="seatNumber">
                                                        <p class="card-description" style="color: red;">
                                                            <mvc:errors path="seatNumber" />
                                                        </p>
                                                    </div>
                                                    <c:if test="${messageSeat != ''}">
                                                        <p class="card-description" style="color: red;">
                                                            ${messageSeat}
                                                        </p>
                                                    </c:if>
                                                    <c:if test="${action == 'update_seat'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveSeat'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_seat'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveSeat'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/seats" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
                                                </mvc:form>
                                                </form>
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