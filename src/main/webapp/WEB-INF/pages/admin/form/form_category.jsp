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
            <c:if test="${action == 'add_category'}">Add Movie Category</c:if>
            <c:if test="${action == 'update_category'}">Update Movie Category</c:if>
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
                    <div class="content-wrapper ">
                        <div class="row grid-margin ">
                            <div class="col-sm-12 ">
                                <div class="home-tab ">
                                    <div class="col grid-margin">
                                        <div class="card">
                                            <div class="card-body">
                                                <h4 class="card-title text-center"> 
                                                    <c:if test="${action == 'add_category'}">Add Movie Category</c:if>
                                                    <c:if test="${action == 'update_category'}">Update Movie Category</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveCategory" method="post"
                                                          modelAttribute="category">
                                                    <c:if test="${action == 'update_category'}">
                                                        <div class="form-group ">
                                                            <label>Movie Category ID: </label>
                                                            <input type="text" class="form-control" name="id" value="${category.id}" readonly>
                                                        </div>
                                                        
                                                    </c:if> 
                                                    <div class="form-group ">
                                                        <label>Movie Category Name: </label>
                                                        <input type="text" class="form-control" value="${category.categoryName}" placeholder="Input New Category Name" name="categoryName" />

                                                    </div>
                                                    <p class="card-description" style="color: red;">
                                                        <mvc:errors path="categoryName" />
                                                    </p>
                                                    <p class="card-description" style="color: red;">
                                                        <c:if test="${messageCategory != ''}">
                                                            ${messageCategory}
                                                        </c:if>
                                                    </p>
                                                    <c:if test="${action == 'update_category'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveCategory'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_category'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveCategory'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
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