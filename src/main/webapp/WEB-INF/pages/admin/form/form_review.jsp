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
            <c:if test="${action == 'add_review'}">
                Add Review
            </c:if>
            <c:if test="${action == 'update_review'}">
                Update Review
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
                                                    <c:if test="${action == 'add_review'}">Add Review</c:if>
                                                    <c:if test="${action == 'update_review'}">Update Review</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveReview" method="post"
                                                          modelAttribute="review" enctype="multipart/form-data">
                                                    <c:if test="${action == 'update_review'}">
                                                        <input type="hidden" name="id" value="${review.id}">
                                                        <input type="hidden" name="nameReview" value="${review.nameReview}">
                                                    </c:if>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Review Movie: </label>
                                                                <select class="form-control" id="" name="movie.id" style="color: black;">
                                                                    <option value="">Select Review Movie...</option>
                                                                    <c:forEach var="m" items="${movies}"> 
                                                                        <c:if test="${review.movie.id == m.id}">
                                                                            <option value="${m.id}" selected>
                                                                                ${m.nameByEnglish}
                                                                            </option>
                                                                        </c:if>
                                                                        <c:if test="${review.movie.id != m.id}">
                                                                            <option value="${m.id}">
                                                                                ${m.nameByEnglish}
                                                                            </option>
                                                                        </c:if>
                                                                    </c:forEach>
                                                                </select>
                                                                <c:if test="${messageMovie != ''}">
                                                                    <p class="card-description" style="color: red;">
                                                                        ${messageMovie}
                                                                    </p>
                                                                </c:if>

                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Review Name: </label>
                                                                <input class="form-control" type="text" placeholder="Enter Review Name" name="nameReview" value="${review.nameReview}" <c:if test="${action == 'update_review'}">disabled</c:if>>
                                                                    <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="nameReview" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="images">Review Images: <strong style="color: red;">*Select 4 images</strong></label>
                                                                <input type="file" min="4" max="4" onchange="chooseFile(this)"  name="images" id="images" multiple>
                                                            </div>
                                                            <c:if test="${messageReviewImages != ''}">
                                                                <p class="card-description" style="color: red;">
                                                                    ${messageReviewImages}
                                                                </p>
                                                            </c:if>
                                                        </div>
                                                        <c:if test="${action == 'update_review'}">
                                                            <div class="col-12 col-lg-6 text-right mb-3">
                                                                <c:forEach var="rm" items="${imageNameReviewByMovieId}">
                                                                    <img id="image" class="mt-1"
                                                                     src="${pageContext.request.contextPath}/resources/images/review/idmovie${imageReviewByMovieId}/${rm.imageReview}"
                                                                     width="30%" alt="">
                                                                </c:forEach>
                                                                
                                                            </div>
                                                        </c:if>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="">Review Content: </label>
                                                        <textarea class="form-control" id="" placeholder="Enter Review Content" name="contentReview" style="min-height: 10rem;" rows="30">${review.contentReview}</textarea>
                                                        <p class="card-description" style="color: red;">
                                                            <mvc:errors path="contentReview" />
                                                        </p>
                                                    </div>
                                                    <c:if test="${action == 'update_review'}">
                                                        <button  onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveReview'" type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>           
                                                    </c:if>
                                                    <c:if test="${action == 'add_review'}">
                                                        <button onclick="location.href = '${pageContext.request.contextPath}/admin/resultSaveReview'" type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/reviews" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>
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