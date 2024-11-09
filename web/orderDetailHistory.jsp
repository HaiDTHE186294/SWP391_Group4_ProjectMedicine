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
                    <div class="layout-specing" style="margin-top: 30px">
                        <div class="d-md-flex justify-content-between">
                            <h5 class="mb-0">Order Detail</h5>
                        </div>

                        <div class="order-list mt-4">
                            <c:choose>
                                <c:when test="${not empty listdetail}">
                                    <div class="table-responsive">
                                        <table id="orderTable" class="table table-bordered table-hover table-striped">
                                            <thead class="thead-dark">
                                                <tr>
                                                    <th>Product ID</th>
                                                    <th>Product Name</th>
                                                    <th>Image</th>
                                                    <th>Quantity</th>
                                                    <th>Unit</th>
                                                    <th>Total Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="detail" items="${listdetail}">
                                                    <tr>
                                                        <td>${detail.product.productID}</td>
                                                        <td>${detail.product.productName}</td>
                                                        <td><img src="${detail.product.imagePath}" alt="${detail.product.productName}" style="width: 50px; height: auto;"></td>
                                                        <td>${detail.quantity}</td>
                                                        <td><c:choose>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U001'}">Viên</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U002'}">Chai</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U003'}">Lọ</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U004'}">Hộp</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U005'}">Gói</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U006'}">Ống</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U007'}">Tuýp</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U008'}">Bình</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U009'}">Thùng</c:when>
                                                                <c:when test="${detail.getUnitId().trim() eq 'U010'}">Vỉ</c:when>
                                                                <c:otherwise>${detail.getUnitId()}</c:otherwise>
                                                            </c:choose>
                                                        </td>
                                                        <td>${detail.quantity * detail.price}</td>
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

        <jsp:include page="footer.jsp" />

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
