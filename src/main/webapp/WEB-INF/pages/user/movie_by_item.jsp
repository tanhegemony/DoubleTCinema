
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Movie By Item Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/movie_by_item.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/movie_by_item_responsive.css" />"/>


    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container content mt-3">
            <div class="row movieByItem  mt-2">
                <div class="col">
                    <ul class="nav nav-tabs justify-content-center" id="myTab" role="tablist" aria-orientation="vertical">
                        <c:forEach var="filmItem" items="${filmItems}">
                            <li class="nav-item" role="presentation">
                                <form action="movie_by_item" method="GET">
                                    <input type="hidden" name="contentNavMovieItem" value="${filmItem}">
                                    <button class="nav-link <c:if test="${contentNavMovieItem == filmItem}">active</c:if>" 
                                            id="${filmItem}-tab" 
                                            onclick="location.href = '${pageContext.request.contextPath}/movie_by_item#${filmItem}'"
                                            role="tab" aria-controls="${filmItem}"
                                            aria-selected="true"><c:if test="${filmItem == 'PHIM_DANG_CHIEU'}">Phim đang chiếu</c:if><c:if test="${filmItem == 'PHIM_SAP_CHIEU'}">Phim sắp chiếu</c:if> </button>
                                    </form>
                                </li>
                        </c:forEach>
                    </ul>
                    <div class="tab-content" id="myTabContent">
                        <c:forEach var="filmItem" items="${filmItems}">
                            <div class="tab-pane fade <c:if test="${contentNavMovieItem == filmItem}">show active</c:if>" id="${filmItem}" role="tabpanel"
                                 aria-labelledby="${filmItem}-tab">
                                <div class="row mt-2 breadcrumbContent">
                                    <div class="col">
                                        <nav aria-label="breadcrumb">
                                            <ol class="breadcrumb">
                                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i> Trang
                                                        chủ</a></li>
                                                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/movie_by_item"><i class="fas fa-film"></i> Phim</a>
                                                </li>
                                                <li class="breadcrumb-item active" aria-current="page"><c:if test="${filmItem == 'PHIM_DANG_CHIEU'}">Phim đang chiếu</c:if>
                                                    <c:if test="${filmItem == 'PHIM_SAP_CHIEU'}">Phim sắp chiếu</c:if></li>
                                                </ol>
                                            </nav>
                                        </div>
                                    </div>
                                    <div class="row contentBody">
                                        <div class="col-3 filter">
                                            <h5>Bộ lọc: <a href="${pageContext.request.contextPath}/movie_by_item<c:if test="${contentNavMovieItem != null}">?contentNavMovieItem=${contentNavMovieItem}</c:if>" style="font-size: 12px;color: #31d7a9;float: right;margin-top: 0.5rem;">Xoá tất cả</a></h5>
                                            <div class="row mt-3 mb-3">
                                                <div class="col mt-2 mb-2">
                                                    <h6><c:if test="${filterCategory != null}">Thể loại: <span style="color: red;">${filterCategory}</span></c:if></h6>
                                                <h6><c:if test="${filterNation != null}">Quốc gia: <span style="color: red;">${filterNation}</span></c:if></h6>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col">
                                                    <p class="text-left mt-2">Thể loại phim</p>
                                                    <hr style="background-color: white;">
                                                    <form action="movie_by_item" method="GET">
                                                        <input type="hidden" name="contentNavMovieItem" value="${filmItem}">
                                                    <input type="hidden" name="sortName" value="${sortName}">
                                                    <c:if test="${filterNation != null}">
                                                        <input type="hidden" name="filterNation" value="${filterNation}">
                                                    </c:if>
                                                    <c:forEach var="category" items="${categories}">
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterCategory" name="filterCategory" onchange="this.form.submit()"
                                                                   value="${category.categoryName}" <c:if test="${filterCategory == category.categoryName}">checked</c:if>>
                                                            <label class="form-check-label" for="filterCategory">${category.categoryName}</label>
                                                        </div>
                                                    </c:forEach>
                                                </form>


                                            </div>
                                        </div>
                                        <div class="row mt-2">
                                            <div class="col">
                                                <p class="text-left mt-2">Quốc gia</p>
                                                <hr style="background-color: white;">
                                                <form action="movie_by_item" method="GET">
                                                    <input type="hidden" name="contentNavMovieItem" value="${filmItem}">
                                                    <input type="hidden" name="sortName" value="${sortName}">
                                                    <c:if test="${filterCategory != null}">
                                                        <input type="hidden" name="filterCategory" value="${filterCategory}">
                                                    </c:if>
                                                    <div class="form-check">
                                                        <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                               value="Việt Nam" <c:if test="${filterNation == 'Việt Nam'}">checked</c:if>>
                                                               <label class="form-check-label" for="filterNation">Việt Nam</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                                   value="Mỹ" <c:if test="${filterNation == 'Mỹ'}">checked</c:if>>
                                                            <label class="form-check-label" for="filterNation">Mỹ</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                                   value="Anh" <c:if test="${filterNation == 'Anh'}">checked</c:if>>
                                                            <label class="form-check-label" for="filterNation">Anh</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                                   value="Trung Quốc" <c:if test="${filterNation == 'Trung Quốc'}">checked</c:if>>
                                                            <label class="form-check-label" for="filterNation">Trung Quốc</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                                   value="Nhật Bản" <c:if test="${filterNation == 'Nhật Bản'}">checked</c:if>>
                                                            <label class="form-check-label" for="filterNation">Nhật Bản</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                                   value="Hàn Quốc" <c:if test="${filterNation == 'Hàn Quốc'}">checked</c:if>>
                                                            <label class="form-check-label" for="filterNation">Hàn Quốc</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                                   value="Ấn Độ" <c:if test="${filterNation == 'Ấn Độ'}">checked</c:if>>
                                                            <label class="form-check-label" for="filterNation">Ấn Độ</label>
                                                        </div>
                                                        <div class="form-check">
                                                            <input type="radio" class="form-check-input" id="filterNation" name="filterNation" onchange="this.form.submit()"
                                                                   value="Thái Lan" <c:if test="${filterNation == 'Thái Lan'}">checked</c:if>>
                                                            <label class="form-check-label" for="filterNation">Thái Lan</label>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-9 sortAndView">
                                            <div class="row ml-2 mr-2 sort">
                                                <div class="col">
                                                    <div class="row">
                                                        <div class="col-6 nameBoss mt-3">
                                                            <p style="color: white;">Tấn Hegemony - Tự Chicken</p>
                                                        </div>
                                                        <div class="col-6 sortBy">
                                                            <form action="movie_by_item" method="GET">
                                                                <input type="hidden" name="contentNavMovieItem" value="${contentNavMovieItem}">
                                                            <c:if test="${filterCategory != null}">
                                                                <input type="hidden" name="filterCategory" value="${filterCategory}">
                                                            </c:if>
                                                            <c:if test="${filterNation != null}">
                                                                <input type="hidden" name="filterNation" value="${filterNation}">
                                                            </c:if>
                                                            <div class="form-inline mt-2 mb-2 justify-content-end"  >
                                                                <label for="sortName" >Sắp xếp theo: </label>
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
                                                </div>
                                            </div>
                                            <div class="row movies mt-3 text-center">
                                            <c:if test="${movies == null || movies.size() <= 0}">
                                                <div class="col text-center mt-3 mb-3">
                                                    <p style="color: #31d7a9;font-size: 20px; font-weight: bolder;">${message} 
                                                        <c:if test="${filterCategory != null || filterNation != null}">
                                                            + <span style="color: red;font-style: italic; "><c:if test="${filterCategory != null}">${filterCategory}</c:if> <c:if test="${filterNation != null}">+ ${filterNation}</c:if></span>
                                                        </c:if>
                                                    </p>
                                                </div>
                                            </c:if>
                                            <c:if test="${movies != null}">
                                                <c:forEach var="movie" items="${movies}">
                                                    <div class="col-4 mt-2">
                                                        <div class="imgContent">
                                                            <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img class="card-img-top"
                                                                                                                                                                     src="${pageContext.request.contextPath}/resources/images/movies/<c:if test="${movie.filmItem == 'PHIM_DANG_CHIEU' || contentNavMovieItem == ''}">coming</c:if><c:if test="${movie.filmItem == 'PHIM_SAP_CHIEU'}">coming soon</c:if>/${movie.imageMovie}"
                                                                                                                                                                         alt=""></a>

                                                            </div>
                                                            <div class="card-body" style="color: white;">
                                                                    <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}" style="color: white;"><h5 class="card-title">${movie.nameByEnglish}</h5></a>
                                                            <p class="card-text">${movie.nameByVietnam}</p>
                                                            <p>Thời lượng: ${movie.duration} phút</p>
                                                            <p>Ngày khởi chiếu: ${String.format("%1$Td-%1$Tm-%1$TY", movie.premiere)}</p>
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>

                            </div>
                        </c:forEach>
                    </div>
                </div>
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
