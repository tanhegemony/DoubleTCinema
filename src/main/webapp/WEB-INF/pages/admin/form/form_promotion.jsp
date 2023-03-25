<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <title>
            <c:if test="${action == 'add_promotion'}">Add Promotion</c:if>
            <c:if test="${action == 'update_promotion'}">Update Promotion</c:if>
            </title>
        <jsp:include page="../../include/management/css.jsp" />
    </head>

    <body>
        <div class="container-scroller">
            <!-- partial:partials/_navbar.html -->
            <!-- header -->
            <jsp:include page="../../include/management/header.jsp" />
            <div class="container-fluid page-body-wrapper">
                <jsp:include page="../../include/management/menu.jsp" />
                <div class="main-panel">
                    <div class="content-wrapper">
                        <div class="row grid-margin">
                            <div class="col-sm-12">
                                <div class="home-tab">
                                    <div class="col-12 grid-margin">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center"> 
                                                    <c:if test="${action == 'add_promotion'}">Add Promotion</c:if>
                                                    <c:if test="${action == 'update_promotion'}">Update Promotion</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSavePromotion" method="post"
                                                          modelAttribute="promotion" enctype="multipart/form-data">
                                                    <c:if test="${action == 'update_promotion'}">
                                                        <input type="hidden" name="id" value="${promotion.id}">
                                                        <input type="hidden" name="code" value="${promotion.code}">
                                                    </c:if>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="code">Promotion Code:</label>
                                                                <input type="text" class="form-control" placeholder="Enter Promotion Code" 
                                                                       <c:if test="${action == 'update_promotion'}">disabled</c:if>
                                                                       name="code" value="${promotion.code}" />
                                                                <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="code" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Promotion Value:</label>
                                                                <input type="text" class="form-control" id="promotionValueIdString"
                                                                       value="<c:if test="${promotion.valuePromotion <= 0}"><fmt:formatNumber type="number" value="5000" /></c:if><c:if test="${promotion.valuePromotion > 0}"><fmt:formatNumber type="number" value="${promotion.valuePromotion}" /></c:if>" />
                                                                <input type="hidden" name="valuePromotion" class="form-control" 
                                                                       id="promotionValueId"
                                                                       value="<c:if test="${promotion.valuePromotion <= 0}">5000</c:if><c:if test="${promotion.valuePromotion > 0}">${promotion.valuePromotion}</c:if>" />
                                                                    <p class="card-description" style="color: red;">
                                                                    <c:if test="${messagePromotionValue != ''}">
                                                                        ${messagePromotionValue}
                                                                    </c:if>
                                                                </p>
                                                            </div>
                                                            <script>
                                                                var numberString = document.getElementById("promotionValueIdString");
                                                                var number = document.getElementById("promotionValueId");
                                                                numberString.addEventListener('keyup', function (evt) {
                                                                    var n = parseFloat(this.value.replace(/\D/g, ''), 10);
                                                                    numberString.value = n.toLocaleString();
                                                                    number.value = n;
                                                                }, false);

                                                            </script>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Effective Date: </label>
                                                                    <input type="date" min="${minEffectiveDate}" name="effectiveDate"  class="form-control" placeholder="yyyy-MM-dd" 
                                                                       value="${effectiveDate}"/>
                                                                       <p class="card-description" style="color: red;">
                                                                       <mvc:errors path="effectiveDate" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Expiry Date: </label>
                                                                <input type="date" min="${minEffectiveDate}" name="expiryDate" class="form-control" placeholder="yyyy-MM-dd" 
                                                                       value="${expiryDate}"/>
                                                                <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="expiryDate" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <c:if test="${messagePromotion != ''}">
                                                        <p class="card-description" style="color: red">${messagePromotion}</p>
                                                    </c:if>
                                                    <c:if test="${action == 'update_promotion'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSavePromotion'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_promotion'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSavePromotion'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/promotions" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
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