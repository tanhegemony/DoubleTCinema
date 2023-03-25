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
            <c:if test="${action == 'add_movie'}">Add Movie</c:if>
            <c:if test="${action == 'update_movie'}">Update Movie</c:if>
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
                                                    <c:if test="${action == 'add_movie'}">Add Movie</c:if>
                                                    <c:if test="${action == 'update_movie'}">Update Movie</c:if>
                                                    </h4>
                                                <mvc:form action="${pageContext.request.contextPath}/admin/resultSaveMovie" method="post"
                                                          modelAttribute="movie" enctype="multipart/form-data">
                                                    <c:if test="${action == 'update_movie'}">
                                                        <input type="hidden" name="id" value="${movie.id}">
                                                        <input type="hidden" name="imageMovie" value="${movie.imageMovie}">
                                                    </c:if> 
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label>Name By English: </label>
                                                                <input type="text" class="form-control" placeholder="Enter Movie Name By English" 
                                                                       <c:if test="${action == 'update_movie'}">
                                                                           readonly
                                                                       </c:if>
                                                                       value="${movie.nameByEnglish}" name="nameByEnglish" />
                                                                <p class="card-description" style="color: red;">
                                                                    <c:if test="${messageNameByEnglish != ''}">
                                                                        ${messageNameByEnglish}
                                                                    </c:if>
                                                                    <mvc:errors path="nameByEnglish" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label>Name By VietNam: </label>
                                                                <input type="text" class="form-control" placeholder="Enter Movie Name By Viet Nam" 
                                                                       <c:if test="${action == 'update_movie'}">
                                                                           readonly
                                                                       </c:if>
                                                                       value="${movie.nameByVietnam}" name="nameByVietnam" />
                                                                <p class="card-description" style="color: red;">
                                                                    <c:if test="${messageNameByVietnam != ''}">
                                                                        ${messageNameByVietnam}
                                                                    </c:if>
                                                                    <mvc:errors path="nameByVietnam" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label>Movie Duration: </label>
                                                                <input type="number" class="form-control" placeholder="Enter Movie Duration" 
                                                                       value="<c:if test="${movie.duration != null}">${movie.duration}</c:if><c:if test="${movie.duration == null}">0</c:if>" name="duration"/>
                                                                       <p class="card-description" style="color: red;">
                                                                       <c:if test="${messageDuration != ''}">
                                                                           ${messageDuration}
                                                                       </c:if>
                                                                       <mvc:errors path="duration" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label>Movie Premiere: </label>
                                                                <input type="date" class="form-control" pattern="yyyy-MM-dd" 
                                                                       placeholder="Enter Movie Premiere"
                                                                       value="<c:if test="${premiere == null}">${currentDate}</c:if><c:if test="${premiere != null}">${premiere}</c:if>" name="premiere" />
                                                                       <p class="card-description" style="color: red;">
                                                                       <mvc:errors path="premiere" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Movie Trailer: </label>
                                                                <input type="text" class="form-control" 
                                                                       placeholder="Enter Movie Trailer"
                                                                       value="${movie.trailer}" name="trailer"/>
                                                                <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="trailer" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6" style="margin-top: 2rem;">
                                                            <div class="form-group">
                                                                <label for="filmItem" style="margin-right: 2rem;">FilmItem: </label>
                                                                <c:forEach items="${filmItems}" var="filmItem">
                                                                    <div class="form-check-inline ">
                                                                        <label class="form-check-label ">
                                                                            <input type="radio" id="filmItem" class="form-check-input" 
                                                                                   value="${filmItem}" name="filmItem" <c:if test="${(action == 'add_movie' && filmItem == 'PHIM_DANG_CHIEU') || (movie.filmItem == filmItem)}">checked</c:if> >
                                                                            ${filmItem}
                                                                        </label>

                                                                    </div>
                                                                </c:forEach>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Nation: </label>
                                                                <input type="text" class="form-control" 
                                                                       placeholder="Enter Nation"
                                                                       value="${movie.nation}" name="nation"/>
                                                                <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="nation" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Director: </label>
                                                                <input type="text" class="form-control" 
                                                                       placeholder="Enter Movie Director"
                                                                       value="${movie.director}" name="director"/>
                                                                <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="director" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label>Producer: </label>
                                                                <input type="text" class="form-control" 
                                                                       placeholder="Enter Movie Producer"
                                                                       value="${movie.producer}" name="producer"/>
                                                                <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="producer" />
                                                                </p>
                                                            </div>
                                                        </div>
                                                        <div class="col-6">
                                                            <div class="form-group">
                                                                <label for="">Cast: </label>
                                                                <input type="text" class="form-control" 
                                                                       placeholder="Enter Movie Name By English"
                                                                       value="${movie.cast}" name="cast"/>
                                                                <p class="card-description" style="color: red;">
                                                                    <mvc:errors path="cast" />
                                                                </p>
                                                            </div>
                                                        </div>        
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-8">
                                                            <div class="form-group">
                                                                <label for="image">Movie Image: </label>
                                                                <input type="file" class="form-control-file" name="image" id="image" placeholder="">
                                                            </div>
                                                        </div> 
                                                        <div class="col-4 text-center">
                                                            <c:if test="${action == 'update_movie'}">
                                                                <div class="form-group"> 
                                                                    <label>Image: </label>
                                                                    <img class="imagefilm" style="width: 50%"
                                                                         src="${pageContext.request.contextPath}/resources/images/movies/<c:if test="${movie.filmItem == 'PHIM_DANG_CHIEU'}">coming</c:if><c:if test="${movie.filmItem == 'PHIM_SAP_CHIEU'}">coming soon</c:if>/${movie.imageMovie}"
                                                                             />
                                                                    </div>
                                                            </c:if>   
                                                        </div>
                                                    </div>   
                                                    <div class="form-group">
                                                        <label>Categories: </label> <br>
                                                        <c:forEach var="c" items="${categories}">
                                                            <div class="form-check" style="display: inline-block;">
                                                                <label class="form-check-label" style="margin-right: 1rem;">
                                                                    <input type="checkbox" class="form-check-input" name="movieCategs" value="${c.id}"
                                                                           <c:forEach var="mc" items="${movie.movieCategories}">
                                                                               <c:if test="${c.id == mc.category.id}">checked</c:if>
                                                                           </c:forEach>
                                                                           >
                                                                    ${c.categoryName}
                                                                </label>
                                                            </div>
                                                        </c:forEach>
                                                        <c:if test="${messageCategory != ''}">
                                                            <p class="card-description" style="color: red;">
                                                                ${messageCategory}
                                                            </p>
                                                        </c:if>
                                                    </div>
                                                    <div class="form-group">
                                                        <label for="exampleTextarea1">Description: </label>
                                                        <textarea class="form-control" id="exampleTextarea1" placeholder="Enter Movie Description" name="description" style="min-height: 10rem;" rows="30" value="${movie.description}">${movie.description}</textarea>
                                                        <p class="card-description" style="color: red;">
                                                            <mvc:errors path="description" />
                                                        </p>
                                                    </div>

                                                    <c:if test="${action == 'update_movie'}">
                                                        <button  type="submit" class="btn btn-warning"><i class="fas fa-highlighter"></i>Update</button>
                                                    </c:if>
                                                    <c:if test="${action == 'add_movie'}">
                                                        <button type="submit" class="btn btn-primary me-2" style="color: white;"><i class="fas fa-plus"></i> Add</button>
                                                    </c:if>
                                                    <a href="${pageContext.request.contextPath}/admin/movies" class="btn btn-danger" style="color: white;"><i class="far fa-window-close"></i> Cancel</a>

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