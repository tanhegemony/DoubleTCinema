
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Movie Detail Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/movie_detail.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/movie_detail_responsive.css" />"/>


    </head>
    <body>
        <!-- header -->
        <jsp:include page="../user/fragment/header.jsp" />
        <!-- menu -->
        <jsp:include page="../user/fragment/menu.jsp" />
        <!-- body -->
        <div class="container content mt-3">
            <div class="row breadcrumbContent">
                <div class="col">
                    <nav aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}"><i class="fas fa-home"></i> Trang chủ</a></li>
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/movie_by_item"><i class="fas fa-film"></i> Phim</a></li>
                            <li class="breadcrumb-item">
                                <a href="${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=<c:if test="${movie.filmItem == 'PHIM_DANG_CHIEU'}">PHIM_DANG_CHIEU</c:if><c:if test="${movie.filmItem == 'PHIM_SAP_CHIEU'}">PHIM_SAP_CHIEU</c:if>">
                                    <c:if test="${movie.filmItem == 'PHIM_DANG_CHIEU'}">Phim đang chiếu</c:if>
                                    <c:if test="${movie.filmItem == 'PHIM_SAP_CHIEU'}">Phim sắp chiếu</c:if>
                                    </a>
                                </li>
                                <li class="breadcrumb-item active" aria-current="page">Chi tiết phim -- ${movie.nameByEnglish}
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row headerContent text-center">
                <div class="col">
                    <h4>Thông tin chi tiết Phim</h4>
                    <hr style="border: 1px solid #032055;width: 20%;">
                </div>
            </div>
            <div class="row bodyContent">
                <div class="col-3">
                    <img class="img-fluid" width="100%" height="100%"
                         src="${pageContext.request.contextPath}/resources/images/movies/<c:if test="${movie.filmItem == 'PHIM_DANG_CHIEU'}">coming</c:if><c:if test="${movie.filmItem == 'PHIM_SAP_CHIEU'}">coming soon</c:if>/${movie.imageMovie}" alt="">
                    </div>
                    <div class="col-5" style="color: white;">
                        <div class="row">
                            <div class="col">
                                <div class="row">
                                    <div class="col-6 nameMovie">
                                            <h5>${movie.nameByEnglish}
                                    </h5>
                                </div>
                                <div class="col-6 rateMovie">
                                    <c:if test="${starVote == 0}">
                                        No Star
                                        (0 đánh giá)
                                    </c:if>
                                    <c:if test="${starVote > 0}">
                                        <c:forEach begin="1" end="${starVote}" var="star">
                                            <label>${star} star</label>
                                        </c:forEach>
                                        (${votes.size()} đánh giá)
                                    </c:if>

                                </div>
                            </div>
                            <div class="row">
                                <div class="col-6 nameMovie">
                                    <h6>${movie.nameByVietnam}</h6>
                                </div>
                                <div class="col-6 viewNumber">
                                    <p><i class="fas fa-eye"></i> <span>${movie.viewedNumber}</span></p>
                                </div>
                            </div>
                            <b>Thời gian:</b> ${movie.duration} <br>
                            <b>Thể loại:</b> 
                            <c:forTokens var="category" items="${categories}" delims="[]">
                                ${category}
                            </c:forTokens>
                            <br>
                            <b>Đạo diễn:</b> ${movie.director} <br>
                            <b>Quốc gia:</b> ${movie.nation} <br>
                            <b>Diễn viên:</b> ${movie.cast}... <br>
                            <b>Nhà sản xuất:</b> ${movie.producer} <br>
                            <b>Ngày khởi chiếu:</b> ${movie.premiere}
                        </div>
                    </div>
                </div>
                <div class="col-4">
                    <iframe width="100%" height="250" src="${movie.trailer}"
                            title="YouTube video player" frameborder="0"
                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
                            allowfullscreen></iframe>
                </div>

            </div>
            <div class="row mt-5 desAndrate" >
                <div class="col-7">
                    <div class="row descriptionMovie">
                        <div class="col">
                            <h6>Mô tả: </h6>
                            <p>${movie.description}</p>
                        </div>
                    </div>
                    <div class="row voteMovie" >
                        <div class="col">
                            <h6>Đánh giá: </h6>
                            <div class="row" >
                                <div class="col">
                                    <c:if test="${votes == null}">
                                        <i style="color: #d80027;">CHƯA CÓ ĐÁNH GIÁ NÀO!</i>
                                    </c:if>
                                    <c:if test="${votes != null}">
                                        <c:forEach var="vote" items="${votes}">
                                            <c:if test="${vote.display == true}">
                                                <table class="table table-responsive table-borderless">
                                                    <tr>
                                                        <td class="account" style="width: 30%;">
                                                            <img src="${pageContext.request.contextPath}/resources/images/user/<c:if test="${vote.account.imageAccount == null}">no_image_user.png</c:if><c:if test="${vote.account.imageAccount != null}">${vote.account.imageAccount}</c:if>"
                                                                 class="img-fluid" style="width: 2rem;height: 2rem;border-radius: 100%;" alt="...">
                                                                 <b style="color: white;">${vote.account.customer.customerName}</b>
                                                        </td>
                                                        <td>
                                                            <div class="rateMovie">
                                                                <c:forEach begin="1" end="${vote.starNumber}" var="i">
                                                                    <label>${i} star</label>
                                                                </c:forEach>
                                                            </div>
                                                        </td>
                                                        <td class="upTime text-right" >
                                                            <i style="color: white;"><i class="fas fa-history"></i> ${String.format("%1$Td-%1$Tm-%1$TY %1$TH:%1$TS", vote.voteDate)}</i>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="contentDescription" colspan="3">
                                                            <p style="color: white;"><c:out value="${vote.comment}" /></p>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </c:if>
                                        </c:forEach>
                                    </c:if>

                                </div>
                            </div>
                            <c:if test="${existVote == false}">
                                <mvc:form action="${pageContext.request.contextPath}/addVoteMovie"
                                          modelAttribute="voteMovie" method="POST" >
                                    <div class="row youVote">
                                        <div class="col">
                                            <label style="color: white;"><span style="color: red;">*</span> Đánh giá của bạn : </label>
                                            <div class="rate youRate">
                                                <input type="radio" id="star5" name="starNumber" value="5" checked/>
                                                <label for="star5">5 stars</label>
                                                <input type="radio" id="star4" name="starNumber" value="4"/>
                                                <label for="star4">4 stars</label>
                                                <input type="radio" id="star3" name="starNumber" value="3"/>
                                                <label for="star3" >3 stars</label>
                                                <input type="radio" id="star2" name="starNumber" value="2"/>
                                                <label for="star2">2 stars</label>
                                                <input type="radio" id="star1" name="starNumber" value="1" />
                                                <label for="star1">1 star</label>
                                            </div>
                                            <div class="form-group">
                                                <textarea name="comment" placeholder="Bạn muốn nói gì về movie này không ???" id="comment" style="width: 100%;" rows="4" required></textarea>
                                            </div>
                                            <button type="submit"  class="btn">Đăng bài</button>
                                        </div>
                                    </div>
                                </mvc:form>
                            </c:if>
                            <c:if test="${existVote == true}">
                                <div class="row youVote">
                                    <div class="col">
                                        <div class="existVote">
                                            <p style="color: #31d7a9">Bạn đã đánh giá vào ngày hôm nay!! Bạn vui lòng quay lại vào ngày mai!!</p>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
                <div class="col-5 calendar">
                    <h6>Lịch chiếu: </h6>
                    <mvc:form action="${pageContext.request.contextPath}/saveCinemaMovieInSession" method="POST">
                        <div class="row">
                            <div class="col-6">
                                <div class="form-group">
                                    <input type="date" name="showDate" onchange="this.form.submit()" class="form-control showDate" min="${startDate}" 
                                           max="${endDate}" 
                                           <c:if test="${sessionScope.showDate != null}">value="${sessionScope.showDate}"</c:if>  
                                           <c:if test="${sessionScope.showDate == null}">value="${startDate}"</c:if>>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="form-group">
                                        <select class="form-control" onchange="this.form.submit()" name="cinemaId">
                                            <option value="0">Tất cả</option>
                                        <c:forEach var="cinema" items="${cinemas}">
                                            <c:if test="${sessionScope.cinemaId == cinema.id}">
                                                <option value="${cinema.id}" selected>${cinema.nameCinema}</option>
                                            </c:if>
                                            <c:if test="${sessionScope.cinemaId != cinema.id}">

                                                <option value="${cinema.id}">${cinema.nameCinema}</option>
                                            </c:if>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>
                        </div>

                    </mvc:form>
                    <c:if test="${cinemaMoviesDisplay.size() <= 0}">
                        <div class="row mt-3 mb-3">
                            <div class="col">
                                <b style="color: white;">${message} <span style="color: red"><c:if test="${sessionScope.showDate == null}">${startDate}</c:if> ${sessionScope.showDate}</span></b>
                                </div>
                            </div>

                    </c:if>
                    <c:if test="${cinemaMoviesDisplay.size() > 0}">
                        <c:forEach var="cmd" items="${cinemaMoviesDisplay}">
                            <div class="row mt-3 mb-3">
                                <div class="col">
                                    <div id='nz-div'>
                                        <h3 class="tde">
                                            <span class="null">${cmd.cinema.nameCinema}</span>
                                        </h3>
                                    </div>
                                    <b style="color: white;">Suất chiếu: </b>
                                    <c:forEach var="showTime" items="${cmd.showTime}">
                                        <button style="border-radius: 5px 0px 0px 5px;" class="mb-2 mt-2 btn">${showTime.showTime}</button>
                                        <button style="border-radius: 0px 5px 5px 0px;transform: translateX(-0.5rem)" onclick="location.href = '${pageContext.request.contextPath}/booking?movieId=${cmd.movie.id}&cinemaId=${cmd.cinema.id}&showDate=${showTime.showDate}&showTime=${showTime.showTime}'" class="mb-2 mt-2 btn btn-danger">Mua vé</button>
                                    </c:forEach>


                                </div>
                            </div>
                        </c:forEach>
                    </c:if>

                </div>
            </div>
            <div class="row movieRelated mt-4">
                <div class="col">
                    <h5 style="text-decoration: underline;">Phim đang chiếu: </h5>
                </div>
            </div>
            <div class="row mt-2 movies text-center">
                <c:forEach var="movie" items="${top6Coming}">
                    <div class="col-2">
                        <div class="imgContent">
                            <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}"><img class="card-img-top" src="${pageContext.request.contextPath}/resources/images/movies/coming/${movie.imageMovie}"
                                                                                                                                     alt=""></a>

                        </div>
                        <div class="card-body">
                            <a href="${pageContext.request.contextPath}/movieDetail/${movie.id}">
                                <h5 title="${movie.nameByEnglish}" class="card-title">${movie.nameByEnglish.substring(0,11)}...</h5>
                            </a>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <div class="row mt-2 viewAll text-center">
                <div class="col">
                    <button onclick="location.href = '${pageContext.request.contextPath}/movie_by_item?contentNavMovieItem=PHIM_DANG_CHIEU'" class="btn">Xem tất cả....</button>
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
