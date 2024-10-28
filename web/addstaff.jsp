<%-- 
    Document   : addstaff
    Created on : Oct 26, 2024, 1:44:40 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
        <meta name="website" content="index.html" />
        <meta name="Version" content="v1.2.0" />
        <!-- favicon -->
        <link rel="shortcut icon" href="assets/images/favicon.ico.png">
        <!-- Bootstrap -->
        <link href="assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <!-- simplebar -->
        <link href="assets/css/simplebar.css" rel="stylesheet" type="text/css" />
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->
        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

    </head>
    <body>
        <!-- Loader -->
        <div id="preloader">
            <div id="status">
                <div class="spinner">
                    <div class="double-bounce1"></div>
                    <div class="double-bounce2"></div>
                </div>
            </div>
        </div>
        <!-- Loader -->

        <div class="page-wrapper doctris-theme toggled">
            <nav id="sidebar" class="sidebar-wrapper">
                <div class="sidebar-content" data-simplebar style="height: calc(100% - 60px);">
                    <div class="sidebar-brand">
                        <a href="home">
                            <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                        </a>
                    </div>

                    <ul class="sidebar-menu pt-3">
                        <li><a href="showProductManageView"><i class="uil uil-dashboard me-2 d-inline-block"></i>Dashboard</a></li>
                        <li><a href="home"><i class="uil uil-estate me-2 d-inline-block"></i>Homepage</a></li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-briefcase me-2 d-inline-block"></i>Staff</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="usermanagement?role=staff">All Staff</a></li>
                                        <c:if test="${sessionScope.User.getRoleId() == 1}">
                                        <li><a href="usermanagement?role=admin">Add Staff</a></li>
                                        </c:if>
                                </ul>
                            </div>
                        </li>

                        <li class="sidebar-dropdown">
                            <a href="javascript:void(0)"><i class="uil uil-users-alt me-2 d-inline-block"></i>Customer</a>
                            <div class="sidebar-submenu">
                                <ul>
                                    <li><a href="usermanagement?role=customer">All Customer</a></li>
                                </ul>
                            </div>
                        </li>
                    </ul>
                    <!-- sidebar-menu  -->
                </div>
            </nav>
            <!-- sidebar-wrapper  -->

            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <div class="top-header">
                    <div class="header-bar d-flex justify-content-between border-bottom">
                        <div class="d-flex align-items-center">
                            <a href="#" class="logo-icon">
                                <img src="assets/images/logo-icon.png" height="30" class="small" alt="">
                                <span class="big">
                                    <img src="assets/images/logo-dark.png" height="24" class="logo-light-mode" alt="">
                                </span>
                            </a>
                            <a id="close-sidebar" class="btn btn-icon btn-pills btn-soft-primary ms-2" href="#">
                                <i class="uil uil-bars"></i>
                            </a>
                            <!--<div class="search-bar p-0 d-none d-lg-block ms-2">
                                    <div id="search" class="menu-search mb-0">
                                        <form role="search" method="get" id="searchform" class="searchform">
                                            <div>
                                                <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Search Keywords...">
                                                <input type="submit" id="searchsubmit" value="Search">
                                            </div>
                                        </form>
                                    </div>
                                </div>-->
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Add New Staff</h5>
                        </div>

                        <div class="row">
                            <div class="col-lg-8 mt-4">
                                <div class="card border-0 p-4 rounded shadow">
                                    <div class="row align-items-center">
                                        <div class="col-lg-2 col-md-4">
                                            <img src="images/users/user.png" class="avatar avatar-md-md rounded-pill shadow mx-auto d-block" alt="">
                                        </div><!--end col-->
                                    </div><!--end row-->

                                    <form class="mt-4" action="usermanagement" method="post">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Full Name <span class="text-danger">*</span></label>
                                                    <input name="fullName" id="name" type="text" class="form-control" placeholder="Full Name" pattern="^[a-zA-Z\s]+$" title="Full name should only contain letters and spaces." required>
                                                </div>
                                            </div><!--end col-->

                                            <!--    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Username <span class="text-danger">*</span></label>
                                                            <input name="username" id="name2" type="text" class="form-control" placeholder="Username" required>
                                                        </div>
                                                    </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Email <span class="text-danger">*</span></label>
                                                    <input name="email" id="email" type="email" class="form-control" placeholder="Email" required>
                                                </div> 
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Phone Number <span class="text-danger">*</span></label>
                                                    <input name="phone" id="phone" type="text" class="form-control" placeholder="Phone Number" pattern="0[0-9]{9}" title="Phone number must start with 0 and be exactly 10 digits long" required>
                                                </div>                                                                               
                                            </div><!--end col-->

                                            <div class="col-md-6">
                                                <div class="mb-3">
                                                    <label class="form-label">Address <span class="text-danger">*</span></label>
                                                    <input name="address" id="address" type="text" class="form-control" placeholder="Address" required>
                                                </div>
                                            </div><!--end col-->

                                            <!--    <div class="col-md-6">
                                                        <div class="mb-3">
                                                            <label class="form-label">Password <span class="text-danger">*</span></label>
                                                            <input type="password" class="form-control" placeholder="Password" name="password" required>
                                                        </div>
                                                    </div><!--end col-->
                                        </div><!--end row-->

                                        <button type="submit" class="btn btn-primary">Add Staff</button>
                                        <c:if test="${requestScope.addError != null}">
                                            <div style="padding-top: 15px;">${addError}</div>
                                        </c:if>
                                    </form>
                                </div>
                            </div><!--end col-->

                            <div class="col-lg-4 mt-4">
                                <div class="card rounded border-0 shadow">
                                    <div class="p-4 border-bottom">
                                        <h5 class="mb-0">Staff List</h5>
                                    </div>

                                    <ul class="list-unstyled mb-0 p-4" data-simplebar style="height: 664px;">
                                        <c:forEach var="staff" items="${staffList}" varStatus="status">
                                            <li class="d-md-flex align-items-center text-center text-md-start <c:if test='${!status.first}'>mt-4</c:if>">
                                                <img src="${staff.image}" class="avatar avatar-medium rounded-md shadow" alt="Staff Image">

                                                <div class="ms-md-3 mt-4 mt-sm-0">
                                                    <a href="#" class="text-dark h6">${staff.fullName}</a>
                                                    <p>${staff.username}</p> <!-- Add other details as needed -->
                                                </div>
                                            </li>
                                        </c:forEach>

                                        <li class="mt-4">
                                            <a href="usermanagement" class="btn btn-primary">All Doctors</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div><!--end row-->
                    </div>
                </div><!--end container-->
            </main>
        </div>
        <!-- page-wrapper -->

        <!-- javascript -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Select2 -->
        <script src="assets/js/select2.min.js"></script>
        <script src="assets/js/select2.init.js"></script>
        <!-- Datepicker -->
        <script src="assets/js/flatpickr.min.js"></script>
        <script src="assets/js/flatpickr.init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>        
    </body>
</html>
