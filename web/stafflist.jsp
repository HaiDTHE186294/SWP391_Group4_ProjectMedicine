<%-- 
    Document   : usermanagement
    Created on : Oct 25, 2024, 3:02:27 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="model.User" %>
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

        <script>
            function confirmDelete(userId) {
                if (confirm("Are you sure you want to delete this staff ?")) {
                    window.location.href = "delete?id=" + userId;
                }
            }
        </script>

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
                            <div class="search-bar p-0 d-none d-lg-block ms-2">
                                <div id="search" class="menu-search mb-0">
                                    <input type="text" class="form-control border rounded-pill" name="s" id="s" placeholder="Search Keywords...">
                                    <input type="submit" id="searchsubmit" value="Search" style="display: none;">
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="row">
                            <!-- Staff List with Title -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex justify-content-between">
                                    <h5 class="mb-0">Staff List</h5>
                                </div>
                                <div class="table-responsive shadow rounded mt-3">
                                    <table class="table table-center bg-white mb-0">
                                        <thead>
                                            <tr>      
                                                <th class="border-bottom p-3">Full name</th>
                                                <th class="border-bottom p-3">Username</th>
                                                <th class="border-bottom p-3">Avatar</th>
                                                <th class="border-bottom p-3">Email</th>
                                                <th class="border-bottom p-3">Address</th>
                                                <th class="border-bottom p-3">Phone number</th>
                                                    <c:if test="${sessionScope.User.getRoleId() == 1}">
                                                    <th class="border-bottom p-3">Action</th> 
                                                    </c:if>
                                            </tr>
                                        </thead>
                                        <tbody id="staffList">
                                            <c:forEach var="user" items="${userList}">
                                                <tr>
                                                    <td class="p-3">${user.fullName}</td>
                                                    <td class="p-3">${user.username}</td>
                                                    <td class="p-3"><img src="${user.image}" class="avatar avatar-md-sm rounded-circle shadow" alt=""></td>
                                                    <td class="p-3">${user.email}</td>
                                                    <td class="p-3">${user.address}</td>
                                                    <td class="p-3">${user.phone}</td>
                                                    <c:if test="${sessionScope.User.getRoleId() == 1}">
                                                        <td class="p-3">
                                                            <a href="javascript:void(0)" onclick="confirmDelete('${user.userId}')" class="btn btn-icon btn-pills btn-soft-danger"><i class="uil uil-trash"></i></a>
                                                        </td>
                                                    </c:if>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>

                        <div class="row text-center">
                            <!-- PAGINATION START -->
                            <div class="col-12 mt-4">
                                <div class="d-md-flex align-items-center text-center justify-content-between">
                                    <span class="text-muted me-3">Showing 10 each page</span>
                            <!--    <ul class="pagination justify-content-center mb-0 mt-3 mt-sm-0">
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Previous">Prev</a></li>
                                        <li class="page-item active"><a class="page-link" href="javascript:void(0)">1</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)">2</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)">3</a></li>
                                        <li class="page-item"><a class="page-link" href="javascript:void(0)" aria-label="Next">Next</a></li>
                                    </ul>-->
                                </div>
                            </div><!--end col-->
                            <!-- PAGINATION END -->
                        </div><!--end row-->
                    </div>
                </div><!--end container-->  
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

        <script>
                                                                document.getElementById('s').addEventListener('input', function () {
                                                                    // Get the trimmed search keyword
                                                                    const keyword = this.value.trim().toLowerCase();
                                                                    const rows = document.querySelectorAll('#staffList tr'); // Get all rows in the customer list

                                                                    rows.forEach(row => {
                                                                        const cells = row.getElementsByTagName('td');
                                                                        let found = false;

                                                                        // Loop through each cell in the row
                                                                        for (let cell of cells) {
                                                                            // Check if the cell's text includes the trimmed keyword
                                                                            if (cell.textContent.toLowerCase().includes(keyword)) {
                                                                                found = true;
                                                                                break;
                                                                            }
                                                                        }

                                                                        // Show or hide the row based on the search result
                                                                        row.style.display = found ? '' : 'none';
                                                                    });
                                                                });
        </script>
    </body>
</html>
