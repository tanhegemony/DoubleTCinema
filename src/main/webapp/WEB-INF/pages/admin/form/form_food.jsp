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
            <c:if test="${action == 'add_food'}">Add Food</c:if>
            <c:if test="${action == 'update_food'}">Update Food</c:if>
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
                                                    <c:if test="${action == 'add_food'}">Add Food</c:if>
                                                    <c:if test="${action == 'update_food'}">Update Food</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveFood" method="post"
                                                          modelAttribute="food">
                                                    <c:if test="${action == 'update_food'}">
                                                        <input type="hidden" name="id" value="${food.id}">
                                                        <input type="hidden" name="nameFood" value="${food.nameFood}">
                                                    </c:if> 
                                                    <div class="form-group ">
                                                        <label >Food Name: </label>
                                                        <input type="text" class="form-control" placeholder="Enter Food Name" name="nameFood" value="${food.nameFood}" <c:if test="${action == 'update_food'}">disabled</c:if> />
                                                            <p class="card-description" style="color: red;">
                                                            <mvc:errors path="nameFood" />
                                                        </p>
                                                    </div>
                                                    <div class="form-group ">
                                                        <label for="priceFoodId">Price Food: </label>
                                                        <input type="text" class="form-control" 
                                                               placeholder="Enter Price Food"
                                                               id="priceFoodIdString" value="<fmt:formatNumber type="number" value="${food.priceFood}" />"  />
                                                        <input type="hidden" name="priceFood"  id="priceFoodId" class="form-control" value="${food.priceFood}"  />
                                                        <p class="card-description" style="color: red;">
                                                            <c:if test="${messagePriceFood != ''}">
                                                                ${messagePriceFood}
                                                            </c:if>
                                                        </p>
                                                    </div>
                                                    <script>
                                                        var numberString = document.getElementById("priceFoodIdString");
                                                        var number = document.getElementById("priceFoodId");
                                                        numberString.addEventListener('keyup', function (evt) {
                                                            var n = parseFloat(this.value.replace(/\D/g, ''), 10);
                                                            numberString.value = n.toLocaleString();
                                                            number.value = n;
                                                        }, false);

                                                    </script>
                                                    <p class="card-description" style="color: red;">
                                                        <c:if test="${messageFood != ''}">
                                                            ${messageFood}
                                                        </c:if>
                                                    </p>
                                                    <c:if test="${action == 'update_food'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveFood'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_food'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveFood'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/foods" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
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