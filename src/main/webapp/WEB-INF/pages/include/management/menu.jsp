<%-- 
    Document   : menu
    Created on : Jul 31, 2022, 5:11:20 PM
    Author     : henry
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <sec:authorize access="isAuthenticated()">
            <li class="nav-item <c:if test="${action == 'home_admin'}">active</c:if>" style="background: #fff;border-radius:0px 10px 10px 0px;">
                <a class="nav-link" href="<c:url value="/admin/home"/>">
                    <i class="mdi mdi-grid-large menu-icon"></i>
                    <span class="menu-title">Dashboard</span>
                </a>
            </li>
            <li class="nav-item nav-category"><h6><b style="font-size: 14px;">Manager Panel</b></h6></li>
            <div class="accordion" id="menu">
                <div class="card">
                    <button style="text-align: left; font-weight: bolder;font-size: 12px;border: 2px solid #317773;border-radius:0px 10px 0px 0px;" class="btn" type="button" data-toggle="collapse" data-target="#bookingManagement" aria-expanded="true" aria-controls="bookingManagement">
                        I. BOOKING MANAGEMENT
                    </button>
                    <div id="bookingManagement" class="collapse
                         <c:if test="${action == 'home_admin' || action == 'bookings' || action == 'search_bookings' || action == 'view_booking_detail' || action == 'view_invoice_of_booking'
                                       || action == 'invoices' || action == 'search_invoices' || action == 'view_booking_invoice' || action == 'buyFoods'
                                       || action == 'accounts' || action == 'search_accounts' || action == 'add_account' || action == 'update_account'
                                       || action == 'customers' || action == 'search_customers' || action == 'view_bookings_of_customer' || action == 'update_customer'
                                       || action == 'accounts_banking' || action == 'search_accounts_banking' || action == 'deposit' || action == 'inforVerify' || action == 'completeTransaction'
                                       || action == 'transactions_cinema' || action == 'search_transactions_cinema'
                               }">show</c:if>" data-parent="#menu" style="border-radius:0px 0px 10px 0px;border: 2px solid #317773;">
                         <sec:authorize access="hasAnyRole('ROLE_RECEPTIONIST,ROLE_MANAGER')">
                             <li class="nav-item <c:if test="${action == 'bookings' || action == 'search_bookings' ||
                                                               action == 'view_booking_detail' || action == 'view_invoice_of_booking'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/bookings"/>">
                                     <i class="menu-icon  mdi mdi-cart-plus"></i>
                                     <span class="menu-title">Bookings</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'invoices' || action == 'search_invoices' ||
                                                               action == 'view_booking_invoice' || action == 'buyFoods'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/invoices"/>">
                                     <i class="menu-icon  mdi mdi-credit-card"></i>
                                     <span class="menu-title">Invoices</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'transactions_cinema' || action == 'search_transactions_cinema'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/transactionsCinema"/>">
                                     <i class="fas fa-handshake" style="font-size: 20px;"></i>
                                     <span class="menu-title" style="transform: translateX(0.7rem);">Transactions Cinema</span>
                                 </a>
                             </li>
                         </sec:authorize>
                         <sec:authorize access="hasRole('ROLE_ADMIN')">
                             <li class="nav-item <c:if test="${action == 'accounts' || action == 'search_accounts' ||
                                                               action == 'add_account' || action == 'update_account'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/accounts"/>">
                                     <i class="menu-icon mdi mdi-account"></i>
                                     <span class="menu-title">Accounts</span>
                                 </a>
                             </li>
                         </sec:authorize>
                         <sec:authorize access="hasAnyRole('ROLE_RECEPTIONIST,ROLE_MANAGER')">
                             <li class="nav-item <c:if test="${action == 'customers' || action == 'search_customers' ||
                                                               action == 'view_bookings_of_customer' || action == 'update_customer'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/customers"/>">
                                     <i class="menu-icon mdi mdi-account-circle-outline"></i>
                                     <span class="menu-title">Customers</span>
                                 </a>
                             </li>
                         </sec:authorize>    

                         <sec:authorize access="hasRole('ROLE_MANAGER')">
                             <li class="nav-item <c:if test="${action == 'accounts_banking' || action == 'search_accounts_banking'
                                                               || action == 'deposit' || action == 'inforVerify' || action == 'completeTransaction'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/accountsBanking"/>">
                                     <i class="menu-icon  mdi mdi-bank"></i>
                                     <span class="menu-title">Customers Creadit Card</span>
                                 </a>
                             </li>
                         </sec:authorize>

                    </div>
                </div>
                <sec:authorize access="hasRole('ROLE_MANAGER')">
                    <div class="card">
                        <button style="text-align: left; font-weight: bolder;font-size: 12px;border: 2px solid #317773;border-radius:0px 10px 0px 0px;" class="btn" type="button" data-toggle="collapse" data-target="#cinemaManagement" aria-expanded="true" aria-controls="bookingManagement">
                            II. CINEMA MANAGEMENT
                        </button>
                        <div id="cinemaManagement" class="collapse
                             <c:if test="${action == 'cinema_movies' || action == 'search_cinema_movies' || action == 'add_cinema_movie' || action == 'update_cinema_movie'
                                           || action == 'movies' || action == 'search_movies' || action == 'add_movie' || action == 'update_movie'
                                           || action == 'categories' || action == 'search_categories' || action == 'add_category' || action == 'update_category'
                                           || action == 'foods' || action == 'search_foods' || action == 'add_food' || action == 'update_food'
                                           || action == 'promotions' || action == 'search_promotions' || action == 'add_promotion' || action == 'update_promotion' || action == 'view_bookings_of_promotion'
                                           || action == 'reviews' || action == 'search_reviews' || action == 'add_review' || action == 'update_review'
                                           || action == 'votes' || action == 'search_votes' || action == 'display_vote'
                                           || action == 'votes_review_movie' || action == 'search_votes_review_movie' || action == 'display_vote_review_movie'
                                   }">show</c:if>" data-parent="#menu" style="border-radius:0px 0px 10px 0px;border: 2px solid #317773;">

                                 <li class="nav-item <c:if test="${action == 'cinema_movies' || action == 'search_cinema_movies' ||
                                                               action == 'add_cinema_movie' || action == 'update_cinema_movie'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/cinemaMovies"/>">
                                     <i class="menu-icon  mdi mdi-panorama-horizontal"></i>
                                     <span class="menu-title">Cinema Movies</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'movies' || action == 'search_movies' ||
                                                               action == 'add_movie' || action == 'update_movie'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/movies"/>">
                                     <i class="mdi mdi-movie menu-icon"></i>
                                     <span class="menu-title">Movies</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'categories' || action == 'search_categories' ||
                                                               action == 'add_category' || action == 'update_category'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/categories"/>">
                                     <i class="menu-icon  mdi mdi-wrap"></i>
                                     <span class="menu-title">Movie Categories</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'foods' || action == 'search_foods' ||
                                                               action == 'add_food' || action == 'update_food'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/foods"/>">
                                     <i class="menu-icon mdi mdi-food"></i>
                                     <span class="menu-title">Foods</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'promotions' || action == 'search_promotions' ||
                                                               action == 'add_promotion' || action == 'update_promotion' || action == 'view_bookings_of_promotion'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/promotions"/>">
                                     <i class="menu-icon mdi mdi mdi-sale"></i>
                                     <span class="menu-title">Promotions</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'reviews' || action == 'search_reviews' ||
                                                               action == 'add_review' || action == 'update_review'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/reviews"/>">
                                     <i class="menu-icon  mdi mdi-thumbs-up-down"></i>
                                     <span class="menu-title">Reviews</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'votes' || action == 'search_votes' ||
                                                               action == 'display_vote'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/votes"/>">
                                     <i class="menu-icon mdi mdi-star-circle"></i>
                                     <span class="menu-title">Votes Movie</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'votes_review_movie' || action == 'search_votes_review_movie' ||
                                                               action == 'display_vote_review_movie'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/votesReviewMovie"/>">
                                     <i class="fas fa-search" style="font-size: 20px;"></i>
                                     <i class="menu-icon mdi mdi-star-circle"></i>
                                     <span class="menu-title">Votes Review Movie</span>
                                 </a>
                             </li>

                        </div>
                    </div>
                    <div class="card ">
                        <button style="font-weight: bolder;font-size: 12px;border: 2px solid #317773;border-radius:0px 10px 0px 0px;text-align: left;" class="btn" type="button" data-toggle="collapse" data-target="#settingUp" aria-expanded="true" aria-controls="settingUp">
                            III. SETTING UP
                        </button>
                        <div id="settingUp" class="collapse
                             <c:if test="${action == 'cinemas' || action == 'search_cinemas' || action == 'add_cinema' || action == 'update_cinema'
                                           || action == 'cinema_rooms' || action == 'search_cinema_rooms' || action == 'add_cinema_room' || action == 'update_cinema_room'
                                           || action == 'seats' || action == 'search_seats' || action == 'add_seat' || action == 'update_seat'
                                           || action == 'tickets' || action == 'search_tickets' || action == 'add_ticket' || action == 'update_ticket'
                                   }">show</c:if>" data-parent="#menu" style="border-radius:0px 0px 10px 0px;border: 2px solid #317773;">

                                 <li class="nav-item <c:if test="${action == 'cinemas' || action == 'search_cinemas' ||
                                                               action == 'add_cinema' || action == 'update_cinema'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/cinemas"/>">
                                     <i class="menu-icon  mdi mdi-filmstrip"></i>
                                     <span class="menu-title">Cinemas</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'cinema_rooms' || action == 'search_cinema_rooms' ||
                                                               action == 'add_cinema_room' || action == 'update_cinema_room'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/cinemaRooms"/>">
                                     <i class="menu-icon mdi mdi-ethernet"></i>
                                     <span class="menu-title">Cinema Rooms</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'seats' || action == 'search_seats' ||
                                                               action == 'add_seat' || action == 'update_seat'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/seats"/>">
                                     <i class="menu-icon  mdi mdi-seat-recline-normal"></i>
                                     <span class="menu-title">Seats Place</span>
                                 </a>
                             </li>
                             <li class="nav-item <c:if test="${action == 'tickets' || action == 'search_tickets' ||
                                                               action == 'add_ticket' || action == 'update_ticket'}">active</c:if>">
                                 <a class="nav-link" href="<c:url value="/admin/tickets"/>">
                                     <i class="menu-icon mdi mdi-ticket"></i>
                                     <span class="menu-title">Ticket Types</span>
                                 </a>
                             </li>
                        </div>
                    </div>
                </sec:authorize>
            </div>
        </sec:authorize>
    </ul>
</nav>
