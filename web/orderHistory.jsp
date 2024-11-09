<%-- 
    Document   : checkout
    Created on : Oct 28, 2024, 2:12:21 PM
    Author     : trant
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>
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
        <jsp:include page="header.jsp" />

        <div class="page-wrapper doctris-theme">
            <!-- Start Page Content -->
            <main class="page-content bg-light">
                <div class="container-fluid">
                    <div class="layout-specing">
                        <div class="d-md-flex justify-content-between">
                            <h4 class="mb-0">Order History</h4>
                        </div>

                        <!-- Bắt đầu phần hiển thị danh sách đơn hàng -->
                        <div class="order-list mt-4">
                            <c:choose>
                                <c:when test="${not empty orders}">
                                    <div class="table-responsive">
                                        <table id="orderTable" class="table table-bordered table-hover table-striped">
                                            <thead class="thead-dark">
                                                <tr>
                                            <!--    <th scope="col">Order ID</th>-->
                                                    <th scope="col">Order Date</th>
                                                    <th scope="col">Status</th>
                                                    <th scope="col">Order Total</th>
                                                    <th scope="col">Phone Number</th>
                                                    <th scope="col">Address</th>
                                            <!--    <th scope="col">View</th>-->
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="order" items="${orders}">
                                                    <tr>
                                                <%--    <th scope="row">${order.orderId}</th>--%>
                                                        <td>${order.orderDate}</td>
                                                        <td>${order.status}</td>
                                                        <td>${order.orderTotal}</td>
                                                        <td>${order.phone_number_order}</td>
                                                        <td>${order.address}</td>
                                                <%--        <td>
                                                            <a href="orderHistory?id=${order.orderId}" class="btn btn-primary">View</a>
                                                        </td>--%>

                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning" role="alert">
                                        Không có đơn hàng nào để hiển thị.
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Kết thúc phần hiển thị danh sách đơn hàng -->

                    </div>
                </div><!--end container-->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->
        <script>
            $(document).ready(function () {
                $('#orderTable').DataTable({
                    "paging": true,
                    "searching": true,
                    "info": true,
                    "lengthChange": true,
                    "pageLength": 10 // Số dòng hiển thị mỗi trang
                });
            });
        </script>

       
        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
        <!-- jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- DataTables CSS -->
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.5/css/jquery.dataTables.min.css">
        <!-- DataTables JS -->
        <script type="text/javascript" src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    </body>
</html>
