<%-- 
    Document   : header
    Created on : Oct 6, 2024, 9:48:58 PM
    Author     : trant
--%>
<%@page import="model.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Doctris - Doctor Appointment Booking System</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="Premium Bootstrap 4 Landing Page Template" />
        <meta name="keywords" content="Appointment, Booking, System, Dashboard, Health" />
        <meta name="author" content="Shreethemes" />
        <meta name="email" content="support@shreethemes.in" />
        <meta name="website" content="https://shreethemes.in" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script type="text/javascript">
            var kommunicateSettings = {
                "appId": "19a459080780f8a3e18a542ff44c64e9f",
                "userId": "<%= session.getAttribute("userId") %>",
                "email": "<%= session.getAttribute("userEmail") %>",
                "userName": "<%= session.getAttribute("userName") %>"
            };

            (function (d, m) {
                var s = document.createElement("script");
                s.type = "text/javascript";
                s.async = true;
                s.src = "https://widget.kommunicate.io/v2/kommunicate.app";
                var h = document.getElementsByTagName("head")[0];
                h.appendChild(s);
                window.kommunicate = m;
                m._globals = kommunicateSettings;
            })(document, window.kommunicate || {});
        </script>

    </head>
    <body>
        <!-- Loader 
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <!-- Navbar STart -->
        <header id="topnav" class="defaultscroll sticky">
            <div class="container">
                <!-- Logo container-->
                <a class="logo" href="home">
                    <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                    <img src="assets/images/logo-light.png" height="24" class="logo-dark-mode" alt="">
                </a>                
                <!-- Logo End -->

                <!-- Start Mobile Toggle -->
                <div class="menu-extras">
                    <div class="menu-item">
                        <!-- Mobile menu toggle-->
                        <a class="navbar-toggle" id="isToggle" onclick="toggleMenu()">
                            <div class="lines">
                                <span></span>
                                <span></span>
                                <span></span>
                            </div>
                        </a>
                        <!-- End mobile menu toggle-->
                    </div>
                </div>
                <!-- End Mobile Toggle -->

                <!-- Start Dropdown -->
                <ul class="dropdowns list-inline mb-0">
                    <li class="list-inline-item mb-0">
                        <a href="cart" >
                            <div class="btn btn-icon btn-pills btn-primary"><i class="fa-solid fa-cart-shopping"></i></div>
                        </a>
                    </li>

                    <li class="list-inline-item mb-0 ms-1">
                        <a href="javascript:void(0)" class="btn btn-icon btn-pills btn-primary" data-bs-toggle="offcanvas" data-bs-target="#offcanvasTop" aria-controls="offcanvasTop">
                            <i class="uil uil-search"></i>
                        </a>
                    </li>

                    <c:if test="${not empty sessionScope.username}">
                        <li class="list-inline-item mb-0 ms-1">
                            <div class="dropdown dropdown-primary">
                                <button type="button" class="btn btn-pills btn-soft-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><img src="${User.image}" class="avatar avatar-ex-small rounded-circle" alt=""></button>
                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                    <a class="dropdown-item d-flex align-items-center text-dark" href="doctor-profile.html">
                                        <img src="${User.image}" class="avatar avatar-md-sm rounded-circle border shadow" alt="">
                                        <div class="flex-1 ms-2">
                                            <span class="d-block mb-1">${User.fullName}</span>
                                            <small class="text-muted">Orthopedic</small>
                                        </div>
                                    </a>
                                    <c:if test="${sessionScope.User.getRoleId() == 1 || sessionScope.User.roleId == 3}">
                                        <a class="dropdown-item text-dark" href="showProductManageView"><span class="mb-0 d-inline-block me-1"><i class="uil uil-dashboard align-middle h6"></i></span> Dashboard</a>
                                            </c:if>
                                    <a class="dropdown-item text-dark" href="changeProfile"><span class="mb-0 d-inline-block me-1"><i class="uil uil-setting align-middle h6"></i></span> Profile Settings</a>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="orderHistory"><span class="mb-0 d-inline-block me-1"><i class="uil uil-history align-middle h6"></i></span> Order History</a>
                                    <a class="dropdown-item text-dark" href="logout"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-out-alt align-middle h6"></i></span> Logout</a>
                                </div>
                            </div>
                        </li>
                    </c:if>

                    <c:if test="${empty sessionScope.username}">
                        <li class="list-inline-item mb-0 ms-1">
                            <div class="dropdown dropdown-primary">
                                <button type="button" class="btn btn-icon btn-pills btn-primary dropdown-toggle p-0" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="uil-user"></i></button>
                                <div class="dropdown-menu dd-menu dropdown-menu-end bg-white shadow border-0 mt-3 py-3" style="min-width: 200px;">
                                    <a class="dropdown-item text-dark" href="login"><span class="mb-0 d-inline-block me-1"><i class="uil uil-sign-in-alt align-middle h6"></i></span> Login</a>
                                    <div class="dropdown-divider border-top"></div>
                                    <a class="dropdown-item text-dark" href="register"><span class="mb-0 d-inline-block me-1"><i class="uil uil-user-plus align-middle h6"></i></span> Register</a>
                                </div>
                            </div>
                        </li>
                    </c:if>
                </ul>
                <!-- Start Dropdown -->

                <div id="navigation">
                    <!-- Navigation Menu-->   
                    <ul class="navigation-menu nav-left">
                        <li class="has-submenu parent-menu-item">
                            <a href="listproduct?categoryID=R1">Thực phẩm chức năng</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <c:forEach var="listCategoryR1" items="${sessionScope.listCategoryR1}">
                                    <li class="has-submenu">
                                        <a href="listproduct?categoryID=${listCategoryR1.categoryID}" class="sub-menu-item">${listCategoryR1.getCategoryName()}</a>

                                        <!-- Get subcategories for R1 -->
                                        <c:if test="${not empty sessionScope.subcategoriesMapR1[listCategoryR1.categoryID]}">
                                            <ul class="submenu">
                                                <c:forEach var="subcategory" items="${sessionScope.subcategoriesMapR1[listCategoryR1.categoryID]}">
                                                    <li><a href="listproduct?categoryID=${subcategory.categoryID}" class="sub-menu-item">${subcategory.categoryName}</a></li>
                                                    </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach>  
                            </ul>
                        </li>

                        <li class="has-submenu parent-parent-menu-item">
                            <a href="listproduct?categoryID=R2">Dược mỹ phẩm</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <c:forEach var="listCategoryR2" items="${sessionScope.listCategoryR2}">
                                    <li class="has-submenu">
                                        <a href="listproduct?categoryID=${listCategoryR2.categoryID}" class="sub-menu-item">${listCategoryR2.getCategoryName()}</a>

                                        <!-- Get subcategories for R2 -->
                                        <c:if test="${not empty sessionScope.subcategoriesMapR2[listCategoryR2.categoryID]}">
                                            <ul class="submenu">
                                                <c:forEach var="subcategory" items="${sessionScope.subcategoriesMapR2[listCategoryR2.categoryID]}">
                                                    <li><a href="listproduct?categoryID=${subcategory.categoryID}" class="sub-menu-item">${subcategory.categoryName}</a></li>
                                                    </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach> 
                            </ul>
                        </li>

                        <li class="has-submenu parent-menu-item">
                            <a href="listproduct?categoryID=R3">Chăm sóc cá nhân</a><span class="menu-arrow"></span>
                            <ul class="submenu">
                                <c:forEach var="listCategoryR3" items="${sessionScope.listCategoryR3}">
                                    <li class="has-submenu">
                                        <a href="listproduct?categoryID=${listCategoryR3.categoryID}" class="sub-menu-item">${listCategoryR3.getCategoryName()}</a>

                                        <!-- Get subcategories for R3 -->
                                        <c:if test="${not empty sessionScope.subcategoriesMapR3[listCategoryR3.categoryID]}">
                                            <ul class="submenu">
                                                <c:forEach var="subcategory" items="${sessionScope.subcategoriesMapR3[listCategoryR3.categoryID]}">
                                                    <li><a href="listproduct?categoryID=${subcategory.categoryID}" class="sub-menu-item">${subcategory.categoryName}</a></li>
                                                </c:forEach>
                                            </ul>
                                        </c:if>
                                    </li>
                                </c:forEach> 
                            </ul>
                        </li>

                        <li class="has-submenu parent-menu-item">
                            <a href="usermanagement">Bệnh</a>
                        </li>
                    </ul><!--end navigation menu-->
                </div><!--end navigation-->
            </div><!--end container-->
        </header><!--end header-->
        <!-- Navbar End -->

        <!-- javascript -->
        <script src="../assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="../assets/js/tiny-slider.js"></script>
        <script src="../assets/js/tiny-slider-init.js"></script>
        <!-- Icons -->
        <script src="../assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="../assets/js/app.js"></script>
    </body>
</html>