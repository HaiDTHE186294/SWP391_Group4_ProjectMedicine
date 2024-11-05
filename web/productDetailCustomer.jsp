
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
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
        <!-- SLIDER -->
        <link rel="stylesheet" href="assets/css/tiny-slider.css"/>
        <link rel="stylesheet" href="assets/css/slick.css"/> 
        <link rel="stylesheet" href="assets/css/slick-theme.css"/>
        <!-- Icons -->
        <link href="assets/css/materialdesignicons.min.css" rel="stylesheet" type="text/css" />
        <link href="assets/css/remixicon.css" rel="stylesheet" type="text/css" />
        <link href="https://unicons.iconscout.com/release/v3.0.6/css/line.css"  rel="stylesheet">
        <!-- Css -->

        <link href="assets/css/style.min.css" rel="stylesheet" type="text/css" id="theme-opt" />

        <style>
            /* General Styling */
            body {
                font-family: Arial, sans-serif;
                background-color: #f7f7f7;
            }

            .container2 {
                display: flex;
                gap: 20px;
                max-width: 1200px;
                margin: auto;
                padding: 20px;
            }

            .sidebar, .content {
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            /* Sidebar Styling */
            .sidebar {
                width: 25%;
                position: sticky;
                top: 100px;
                padding: 20px;
            }
            .sidebar ul {
                list-style: none;
                padding-left: 0;
            }
            .sidebar a {
                display: block;
                color: #0d6efd;
                font-size: 16px;
                transition: color 0.3s;
                text-decoration: none;
                padding: 12px 15px;
            }
            .sidebar a:hover {
                color: #0056b3;
                text-decoration: underline;
            }

            /* Content Section Styling */
            .content {
                width: 70%;
                padding: 20px;
            }
            .content h2 {
                font-size: 22px;
                margin-top: 40px;
                color: #333;
                border-bottom: 2px solid #ddd;
                padding-bottom: 8px;
            }
            .content p, .content li {
                font-size: 16px;
                color: #555;
                line-height: 1.6;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp" />

        <section class="section">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-10 col-md-12">
                        <div class="card border-0 shadow-lg rounded-lg overflow-hidden">
                            <div class="row g-0 align-items-center">
                                <div class="col-md-5">
                                    <div class="slider slider-for position-relative p-3">
                                        <img src="${productId.imagePath}" alt="${productId.productName}" class="img-fluid rounded">
                                    </div>
                                </div>
                                <div class="col-md-7">
                                    <form action="" class="card-body">
                                        <input type="hidden" name="productId" value="${productId.productID}"/>
                                        <h4 class="card-title text-primary fw-bold">${productId.productName}</h4>

                                        <p><strong>Giá Sản Phẩm</strong> <span id="priceDisplay">--</span></p>

                                        <p class="text-muted mb-2"><strong>Thương hiệu:</strong> ${productId.brand}</p>
                                        <p class="text-muted mb-2"><strong>Nhà sản xuất:</strong> ${productId.manufacturer}</p>
                                        <p class="text-muted mb-2"><strong>Đối tượng mục tiêu:</strong> ${productId.targetAudience}</p>
                                        <p class="text-muted mb-2"><strong>Mô tả ngắn gọn:</strong><p class="mb-4">${productId.shortDescription}</p>
                                        <p class="text-muted mb-3"><strong>Số đăng ký:</strong> ${productId.registrationNumber}</p>

                                        <c:choose>
                                            <c:when test="${productId.status == 1}">
                                                <div class="d-flex shop-list align-items-center">
                                                    <h6 class="mb-0">Unit:</h6>
                                                    <div class="qty-icons ms-3">
                                                        <input type="hidden" id="selectedUnit" name="selectedUnit" value=""/>
                                                        <c:if test="${not empty ownUnit}">
                                                            <c:forEach var="unit" items="${ownUnit}">
                                                                <button type="button" 
                                                                        class="btn btn-soft-primary ms-2 unit-button" 
                                                                        data-price="${unitPrices[unit.unitID]}" 
                                                                        value="${unit.unitID}" 
                                                                        onclick="selectUnit(this)">
                                                                    ${unit.unitName}
                                                                </button>
                                                            </c:forEach>
                                                        </c:if>
                                                    </div>
                                                </div>
                                                <div class="d-flex shop-list align-items-center mt-2">
                                                    <h6 class="mb-0">Quantity:</h6>
                                                    <div class="qty-icons ms-3">
                                                        <button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()" class="btn btn-icon btn-primary minus">-</button>
                                                        <input min="0" name="quantity" value="0" type="number" class="btn btn-icon btn-primary qty-btn quantity">
                                                        <button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()" class="btn btn-icon btn-primary plus">+</button>
                                                    </div>
                                                </div>

                                                <div class="mt-4 pt-2">
                                                    <button type="submit" class="btn btn-primary" name="action" value="single">Shop Now</button>
                                                    <a href="#" class="btn btn-soft-primary ms-2">Add to Cart</a>
                                                </div>
                                            </c:when>
                                            <c:when test="${productId.status == 2}">
                                                <div class="mt-4 pt-2">
                                                    <span class="text-danger fw-bold fs-2">Hết hàng</span>
                                                </div>
                                            </c:when>
                                        </c:choose>
                                    </form>        
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container2" style="margin-top: 40px;">
                <!-- Sidebar -->
                <div class="sidebar">
                    <ul>
                        <li><a href="#country-of-production">Nước Sản Xuất</a></li>
                        <li><a href="#ingredients">Thành phần</a></li>
                        <li><a href="#benefits">Công dụng</a></li>
                        <li><a href="#usage">Cách dùng</a></li>
                        <li><a href="#target-audience">Đối tượng sử dụng</a></li>
                        <li><a href="#storage">Bảo quản</a></li>
                    </ul>
                </div>

                <!-- Content Section -->
                <div class="content">
                    <h2 id="country-of-production">Nước Sản Xuất</h2>
                    <p>${productId.countryOfProduction}</p>

                    <h2 id="ingredients">Thành phần</h2>
                    <c:forEach var="ingredient" items="${ingredients}">
                        <li>${ingredient.ingredientName}    /${ingredient.unit}</li>
                        </c:forEach>

                    <h2 id="benefits">Công dụng</h2>
                    <p>${productId.shortDescription}</p>

                    <h2 id="usage">Cách dùng</h2>
                    <p>${productId.contentReviewer}</p>

                    <h2 id="target-audience">Đối tượng sử dụng</h2>
                    <p>${productId.targetAudience}</p>

                    <h2 id="storage">Bảo quản</h2>
                    <p>${productId.productReviews}</p>
                </div>
            </div>
        </section>

        <!-- javascript -->
        <script src="assets/js/jquery.min.js"></script>
        <script src="assets/js/bootstrap.bundle.min.js"></script>
        <!-- SLIDER -->
        <script src="assets/js/tiny-slider.js"></script>
        <script src="assets/js/tiny-slider-init.js"></script>
        <script src="assets/js/slick.min.js"></script>
        <script src="assets/js/slick.init.js"></script>
        <!-- Icons -->
        <script src="assets/js/feather.min.js"></script>
        <!-- Main Js -->
        <script src="assets/js/app.js"></script>

        <script>
                                                            function selectUnit(selectedButton) {
                                                                // Deselect all buttons
                                                                const buttons = document.querySelectorAll('.unit-button');
                                                                buttons.forEach(button => {
                                                                    button.classList.remove('btn-dark');
                                                                    button.classList.add('btn-soft-primary');
                                                                });

                                                                // Select the clicked button
                                                                selectedButton.classList.remove('btn-soft-primary');
                                                                selectedButton.classList.add('btn-dark');

                                                                // Lấy giá trị price từ data-price và hiển thị nó
                                                                const price = selectedButton.getAttribute('data-price');
                                                                document.getElementById('priceDisplay').innerText = price + " VND"; // định dạng giá tiền theo VND

                                                                document.getElementById('selectedUnit').value = selectedButton.value;
                                                            }

                                                            // Khi tải trang, chọn unit đầu tiên mặc định
                                                            window.addEventListener("load", function () {
                                                                const firstButton = document.querySelector('.unit-button');
                                                                if (firstButton) {
                                                                    selectUnit(firstButton);
                                                                }
                                                            });


        </script>
    </body>
</html>