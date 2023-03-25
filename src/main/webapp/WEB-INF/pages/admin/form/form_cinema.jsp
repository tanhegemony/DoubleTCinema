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
            <c:if test="${action == 'add_cinema'}">Add Cinema</c:if>
            <c:if test="${action == 'update_cinema'}">Update Cinema</c:if>
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
                                                    <c:if test="${action == 'add_cinema'}">Add Cinema</c:if>
                                                    <c:if test="${action == 'update_cinema'}">Update Cinema</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveCinema" method="post"
                                                          modelAttribute="cinema">
                                                    <c:if test="${action == 'update_cinema'}">
                                                        <input type="hidden" name="id" value="${cinema.id}">
                                                    </c:if> 
                                                    <div class="form-group">
                                                        <label for="nameCinema">Cinema Name: </label>
                                                        <input type="text" class="form-control" name="nameCinema" id="nameCinema" 
                                                               placeholder="Input Cinema Name"
                                                               value="${cinema.nameCinema}"  <c:if test="${action == 'update_cinema'}">readonly</c:if> />
                                                        <p class="card-description" style="color: red;">
                                                            <c:if test="${messageCinemaName != ''}">
                                                                ${messageCinemaName}
                                                            </c:if>
                                                            <mvc:errors path="nameCinema" />
                                                        </p>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="cinemaAddress">Cinema Address: </label>
                                                        <input type="text" class="form-control"  name="cinemaAddress" id="cinemaAddress" 
                                                               placeholder="Input Cinema Address"
                                                               value="${cinema.cinemaAddress}" />
                                                        <p class="card-description" style="color: red;">
                                                            <mvc:errors path="cinemaAddress" />
                                                        </p>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="googleMap">Google Map: <span style="color: red;">* Correct Format: https://goo.gl/maps/? - Ex: https://goo.gl/maps/1234565AS</span></label>
                                                        <input type="text" class="form-control" name="googleMap" id="googleMap" 
                                                               placeholder="Input Website Address In Google Map"
                                                               value="${cinema.googleMap}"/>
                                                        <p class="card-description" style="color: red;">
                                                            <c:if test="${messageGoogleMap != ''}">
                                                                ${messageGoogleMap}
                                                            </c:if>
                                                            <mvc:errors path="googleMap" />
                                                        </p>
                                                    </div>
                                                    <c:if test="${action == 'update_cinema'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveCinema'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>
                                                    </c:if>
                                                    <c:if test="${action == 'add_cinema'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveCinema'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/cinemas" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
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