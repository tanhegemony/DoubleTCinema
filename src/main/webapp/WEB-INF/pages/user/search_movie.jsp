
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Search Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/search_movie.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/search_movie_responsive.css" />"/>


    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container content mt-3">
            <div class="row content1">
                <div class="col-4">
                    <p>Có <b style="color: red;"><c:if test="${movies.size() > 0}">${movies.size()}</c:if><c:if test="${movies.size() <= 0 || movies == null}">0</c:if></b> kết quả phù hợp với KeyWord: <b style="color: red;">${searchValue}</b></p>
                </div>
                <div class="col-4 displayBy">
                    <form action="search_movie" method="GET">
                        <div class="form-inline justify-content-end" >
                            <input type="hidden" name="searchValue" value="${searchValue}">
                            <input type="hidden" name="sortName" value="${sortName}">
                            <label for="displayName">Hiển thị: </label>
                            <select class="form-control ml-2" name="displayName" id="displayName" onchange="this.form.submit()">
                                <option value="" 
                                        <c:if test="${displayName == null}">selected</c:if>
                                            >Tất cả</option>
                                <c:forEach var="filmItem" items="${filmItems}">
                                    <c:if test="${filmItem == displayName}">
                                        <option value="${filmItem}" selected>${filmItem}</option>
                                    </c:if>
                                    <c:if test="${filmItem != displayName}">
                                        <option value="${filmItem}">${filmItem}</option>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </form>

                </div>
                <div class="col-4 sortBy">
                    <form action="search_movie" method="GET">
                        <input type="hidden" name="searchValue" value="${searchValue}">
                        <input type="hidden" name="displayName" value="${displayName}">
                        <div class="form-inline justify-content-end" >
                            <label for="sortName">Sắp xếp theo: </label>
                            <select class="form-control ml-2" name="sortName" id="sortName" onchange="this.form.submit()">
                                <option value="nameByEnglish"
                                        <c:if test="${sortName == 'nameByEnglish'}">selected</c:if>
                                            >Tên phim</option>
                                        <option value="premiere" <c:if test="${sortName == 'premiere'}">selected</c:if>
                                                >Ngày khởi chiếu</option>
                                        <option value="duration" <c:if test="${sortName == 'duration'}">selected</c:if>
                                                >Thời lượng chiếu</option>
                                </select>
                            </div>
                        </form>
                    </div>

                </div>
                <div class="row movies">
                <c:if test="${movies == null}">
                    <div class="col text-center mt-3 mb-3">
                        <p style="color: #31d7a9;font-size: 20px; font-weight: bolder;">${message}</p>
                    </div>
                </c:if>
                <c:if test="${movies != null}">
                    <c:forEach var="movie" items="${movies}">
                        <div class="col-4 mt-2">
                            <table class="table table-borderless" style="color: white;">
                                <tr>
                                    <td rowspan="4">
                                        <div class="imgContent">
                                            <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img   class="card-img-top"
                                                              src="${pageContext.request.contextPath}/resources/images/movies/<c:if test="${movie.filmItem == 'PHIM_DANG_CHIEU'}">coming</c:if><c:if test="${movie.filmItem == 'PHIM_SAP_CHIEU'}">coming soon</c:if>/${movie.imageMovie}" alt=""></a>

                                            </div>
                                        </td>
                                            <td><a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}" style="color: white;text-decoration: none;"><b class="name">${movie.nameByEnglish}</b></a></td>
                                </tr>
                                <tr>
                                    <td><i class="elementOther">${movie.nameByVietnam}</i></td>
                                </tr>
                                <tr>
                                    <td><i class="elementOther">Thời lượng: ${movie.duration} phút</i></td>
                                </tr>
                                <tr>
                                    <td><i class="elementOther">Ngày khởi chiếu: ${String.format("%1$Td-%1$Tm-%1$TY",movie.premiere)}</i></td>
                                </tr>
                            </table>
                        </div>
                    </c:forEach>
                </c:if>  


            </div>
            <div class="row viewMore">
                <div class="col">
                    <h5>Bạn có thể xem thêm phim được nhiều người xem tại rạp: </h5>
                </div>
            </div>
            <div class="row movies text-center mt-2">
                <c:forEach var="movie" items="${top4Coming}">
                    <div class="col-3">
                        <div class="imgContent">
                            <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img   class="card-img-top" src="${pageContext.request.contextPath}/resources/images/movies/coming/${movie.imageMovie}"
                                             alt=""></a>

                        </div>
                        <div class="card-body">
                            <a href="${pageContext.request.contextPath}/movieDetail/${movie.id}" >
                                <h5 title="${movie.nameByEnglish}" class="card-title">${movie.nameByEnglish}</h5>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>

        </div>
        <!-- footer -->
        <jsp:include page="../user/fragment/footer.jsp" />
        <!-- scroll -->
        <jsp:include page="../user/fragment/scroll.jsp" />
        <script src="<c:url value="/webjars/jquery/3.6.0/jquery.min.js"/>"></script>
        <!--jQuery first, then Popper.js, then Bootstrap JS--> 
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"
                integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous">
        </script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
                integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous">
        </script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
                integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous">
        </script>
    </body>
</html>
