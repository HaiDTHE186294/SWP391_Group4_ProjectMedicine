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
                            <h5 class="mb-0">Checkout</h5>
                        </div>

                        <form action="checkout" method="post">
                            <div class="row">
                                <div class="col-md-5 col-lg-4 order-last mt-4 pt-2 pt-sm-0">
                                    <div class="card rounded shadow p-4 border-0">
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <span class="h5 mb-0">Your cart</span>
                                            <span class="badge bg-primary rounded-pill">3</span>
                                        </div>
                                        <ul class="list-group mb-3 border">


                                            <table class="table">

                                                <c:forEach items="${listOrderDetail}" var="orderDetail">
                                                    <tr class="border-bottom">
                                                        <td class="p-3" style="width: 70%;">
                                                            <h6 class="my-0">${orderDetail.product.productName}</h6>
                                                            <small class="text-muted"></small>
                                                        </td>
                                                        <td>${orderDetail.quantity}</td>
                                                        <td>
                                                            <c:choose>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U001'}">Viên</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U002'}">Chai</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U003'}">Lọ</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U004'}">Hộp</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U005'}">Gói</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U006'}">Ống</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U007'}">Tuýp</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U008'}">Bình</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U009'}">Thùng</c:when>
                                                                <c:when test="${orderDetail.getUnitId().trim() eq 'U010'}">Vỉ</c:when>
                                                                <c:otherwise>${orderDetail.getUnitId()}</c:otherwise>
                                                            </c:choose>
                                                        </td>


                                                        <!--<td class="p-3 text-end" style="width: 30%;">
                                                            <span class="text-muted">${orderDetail.price} VND</span>
                                                        </td>end col-->
                                                        <td class="p-3 text-end">
                                                            <span class="text-muted">${orderDetail.quantity * orderDetail.price} VND</span>
                                                        </td>
                                                    </tr>

                                                </c:forEach>
                                            </table>

                                            <li class="d-flex justify-content-between p-3">
                                                <span>Total (VND)</span>
                                                <strong>${totalPricee} VND</strong>
                                                <input hidden="" value="${totalPricee}" name="totalPrice">
                                            </li>

                                        </ul>
                                        <input hidden="" name="orderId" value="${order.getOrderId()}">

                                        <div class="input-group">
                                            <button class="w-100 btn btn-primary" type="submit">Continue to checkout</button>
                                        </div>
                                    </div>
                                </div><!--end col-->

                                <div class="col-md-7 col-lg-8 mt-4">
                                    <div class="card rounded shadow p-4 border-0">
                                        <h5 class="mb-3">Billing address</h5>
                                        <div class="row g-3">
                                            <div class="col-sm-6">
                                                <label for="firstName" class="form-label">Full name</label>
                                                <input type="text" class="form-control" id="fullName" placeholder="Full Name" value="${userr.fullName}"
                                                       name="fullName"      required>
                                                <div class="invalid-feedback">
                                                    Valid first name is required.
                                                </div>
                                            </div>

                                            <div class="col-sm-6">
                                                <label for="lastName" class="form-label">Phone number</label>
                                                <input type="text" class="form-control" id="phone" placeholder="Phone Number" value="${userr.phone}"
                                                       name="phone"     required>
                                                <div class="invalid-feedback">
                                                    Valid last name is required.
                                                </div>
                                            </div>

                                            <div class="col-12">
                                                <label for="address" class="form-label">Address</label>
                                                <input type="text" class="form-control" id="address" placeholder="1234 Main St"
                                                       name="address"      required value="${userr.address}">
                                                <div class="invalid-feedback">
                                                    Please enter your shipping address.
                                                </div>
                                            </div>
                                        </div>


                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </form>

                    </div>
                </div><!--end container-->
            </main>
            <!--End page-content" -->
        </div>
        <!-- page-wrapper -->

        <jsp:include page="footer.jsp" />

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- simplebar -->
        <script src="assets/js/simplebar.min.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

    </body>
</html>
