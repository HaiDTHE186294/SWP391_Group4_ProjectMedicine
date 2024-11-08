
<%-- 
    Document   : home
    Created on : Sep 18, 2024, 12:18:06 AM
    Author     : trant
--%>

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

    </head>
    <body>
        <jsp:include page="header.jsp" />
        <!-- Start Hero -->
        <section class="home-slider position-relative">
            <div id="carouselExampleInterval" class="carousel slide carousel-fade" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <div class="bg-half-170 d-table align-items-center w-100" style="background:url('assets/images/bg/pharm01.jpg') center center;">
                            <div class="bg-overlay bg-overlay-dark"></div>
                            <div class="container">
                                <div class="row mt-5">
                                    <div class="col-lg-12">
                                        <div class="heading-title">
                                            <h1 class="fw-bold mb-4">Doctors Prescribe <br> Medicine Products</h1>
                                            <p class="para-desc mb-0">Consult with a healthcare professional to ensure the right medication for your needs, whether for effective treatment, managing health conditions, or general advice on available products.</p>
                                        </div>
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div><!--end container-->
                        </div>
                    </div>

                    <div class="carousel-item">
                        <div class="bg-half-170 d-table align-items-center w-100" style="background:url('assets/images/bg/pharm02.jpg') center center;">
                            <div class="bg-overlay bg-overlay-dark"></div>
                            <div class="container">
                                <div class="row mt-5">
                                    <div class="col-lg-12">
                                        <div class="heading-title">
                                            <h1 class="fw-bold mb-4">Virus Protection <br> Get 15% Off on Select Health Products</h1>
                                            <p class="para-desc mb-0">Choose from a range of antiviral medications and immune-boosting supplements to help protect you and your family. Consult with a healthcare professional to find the right options for your needs.</p>
                                        </div>
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div><!--end container-->
                        </div>
                    </div>

                    <div class="carousel-item">
                        <div class="bg-half-170 d-table align-items-center w-100" style="background:url('assets/images/bg/pharm03.jpg') center center;">
                            <div class="bg-overlay bg-overlay-dark"></div>
                            <div class="container">
                                <div class="row mt-5">
                                    <div class="col-lg-12">
                                        <div class="heading-title">
                                            <h1 class="fw-bold mb-4">Cosmetics Body <br> Lotion</h1>
                                            <p class="para-desc mb-0">Discover our selection of nourishing body lotions designed to keep your skin soft, hydrated, and healthy. Choose from a range of formulas suited for all skin types to enhance your daily skincare routine.</p>
                                        </div>
                                    </div><!--end col-->
                                </div><!--end row-->
                            </div><!--end container--> 
                        </div>
                    </div>
                </div>
                <div class="carousel-indicators">
                    <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                    <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="1" aria-label="Slide 2"></button>
                    <button type="button" data-bs-target="#carouselExampleInterval" data-bs-slide-to="2" aria-label="Slide 3"></button>
                </div>
            </div>
        </section><!--end section-->
        <!-- End Hero -->

        <!-- Start -->
        <section class="section">
            <!-- Start Most Viewed Products -->
            <div class="container">
                <div class="row">
                    <div class="col-12">
                        <h5 class="mb-0">Best Selling Products</h5>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row">
                    <c:forEach var="product" items="${listTop8SoldProducts}">
                        <div class="col-lg-3 col-md-6 col-12 mt-4 pt-2">
                            <div class="card shop-list border-0">
                                <div class="shop-image position-relative overflow-hidden rounded shadow">
                                    <a href="prodetails?productid=${product.ProductID}"><img src="${product.imagePath}" class="img-fluid" alt="${product.productName}"></a>
                                    <ul class="list-unstyled shop-icons">
                                        <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                        <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                        <form action="cart" method="post">
                                            <input hidden="" name="action" value="addCart">
                                            <input hidden=""  title="text" name="productId" value="${product.ProductID}">
                                            <li class="mt-2"><button type="submit" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></button></li>
                                        </form>
                                    </ul>                                

                                </div>
                                <div class="card-body content pt-4 p-2">
                                   <a href="prodetails?productid=${product.ProductID}" class="text-dark product-name h6">${product.productName}</a>                                 
                                    <div class="d-flex justify-content-between mt-1">
                                        <h6 class="text-muted small font-italic mb-0 mt-1">${product.salePrice} / ${product.unitName} </h6> 
                                    </div>
                                </div>
                            </div>
                        </div><!--end col-->
                    </c:forEach>
                </div><!--end row-->
            </div><!--end container-->

            <div class="container mt-100 mt-60">
                <div class="row">
                    <div class="col-12">
                        <h5 class="mb-0">New Products</h5>
                    </div><!--end col-->
                </div><!--end row-->

                <div class="row">  
                    <c:forEach var="product" items="${latestProducts}">
                        <div class="col-lg-3 col-md-6 col-12 mt-4 pt-2">                         
                            <div class="card shop-list border-0">
                                <div class="shop-image position-relative overflow-hidden rounded shadow">
                                    <a href="prodetails?productid=${product.ProductID}"><img src="${product.ImagePath}" class="img-fluid" alt="${product.ProductName}"></a>
                                    <ul class="list-unstyled shop-icons">
                                        <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                        <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                        <form action="cart" method="post">
                                            <input hidden="" name="action" value="addCart">
                                            <input hidden=""  title="text" name="productId" value="${product.ProductID}">
                                            <li class="mt-2"><button type="submit" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></button></li>
                                        </form>
                                    </ul>                                 
                                </div>
                                <div class="card-body content pt-4 p-2">
                                    <a href="prodetails?productid=${product.ProductID}" class="text-dark product-name h6">${product.ProductName}</a>
                                    <div class="d-flex justify-content-between mt-1">
                                        <h6 class="text-muted small font-italic mb-0 mt-1">${product.SalePrice} / ${product.UnitName} </h6>
                                    </div>
                                </div>
                            </div>
                        </div><!--end col-->
                    </c:forEach>
                </div><!--end row-->
            </div><!--end container-->
        </section><!--end section-->

        <jsp:include page="footer.jsp" />

        <!-- javascript -->
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>
        <script src="assets/js/recent.js"></script>
    </body>
</html>
