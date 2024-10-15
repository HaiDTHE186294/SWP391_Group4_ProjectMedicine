<%-- 
    Document   : listbook
    Created on : Oct 15, 2024, 12:35:09 PM
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
        <link href="assets/css/listproduct.css" rel="stylesheet" type="text/css" />

    </head>
    <body>
        <jsp:include page="header.jsp" />

        <div class="container-product">
            <div class="row">
                <!-- Bộ lọc nâng cao -->
                <div class="col-lg-3 col-md-4">
                    <form action="listproduct" method="post" class="filter-form" id="filterForm">
                        <!-- Đối tượng sử dụng -->
                        <h5>Bộ lọc nâng cao</h5>
                        <h6>Đối tượng sử dụng</h6>
                        <div>
                            <c:forEach var="audience" items="${sessionScope.audienceList}">
                                <input type="checkbox" name="targetAudience" value="${audience}" > ${audience}<br>
                            </c:forEach>
                        </div>

                        <!-- Giá bán -->
                        <h6>Giá bán</h6>
                        <div>
                            <input type="radio" name="salePrice" value="duoi100" > Dưới 100.000đ<br>
                            <input type="radio" name="salePrice" value="100-300" > 100.000đ - 300.000đ<br>
                            <input type="radio" name="salePrice" value="300-500" > 300.000đ - 500.000đ<br>
                            <input type="radio" name="salePrice" value="tren500" > Trên 500.000đ<br>
                        </div>

                        <!-- Nước sản xuất -->
                        <h6>Nước sản xuất</h6>
                        <div>
                            <select name="countryOfManufacture">
                                <c:forEach var="country" items="${countryList}">
                                    <option value="${country}">${country}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </form>
                </div>

                <!-- Danh sách sản phẩm -->               
                <div class="col-lg-9 col-md-8">
                    <div class="row">
                        <c:forEach var="product" items="${sessionScope.productList}">
                            <div class="col-lg-3 col-md-6 col-12 mt-4 pt-2">
                                <div class="card shop-list border-0">
                                    <div class="shop-image position-relative overflow-hidden rounded shadow">
                                        <a href="product-detail.jsp?productId=${product.ProductID}"><img src="${product.imagePath}" class="img-fluid" alt="${product.productName}"></a>
                                        <ul class="list-unstyled shop-icons">
                                            <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                            <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                            <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                        </ul>                                

                                        <div class="qty-icons">
                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                            <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                            <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                        </div>
                                    </div>
                                    <div class="card-body content pt-4 p-2">
                                        <a href="pharmacy-product-detail.html" class="text-dark product-name h6">${product.productName}</a>
                                        <div class="d-flex justify-content-between mt-1">
                                            <h6 class="text-muted small font-italic mb-0 mt-1">${product.salePrice}đ / ${product.unitName} </h6>
                                        </div>
                                    </div>
                                </div>
                            </div><!--end col-->
                        </c:forEach>
                    </div><!--end row-->
                    
                    <div class="row">
                        <c:choose>
                            <c:when test="${not empty filteredProductList}">
                                <c:forEach var="product" items="${filteredProductList}">
                                    <div class="col-lg-3 col-md-6 col-12 mt-4 pt-2">
                                        <div class="card shop-list border-0">
                                            <div class="shop-image position-relative overflow-hidden rounded shadow">
                                                <a href="product-detail.jsp?productId=${product.ProductID}"><img src="${product.ImagePath}" class="img-fluid" alt="${product.ProductName}"></a>
                                                <ul class="list-unstyled shop-icons">
                                                    <li><a href="#" class="btn btn-icon btn-pills btn-soft-danger"><i data-feather="heart" class="icons"></i></a></li>
                                                    <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-primary"><i data-feather="eye" class="icons"></i></a></li>
                                                    <li class="mt-2"><a href="#" class="btn btn-icon btn-pills btn-soft-warning"><i data-feather="shopping-cart" class="icons"></i></a></li>
                                                </ul>
                                                <div class="qty-icons">
                                                    <button onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-pills btn-icon btn-primary minus">-</button>
                                                    <input min="0" name="quantity" value="0" type="number" class="btn btn-pills btn-icon btn-primary qty-btn quantity">
                                                    <button onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-pills btn-icon btn-primary plus">+</button>
                                                </div>
                                            </div>
                                            <div class="card-body content pt-4 p-2">
                                                <a href="product-detail.jsp?productId=${product.ProductID}" class="text-dark product-name h6">${product.ProductName}</a>
                                                <div class="d-flex justify-content-between mt-1">
                                                    <h6 class="text-muted small font-italic mb-0 mt-1">${product.SalePrice}đ / ${product.UnitName}</h6>
                                                </div>
                                            </div>
                                        </div>
                                    </div><!--end col-->
                                </c:forEach>
                            </c:when>
                        </c:choose>
                    </div><!--end row-->
                </div>
            </div>
        </div>

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

        <script>
                                                        // Gửi form khi có bất kỳ thay đổi nào trong form
                                                        document.querySelectorAll('#filterForm input, #filterForm select').forEach(function (input) {
                                                            input.addEventListener('change', function () {
                                                                document.getElementById('filterForm').submit();
                                                            });
                                                        });
        </script>
    </body>
</html>
