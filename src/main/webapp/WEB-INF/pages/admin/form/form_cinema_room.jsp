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
            <c:if test="${action == 'add_cinema_room'}">Add Cinema Room</c:if>
            <c:if test="${action == 'update_cinema_room'}">Update Cinema Room</c:if>
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
                                                    <c:if test="${action == 'add_cinema_room'}">Add Cinema Room</c:if>
                                                    <c:if test="${action == 'update_cinema_room'}">Update Cinema Room</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveCinemaRoom" method="post"
                                                          modelAttribute="cinemaRoom">
                                                    <c:if test="${action == 'update_cinema_room'}">
                                                        <input type="hidden" name="cinema" value="${cinemaRoom.cinema.id}" />
                                                        <input type="hidden" name="cinemaRoomName" value="${cinemaRoom.cinemaRoomName}" />
                                                    </c:if>
                                                    <input type="hidden" name="action" value="${action}" />
                                                    <input type="hidden" name="cinemaRoomId" value="<c:if test="${action == 'add_cinema_room'}">0</c:if><c:if test="${action == 'update_cinema_room'}">${cinemaRoom.id}</c:if>">
                                                        <div class="form-group">
                                                            <label for="cinema">Cinema: </label>
                                                                <select class="form-control" name="cinema" id="cinema" style="color: black;" <c:if test="${action == 'update_cinema_room'}">disabled</c:if>>
                                                                <option value="">Select a cinema...</option>
                                                            <c:forEach var="c" items="${cinemas}">
                                                                <c:if test="${action == 'add_cinema_room'}">
                                                                    <c:if test="${cinema == c.id}">
                                                                        <option value="${c.id}" selected>${c.nameCinema}</option>
                                                                    </c:if>
                                                                    <c:if test="${cinema != c.id}">
                                                                        <option value="${c.id}">${c.nameCinema}</option>
                                                                    </c:if>
                                                                </c:if>
                                                                <c:if test="${action == 'update_cinema_room'}">
                                                                    <c:if test="${cinemaRoom.cinema.id == c.id}">
                                                                        <option value="${c.id}" selected>${c.nameCinema}</option>
                                                                    </c:if>
                                                                    <c:if test="${cinemaRoom.cinema.id != c.id}">
                                                                        <option value="${c.id}">${c.nameCinema}</option>
                                                                    </c:if>
                                                                </c:if>
                                                            </c:forEach>
                                                        </select>
                                                        <small class="form-text text-danger">
                                                            ${messageCinema}
                                                        </small>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Room Name: <span style="color: red;">* Correct format: RAP? - Ex: RAP5</span></label>
                                                        <input type="text" class="form-control" placeholder="Enter Cinema Room Name" 
                                                               value="<c:if test="${action == 'add_cinema_room'}">${cinemaRoomName}</c:if><c:if test="${action == 'update_cinema_room'}">${cinemaRoom.cinemaRoomName}</c:if>" name="cinemaRoomName" <c:if test="${action == 'update_cinema_room'}">readonly</c:if> />
                                                               <small class="form-text text-danger">
                                                               ${messageCinemaRoomName}
                                                        </small>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label>Rows In Room: </label>
                                                                <input type="number" placeholder="Enter Row Cinema Room" class="form-control" 
                                                                       value="<c:if test="${action == 'update_cinema_room'}">${cinemaRoom.rowCinemaRoom}</c:if><c:if test="${action == 'add_cinema_room'}">1</c:if>" name="rowCinemaRoom"/>
                                                                       <small class="form-text text-danger">
                                                                       ${messageRowCinemaRoom}
                                                                </small>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label>Columns In Room: </label>
                                                                <input type="number" placeholder="Enter Column Cinema Room" class="form-control" 
                                                                       value="<c:if test="${action == 'update_cinema_room'}">${cinemaRoom.columnCinemaRoom}</c:if><c:if test="${action == 'add_cinema_room'}">1</c:if>" name="columnCinemaRoom"/>
                                                                       <small class="form-text text-danger">
                                                                       ${messageColumnCinemaRoom}
                                                                </small>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <c:if test="${message != null}">
                                                        <p style="color: red;">${message}</p>
                                                    </c:if>
                                                    <c:if test="${action == 'update_cinema_room'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveCinemaRoom'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_cinema_room'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveCinemaRoom'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/cinemaRooms" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
                                                </mvc:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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