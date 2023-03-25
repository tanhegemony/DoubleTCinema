
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="mvc" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Review Movie Detail Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.1/css/all.css" integrity="sha384-O8whS3fhG2OnA5Kas0Y9l3cfpmYjapjI0E4theH4iuMD+pLhbf6JI0jIMfYcK3yZ" crossorigin="anonymous">        
        <!-- Bootstrap CSS -->
        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon/favicon.png"/>" />
        <link href="<c:url value="/webjars/bootstrap/4.6.1/css/bootstrap.min.css"/>" rel="stylesheet" type="text/css"/>
        <script src="<c:url value="/webjars/bootstrap/4.6.1/js/bootstrap.min.js"/>"></script>
        <link rel="stylesheet" href="<c:url value="/resources/style/css/review_movie_detail.css" />"/>
        <link rel="stylesheet" href="<c:url value="/resources/style/responsive/review_movie_detail_responsive.css" />"/>


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
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/home"><i class="fas fa-home"></i> Trang chủ</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Review Phim</li>
                            <li class="breadcrumb-item active" aria-current="page">Chi tiết review phim -- ${review.nameReview}
                            </li>
                        </ol>
                    </nav>
                </div>
            </div>
            <div class="row bodyContent justify-content-center">
                <div class="col-4 imgPreview">
                    <img class="img-fluid" 
                         src="${pageContext.request.contextPath}/resources/images/review/idmovie${review.movie.id}/${review.reviewImages.get(0).imageReview}" alt="">
                </div>
                <div class="col-4 mt-5 infoPreview">
                    <h5>${review.nameReview}</h5>
                    <div class="row">
                        <div class="col rateMovie">
                            <c:forEach begin="1" end="${starVoteReview}" var="i">
                                <label>${i} star</label>
                            </c:forEach>
                            (<c:if test="${votesReview.size() == 0}">
                                Chưa có
                            </c:if>
                            <c:if test="${votesReview.size() != 0}">
                                ${votesReview.size()}
                            </c:if>đánh giá)
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-5 like">
                            <button onclick="location.href = '${pageContext.request.contextPath}/likeReviewMovie'" class="btn"
                                    <c:if test="${likeReviewMovie.id > 0}">
                                        title="Bạn đã like bài review này rồi"  disabled
                                    </c:if>
                                    ><i class="fas fa-thumbs-up"></i>${review.likeNumber}</button>
                        </div>
                        <div class="col-5 mt-2 view">
                            <p><i class="fas fa-eye"></i>${review.viewNumber}</p>
                        </div>
                    </div>
                </div>
                <div class="col-4 youVote1 mt-5">
                    <c:if test="${voteReview.id > 0}">
                        <div class="row youVote">
                            <div class="col">
                                <div class="existVote">
                                    <p style="color: #31d7a9">Bạn đã đánh giá vào ngày hôm nay!! Bạn vui lòng quay lại vào ngày mai!!</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${voteReview.id <= 0}">
                        <form action="${pageContext.request.contextPath}/addVoteReviewMovie" method="post">
                            <div class="row youVote">
                                <div class="col">
                                    <label><span style="color: red;">*</span> Đánh giá của bạn : </label>
                                    <div class="rate ">
                                        <input type="radio" id="star5" name="starNumber" value="5" checked />
                                        <label for="star5">5 stars</label>
                                        <input type="radio" id="star4" name="starNumber" value="4" />
                                        <label for="star4">4 stars</label>
                                        <input type="radio" id="star3" name="starNumber" value="3" />
                                        <label for="star3" >3 stars</label>
                                        <input type="radio" id="star2" name="starNumber" value="2" />
                                        <label for="star2">2 stars</label>
                                        <input type="radio" id="star1" name="starNumber" value="1" />
                                        <label for="star1">1 star</label>
                                    </div>
                                    <textarea name="comment" id="content" rows="4"></textarea>
                                    <button name="rateButton" class="btn">Đánh giá</button>
                                </div>
                            </div>
                        </form>
                    </c:if>

                </div>
            </div>
            <div class="row mt-3 justify-content-center">
                <div class="col-8 preview1">
                    <div class="row descriptionPreview">
                        <div class="col">
                            <p>${review.contentReview.substring(0,review.contentReview.length()/6)}</p>
                            <div class="row text-center">
                                <div class="col">
                                    <img class="img-fluid" width="70%"
                                         src="${pageContext.request.contextPath}/resources/images/review/idmovie${review.movie.id}/${review.reviewImages.get(1).imageReview}" alt="">
                                </div>
                            </div>
                            <p>${review.contentReview.substring(review.contentReview.length()/6,review.contentReview.length()/4)}</p>
                            <div class="row text-center">
                                <div class="col">
                                    <img class="img-fluid" width="70%"
                                         src="${pageContext.request.contextPath}/resources/images/review/idmovie${review.movie.id}/${review.reviewImages.get(2).imageReview}" alt="">
                                </div>
                            </div>
                            <p>${review.contentReview.substring(review.contentReview.length()/4,review.contentReview.length()/2)}</p>
                            <div class="row text-center">
                                <div class="col">
                                    <img class="img-fluid" width="70%"
                                         src="${pageContext.request.contextPath}/resources/images/review/idmovie${review.movie.id}/${review.reviewImages.get(3).imageReview}" alt="">
                                </div>
                            </div>
                            <p>${review.contentReview.substring(review.contentReview.length()/2)}</p>

                        </div>
                    </div>
                    <div class="row reviewOther">
                        <div class="col">
                            <h5><span style="color: red;">*</span> Các review phim liên quan:</h5>
                            <c:forEach var="reviewOther" items="${reviewsOther}">
                                <p><a href="${pageContext.request.contextPath}/reviewMovieDetail/${reviewOther.id}"><i class="fas fa-angle-double-right"></i> [Preview] ${reviewOther.nameReview}</a></p>
                            </c:forEach>
                        </div>
                    </div>
                    <div class="row imgReviewOther">
                        <c:forEach var="reviewOther" items="${reviewsOther}">
                            <div class="col-6 mb-3">
                                <a title="${reviewOther.nameReview}" href="${pageContext.request.contextPath}/reviewMovieDetail/${reviewOther.id}"><img class="img-fluid"
                                                                                                                                                        src="${pageContext.request.contextPath}/resources/images/review/idmovie${reviewOther.movie.id}/${reviewOther.reviewImages.get(0).imageReview}" alt=""></a>
                            </div>
                        </c:forEach>
                    </div>
                </div>
                <div class="col-4 preview2">
                    <c:if test="${voteReview.id > 0}">
                        <div class="row vote1 youVote">
                            <div class="col">
                                <div class="existVote">
                                    <p style="color: #31d7a9">Bạn đã đánh giá vào ngày hôm nay!! Bạn vui lòng quay lại vào ngày mai!!</p>
                                </div>
                            </div>
                        </div>
                    </c:if>
                    <c:if test="${voteReview.id <= 0}">
                        <form action="${pageContext.request.contextPath}/addVoteReviewMovie" class="vote1" method="post">
                            <div class="row youVote">
                                <div class="col">
                                    <label><span style="color: red;">*</span> Đánh giá của bạn : </label>
                                    <div class="rate ">
                                        <input type="radio" id="star5" name="starNumber" value="5" checked />
                                        <label for="star5">5 stars</label>
                                        <input type="radio" id="star4" name="starNumber" value="4" />
                                        <label for="star4">4 stars</label>
                                        <input type="radio" id="star3" name="starNumber" value="3" />
                                        <label for="star3" >3 stars</label>
                                        <input type="radio" id="star2" name="starNumber" value="2" />
                                        <label for="star2">2 stars</label>
                                        <input type="radio" id="star1" name="starNumber" value="1" />
                                        <label for="star1">1 star</label>
                                    </div>
                                    <textarea name="comment" id="comment" rows="4"></textarea>
                                    <button name="rateButton" class="btn">Đánh giá</button>
                                </div>
                            </div>
                        </form>
                    </c:if>
                    <div class="row voteList">
                        <div class="col">
                            <c:forEach var="vote" items="${votesReview}">
                                <c:if test="${vote.display == true}">
                                    <table class="table table-responsive table-borderless">
                                        <tr>
                                            <td class="account" >
                                                <img src="${pageContext.request.contextPath}/resources/images/user/<c:if test="${vote.account.imageAccount == null}">no_image_user.png</c:if><c:if test="${vote.account.imageAccount != null}">${vote.account.imageAccount}</c:if>"
                                                     class="img-fluid" alt="...">
                                                     <b>${vote.account.customer.customerName}</b>
                                            </td>
                                            <td class="upTime">
                                                <i>${vote.voteDate}</i>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div class="rateMovie">
                                                    <c:forEach begin="1" end="${vote.starNumber}" var="i">
                                                        <label>${i} star</label>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="contentDescription" colspan="2">
                                                <p>${vote.comment}</p>
                                            </td>
                                        </tr>
                                    </table>
                                </c:if>
                            </c:forEach>
                        </div>
                    </div>
                    <h3 class="title-comm">
                        <span class="title-holder">Phim đang chiếu</span>
                    </h3>
                    <div class="row mt-2 movies text-center">
                        <c:forEach var="movie" items="${moviesComing}">
                            <div class="col-6 mb-3">
                                <div class="imgContent">
                                    <a title="${movie.nameByEnglish}" href="${pageContext.request.contextPath}/movieDetail/${movie.id}">
                                        <img class="img-fluid" src="${pageContext.request.contextPath}/resources/images/movies/coming/${movie.imageMovie}" alt="">
                                    </a>
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
