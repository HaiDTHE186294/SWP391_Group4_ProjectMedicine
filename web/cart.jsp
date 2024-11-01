<%-- 
    Document   : cart
    Created on : Oct 28, 2024, 1:04:21 PM
    Author     : trant
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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

        <jsp:include page="header.jsp" />
        <section class="section"  style="padding-top: 17px;">
            <div class="page-wrapper doctris-theme">
                <!-- Start Page Content -->
                <main class="page-content bg-light">

                    <div class="container-fluid">
                        <div class="layout-specing">
                            <div class="d-md-flex justify-content-between">
                                <h5 class="mb-0">Shop cart</h5>
                            </div>

                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="table-responsive bg-white shadow rounded">
                                        <table class="table table-center table-padding mb-0">
                                            <thead>
                                                <tr>
                                                    <th class="border-bottom p-3" style="min-width:20px "></th>
                                                    <th class="border-bottom p-3" style="min-width: 300px;">Sản phẩm</th>
                                                    <th class="border-bottom text-center p-3" style="min-width: 160px;">Giá thành</th>
                                                    <th class="border-bottom text-center p-3" style="min-width: 190px;">Số lượng</th>
                                                    <th class="border-bottom text-end p-3" style="min-width: 50px;">Đơn vị</th>
                                                </tr>
                                            </thead>

                                            <tbody>
                                                <tr>
                                                    <td class="h5 p-3 text-center"><a href="#" class="text-danger"><i class="uil uil-times"></i></a></td>
                                                    <td class="p-3">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/pharmacy/shop/ashwagandha.jpg" class="img-fluid avatar avatar-small rounded shadow" style="height:auto;" alt="">
                                                            <h6 class="mb-0 ms-3">Ashwagandha Churna</h6>
                                                        </div>
                                                    </td>
                                                    <td class="text-center p-3">$ 255.00</td>
                                                    <td class="text-center shop-list p-3">
                                                        <div class="qty-icons">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-icon btn-primary minus">-</button>
                                                            <input min="0" name="quantity" value="0" type="number" class="btn btn-icon btn-primary qty-btn quantity">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-icon btn-primary plus">+</button>
                                                        </div>
                                                    </td>
                                                    <td class="text-end font-weight-bold p-3">$510.00</td>
                                                </tr>

                                                <tr>
                                                    <td class="h5 p-3 text-center"><a href="#" class="text-danger"><i class="uil uil-times"></i></a></td>
                                                    <td class="p-3">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/pharmacy/shop/diabend.jpg" class="img-fluid avatar avatar-small rounded shadow" style="height:auto;" alt="">
                                                            <h6 class="mb-0 ms-3">Diabend</h6>
                                                        </div>
                                                    </td>
                                                    <td class="text-center p-3">$ 520.00</td>
                                                    <td class="text-center shop-list p-3">
                                                        <div class="qty-icons">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-icon btn-primary minus">-</button>
                                                            <input min="0" name="quantity" value="0" type="number" class="btn btn-icon btn-primary qty-btn quantity">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-icon btn-primary plus">+</button>
                                                        </div>
                                                    </td>
                                                    <td class="text-end font-weight-bold p-3">$520.00</td>
                                                </tr>

                                                <tr>
                                                    <td class="h5 p-3 text-center"><a href="#" class="text-danger"><i class="uil uil-times"></i></a></td>
                                                    <td class="p-3">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/pharmacy/shop/facewash.jpg" class="img-fluid avatar avatar-small rounded shadow" style="height:auto;" alt="">
                                                            <h6 class="mb-0 ms-3">Facewash</h6>
                                                        </div>
                                                    </td>
                                                    <td class="text-center p-3">$ 160.00</td>
                                                    <td class="text-center shop-list p-3">
                                                        <div class="qty-icons">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-icon btn-primary minus">-</button>
                                                            <input min="0" name="quantity" value="0" type="number" class="btn btn-icon btn-primary qty-btn quantity">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-icon btn-primary plus">+</button>
                                                        </div>
                                                    </td>
                                                    <td class="text-end font-weight-bold p-3">$640.00</td>
                                                </tr>

                                                <tr>
                                                    <td class="h5 p-3 text-center"><a href="#" class="text-danger"><i class="uil uil-times"></i></a></td>
                                                    <td class="p-3">
                                                        <div class="d-flex align-items-center">
                                                            <img src="assets/images/pharmacy/shop/handwash.jpg" class="img-fluid avatar avatar-small rounded shadow" style="height:auto;" alt="">
                                                            <h6 class="mb-0 ms-3">Dettol handwash</h6>
                                                        </div>
                                                    </td>
                                                    <td class="text-center p-3">$ 260.00</td>
                                                    <td class="text-center shop-list p-3">
                                                        <div class="qty-icons">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-icon btn-primary minus">-</button>
                                                            <input min="0" name="quantity" value="0" type="number" class="btn btn-icon btn-primary qty-btn quantity">
                                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-icon btn-primary plus">+</button>
                                                        </div>
                                                    </td>
                                                    <td class="text-end font-weight-bold p-3">$520.00</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->

                            <div class="row">
                                <div class="col-lg-8 col-md-6 mt-4 pt-2">
                                    <a href="home" class="btn btn-soft-primary ms-2">Update Cart</a>
                                </div>
                                <div class="col-lg-4 col-md-6 ms-auto mt-4 pt-2">
                                    <div class="table-responsive bg-white rounded shadow">
                                        <table class="table table-center table-padding mb-0">
                                            <tbody>
                                                <tr class="bg-light">
                                                    <td class="h6 p-3">Tổng tiền</td>
                                                    <td class="text-end font-weight-bold p-3">$ 2409</td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                    <div class="mt-4 pt-2 text-end">
                                        <a href="#" class="btn btn-primary">Proceed to checkout</a>
                                    </div>
                                </div><!--end col-->
                            </div><!--end row-->
                        </div>
                    </div><!--end container-->
                </main>
                <!--End page-content" -->
            </div>
            <!-- page-wrapper -->
        </section>

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
