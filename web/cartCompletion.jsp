<%-- 
    Document   : cartCompletion
    Created on : Oct 26, 2024, 11:34:47 PM
    Author     : M7510
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <jsp:include page="header.jsp" />
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
            section.section.py-5 {
                padding-top: 30px; /* T?o kho?ng cách 100px phía trên */
            }
            section.section.py-5 {
                margin-top: 30px; /* ??y s?n ph?m xu?ng 100px */
            }
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: Arial, sans-serif;
                background-color: #f7f7f7;
            }

            .container {
                display: flex;
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }

            .sidebar {
                width: 25%;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .sidebar ul {
                list-style: none;
            }

            .sidebar ul li {
                margin-bottom: 15px;
            }

            .sidebar ul li a {
                text-decoration: none;
                font-size: 16px;
                color: #333;
            }

            .sidebar ul li a:hover {
                color: #007bff;
            }

            .content {
                width: 75%;
                margin-left: 20px;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            }

            .content h1 {
                font-size: 24px;
                margin-bottom: 10px;
                color: #333;
            }

            .content h2 {
                font-size: 20px;
                margin-bottom: 15px;
            }

            .content p {
                font-size: 16px;
                color: #555;
                margin-bottom: 20px;
            }

            .image-section img {
                width: 100%;
                max-width: 500px;
                border-radius: 8px;
                box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);

                /* Container layout using flexbox */
                .container {
                    display: flex;
                    max-width: 1200px;
                    margin: 0 auto;
                    padding: 20px;
                }

                /* Sidebar styling */
                .sidebar {
                    width: 25%;
                    background-color: #fff;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                .sidebar ul {
                    list-style: none;
                }

                .sidebar ul li {
                    margin-bottom: 15px;
                }

                .sidebar ul li a {
                    text-decoration: none;
                    font-size: 16px;
                    color: #333;
                }

                .sidebar ul li a:hover {
                    color: #007bff;
                }

                /* Smooth scrolling */
                html {
                    scroll-behavior: smooth;
                }

                /* Content section styling */
                .content {
                    width: 75%;
                    margin-left: 20px;
                    background-color: #fff;
                    padding: 20px;
                    border-radius: 8px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }
                h2 {
                    padding-top: 100px; /* Tùy chỉnh khoảng cách này để phù hợp với header của bạn */
                    margin-top: -100px; /* Khoảng cách này giúp đẩy phần tử lên trên một chút */
                }
                /* Phong cách mặc định */
                .content-section {
                    padding: 20px;
                    margin-bottom: 20px;
                    border-radius: 8px;
                    background-color: #fff;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                /* Hiệu ứng khi được chọn/click */
                .content-section.active {
                    box-shadow: 0 0 15px rgba(0, 123, 255, 0.7); /* Bóng mờ rõ hơn */
                    border: 1px solid #007bff; /* Đường viền xanh để nhấn mạnh */
                }

            }

            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            th {

                background-color: #5a99d4 !important;

                background-color: #4CAF50 !important;

                color: white;
            }
            tr:hover {
                background-color: #e9e9e9;
            }
            .shortened-text {
                max-width: 150px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                cursor: pointer;
                position: relative;
            }
            /* Tooltip when hovering */
            .shortened-text:hover::after {
                content: attr(data-full-text);
                position: absolute;
                background-color: #333;
                color: #fff;
                padding: 5px;
                border-radius: 5px;
                top: 100%;
                left: 0;
                white-space: normal;
                z-index: 1;
                width: 300px; /* Max width for tooltip */
                word-wrap: break-word;
            }

            @media screen and (max-width: 768px) {
                th, td {
                    display: block;
                    width: 100%;
                }
            }
            #searchInput {
                width: 300px;
                padding: 10px;
                margin-bottom: 20px;
                font-size: 16px;
            }

            .filter-form::-webkit-scrollbar {
                width: 8px; /* Set width of the scrollbar */
            }

            /* Background of the scrollbar */
            .filter-form::-webkit-scrollbar-track {
                background: #f1f1f1; /* Track color */
            }

            /* Handle of the scrollbar */
            .filter-form::-webkit-scrollbar-thumb {
                background: #888; /* Scrollbar color */
                border-radius: 10px; /* Rounded corners for the scrollbar */
            }

            /* Handle on hover */
            .filter-form::-webkit-scrollbar-thumb:hover {
                background: #555; /* Darker color when hovering */
            }

            .price-filter-buttons button {
                display: block; /* Make each button take up the full width */
                width: 90%; /* Full width of the container */
                margin-bottom: 10px; /* Space between buttons */
                background-color: white; /* White background */
                color: black; /* Black text */
                border: 2px solid black; /* Add a 2px black border */
                padding: 10px 20px; /* Add padding */
                font-size: 16px; /* Increase font size */
                cursor: pointer; /* Add pointer cursor */
                border-radius: 5px; /* Rounded corners */
                transition: background-color 0.3s ease, transform 0.2s ease, border-color 0.3s ease, color 0.3s ease; /* Smooth hover effect */
            }

            .price-filter-buttons button:hover {
                background-color: white; /* Darker green on hover */
                color: blue; /* Change text color to blue on hover */
                border-color: blue; /* Change border to blue on hover */
                transform: scale(1.05); /* Slight zoom on hover */
            }

            .price-filter-buttons button:active {
                background-color: #388e3c; /* Even darker green on click */
                transform: scale(0.98); /* Slight press effect */
            }

            .price-filter-buttons button.active {
                background-color: blue; /* Highlight color for active state */
                color: white; /* Text color for active state */
            }

            .sort-icon-asc {
                display: inline-block;
                color: #ffffff;
                font-size: 0.8em;
                margin-left: 5px;
            }

            .sort-icon-desc {
                display: inline-block;
                color: #ffffff;
                font-size: 0.8em;
                padding-top: 1px;
                margin-left: 5px;
                transform: rotate(180deg); /* Flips the triangle down */
            }

            a {
                color: inherit;
                text-decoration: none;
            }

            a:hover {
                color: #FFA500;
                text-decoration: underline;
            }

            .information table, .information tr,  .information td, .information th{
                padding: 10px;
                margin: auto;
                border: none;
            }

            body {
  
.btn-back-home {
    background-color: #cce4f3; /* Light blue background */
    color: #0a3c5a; /* Dark blue text */
    padding: 0.5rem 1rem;
    border-radius: 5px;
    font-weight: bold;
    text-decoration: none;
    display: inline-block;
    transition: background-color 0.3s ease, color 0.3s ease;
}

.btn-back-home:hover {
    background-color: #5a99d4; /* Slightly darker blue on hover */
    color: #ffffff;
}

        </style>
    </head>
    <body>
        <section class="section py-5">
            <div class="container">
                <div class="row">
                    <div class="col-lg-3 col-md-4">
                        <div class="filter-form" style="max-height: 700px; overflow-y: auto;">

<a href="home" class="btn btn-back-home mb-3">< Tiếp Tục Mua Sắm</a>

                            <!-- Đối tượng sử dụng -->
                            <h5>Bộ lọc nâng cao</h5>
                            <h6>Đối tượng sử dụng</h6>
                            <div>
                                <c:forEach var="audience" items="${sessionScope.audienceList}">
                                    <input type="checkbox" name="targetAudience" value="${audience}" onclick="filterByAudience()"> ${audience}<br>
                                </c:forEach>
                            </div>

                            <!-- Giá bán -->
                            <h6>Giá bán</h6>
                            <div class="price-filter-buttons">
                                <button onclick="filterByPrice('duoi100')">Dưới 100.000đ</button>
                                <button onclick="filterByPrice('100-300')">100.000đ - 300.000đ</button>
                                <button onclick="filterByPrice('300-500')">300.000đ - 500.000đ</button>
                                <button onclick="filterByPrice('tren500')">Trên 500.000đ</button>
                            </div>

                            <!-- Nước sản xuất -->
                            <h6>Nước sản xuất</h6>
                            <div id="countryContainer">
                                <!-- Search bar for filtering countries -->
                                <input type="text" class ="form-control-smc" id="countrySearch" placeholder="Tìm theo tên" onkeyup="filterCountries()" />

                                <!-- Country checkboxes -->
                                <div id="countryList">
                                    <c:forEach var="country" items="${countryList}" varStatus="status">
                                        <div class="country-item" style="display: none;">
                                            <input type="checkbox" name="countryofproduction" value="${country}" onclick="filterByCountry()"> ${country}<br>
                                        </div>
                                    </c:forEach>
                                </div>

                                <!-- 'See More' button -->
                                <a href="javascript:void(0);" id="seeMore" onclick="showMoreCountries()">Xem thêm</a>
                            </div>

                        </div>
                    </div>
                    <div class="col-lg-8">
                        <div class="card shadow mb-4">
                            <div class="card-header d-flex align-items-center">
                                <i class="ri-file-list-line me-2"></i>

                                <h5 class="mb-0">Đơn Hàng</h5>
                            </div>
                            <div class="card-body" >
                                <table class="table table-borderless align-middle">
                                    <thead>
                                        <tr>
                                            <th>Sản Phẩm</th>
                                            <th></th>
                                            <th>Đơn vị</th>
                                            <th>Số Lượng</th>
                                            <th>Giá Sản Phẩm</th>
                                            <th>Thành Tiền</th>

                                <h5 class="mb-0">Order Summary</h5>
                            </div>
                            <div class="card-body">
                                <table class="table table-borderless align-middle">
                                    <thead>
                                        <tr>
                                            <th>Product</th>
                                            <th></th>
                                            <th>Unit</th>
                                            <th>Quantity</th>
                                            <th>Price</th>
                                            <th>Total</th>

                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:set var="totalPrice" value="0" /> <!-- Initialize totalPrice -->

                                        <c:forEach items="${orders}" var="order">
                                            <tr>
                                                <td>${order.key.product.productName}</td>
                                                <td><img src="${order.key.product.imagePath}" style="max-width: 100px" /></td>
                                                <td>${order.key.unit.unitName}</td>
                                                <td style="text-align: center">${order.value}</td>
                                                <td>$${order.key.salePrice}</td>
                                                <td>$${order.value * order.key.salePrice}</td>
                                            </tr>
                                            <c:set var="totalPrice" value="${totalPrice + (order.value * order.key.salePrice)}" /> <!-- Add each item's total to totalPrice -->
                                        </c:forEach>
                                    </tbody>
                                </table>
                                <p class="text-end"><strong>Total:</strong> $${totalPrice}</p> <!-- Display totalPrice -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-12">
                        <!-- Basic Information Form -->
                        <div class="card shadow">
                            <div class="card-header d-flex align-items-center">
                                <i class="ri-user-line me-2"></i>

                                <h5 class="mb-0">Thông tin khách hàng</h5>

                                <h5 class="mb-0">Customer and Shipping Information</h5>

                            </div>
                            <div class="card-body">
                                <form action="orderCompletion" method="POST">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="name" class="form-label">Full Name</label>
                                            <input type="text" class="form-control" id="name" name="fullname" placeholder="Enter full name" required
                                                   value="${sessionScope.User != null ? sessionScope.User.fullName : ''}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="phone" class="form-label">Phone</label>
                                            <input type="tel" class="form-control" id="phone" name="phone" placeholder="Enter phone number" required
                                                   value="${sessionScope.User != null ? sessionScope.User.phone : ''}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="tel" class="form-control" id="phone" name="email" placeholder="Enter email address" required
                                                   value="${sessionScope.User != null ? sessionScope.User.email : ''}">
                                        </div>

                                        <div class="col-md-6 mb-3">

                                    </div>
                                    <div class="mb-3">

                                        <label for="address" class="form-label">Address</label>
                                        <input type="text" class="form-control" id="address" name="address" placeholder="Enter delivery address" required
                                               value="${sessionScope.User != null ? sessionScope.User.address : ''}">
                                    </div>

                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="expectedCost" class="form-label">Product Cost</label>
                                            <input type="number" class="form-control" id="expectedCost" name="expectedCost" readonly required value="${totalPrice}">
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="shippingFee" class="form-label">Shipping Fee</label>
                                            <input type="number" class="form-control" id="shippingFee" name="shippingFee" readonly required>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="totalCost" class="form-label">Total</label>
                                            <input type="number" class="form-control" id="totalCost" name="totalCost" readonly required>
                                        </div>
                                       <div class="col-md-6 mb-3">

                                    <div class="row">
                                        <div class="col-md-12 mb-3">
                                            <label for="expectedCost" class="form-label">Product Cost</label>
                                            <input type="number" class="form-control" id="expectedCost" name="expectedCost" readonly required value="${totalPrice}">
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label for="shippingFee" class="form-label">Shipping Fee</label>
                                            <input type="number" class="form-control" id="shippingFee" name="shippingFee" readonly required>
                                        </div>
                                        <div class="col-md-12 mb-3">
                                            <label for="totalCost" class="form-label">Total</label>
                                            <input type="number" class="form-control" id="totalCost" name="totalCost" readonly required>
                                        </div>
                                    </div>
                                    <div class="mb-3">

                                        <label for="paymentMethod" class="form-label">Payment Method</label>
                                        <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                            <option value="">Choose...</option>
                                            <option value="creditCard">Credit Card</option>
                                            <option value="cashOnDelivery">Cash on Delivery</option>
                                        </select>
                                    </div>

                                    </div>
                                    


                                    <div class="alert alert-warning d-none" id="distanceWarning"></div>
                                    <button type="submit" class="btn btn-primary w-100">Submit Order</button>
                                </form>
                                <script>
                                    const apiKey = '5b3ce3597851110001cf6248522db1275c8c4b3f9ed3b8540800c84b';
                                    const originCoordinates = {lat: 21.0245, lng: 105.84117}; // Set to a place in Hanoi, Vietnam

                                    document.getElementById('address').addEventListener('blur', calculateShippingFee);

                                    async function calculateShippingFee() {
                                        const address = document.getElementById('address').value;
                                        const deliveryCoordinates = await getCoordinates(address);
                                        if (deliveryCoordinates) {
                                            const distance = await getDistance(originCoordinates, deliveryCoordinates);
                                            const shippingFee = calculateShippingCost(distance);

                                            // Check if distance is too far (over 6000 km)
                                            if (distance > 6000000) {
                                                document.getElementById('distanceWarning').innerText =
                                                        'The delivery address is too far. Please enter a closer address.';
                                                document.getElementById('distanceWarning').classList.remove('d-none');
                                                document.getElementById('shippingFee').value = '';
                                            } else {
                                                document.getElementById('distanceWarning').classList.add('d-none');
                                                document.getElementById('shippingFee').value = shippingFee.toFixed(2);
                                                const expectedCost = parseFloat(document.getElementById('expectedCost').value);
                                                const totalCost = (shippingFee + expectedCost).toFixed(2);
                                                document.getElementById('totalCost').value = totalCost;
                                            }
                                        } else {
                                            alert('Unable to retrieve coordinates. Please check the address.');
                                        }
                                    }

                                    async function getCoordinates(address) {
                                        const response = await fetch('https://api.openrouteservice.org/geocode/search?api_key=' + apiKey + '&text=' + encodeURIComponent(address));
                                        const data = await response.json();

                                        if (data.features.length > 0) {
                                            const coordinates = data.features[0].geometry.coordinates;
                                            return {lng: coordinates[0], lat: coordinates[1]};
                                        }
                                        return null;
                                    }

                                    async function getDistance(origin, destination) {
                                        try {
                                            // Construct the request URL
                                            const url = 'https://api.openrouteservice.org/v2/directions/cycling-regular?api_key=' + apiKey +
                                                    '&start=' + origin.lng + ',' + origin.lat +
                                                    '&end=' + destination.lng + ',' + destination.lat;
                                            console.log("Requesting distance from:", url);
                                            const response = await fetch(url);
                                            if (!response.ok) {
                                                throw new Error('Network response was not ok: ' + response.statusText);
                                            }
                                            const data = await response.json();
                                            console.log("Distance API response:", data);
                                            if (!data.features || data.features.length === 0 || !data.features[0].properties.segments || data.features[0].properties.segments.length === 0) {
                                                throw new Error('No routes found for the given coordinates.');
                                            }
                                            return data.features[0].properties.segments[0].distance;
                                        } catch (error) {
                                            alert("Unable to calculate distance: " + error.message);
                                            console.error("Distance calculation error:", error);
                                            return null;
                                        }
                                    }

                                    function calculateShippingCost(distance) {
                                        const ratePerKm = 0.5; // Example rate per kilometer
                                        return (distance / 1000) * ratePerKm; // Convert meters to kilometers
                                    }
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </body>
    <!-- Start -->
    <footer class="bg-footer">
        <div class="container">
            <div class="row">
                <div class="col-xl-5 col-lg-4 mb-0 mb-md-4 pb-0 pb-md-2">
                    <a href="#" class="logo-footer">
                        <img src="assets/images/logo-light.png" height="22" alt="">
                    </a>
                    <p class="mt-4 me-xl-5">Great doctor if you need your family member to get effective immediate assistance, emergency treatment or a simple consultation.</p>
                </div><!--end col-->

                <div class="col-xl-7 col-lg-8 col-md-12">
                    <div class="row">
                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Company</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> About us</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Services</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Team</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Project</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Blog</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Login</a></li>
                            </ul>
                        </div><!--end col-->

                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Departments</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Eye Care</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Psychotherapy</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Dental Care</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Orthopedic</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Cardiology</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Gynecology</a></li>
                                <li><a href="#" class="text-foot"><i class="mdi mdi-chevron-right me-1"></i> Neurology</a></li>
                            </ul>
                        </div><!--end col-->

                        <div class="col-md-4 col-12 mt-4 mt-sm-0 pt-2 pt-sm-0">
                            <h5 class="text-light title-dark footer-head">Contact us</h5>
                            <ul class="list-unstyled footer-list mt-4">
                                <li class="d-flex align-items-center">
                                    <i data-feather="mail" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="mailto:contact@example.com" class="text-foot ms-2">contact@example.com</a>
                                </li>

                                <li class="d-flex align-items-center">
                                    <i data-feather="phone" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="tel:+152534-468-854" class="text-foot ms-2">+152 534-468-854</a>
                                </li>

                                <li class="d-flex align-items-center">
                                    <i data-feather="map-pin" class="fea icon-sm text-foot align-middle"></i>
                                    <a href="javascript:void(0)" class="video-play-icon text-foot ms-2">View on Google map</a>
                                </li>
                            </ul>

                            <ul class="list-unstyled social-icon footer-social mb-0 mt-4">
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="facebook" class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="instagram" class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="twitter" class="fea icon-sm fea-social"></i></a></li>
                                <li class="list-inline-item"><a href="#" class="rounded-pill"><i data-feather="linkedin" class="fea icon-sm fea-social"></i></a></li>
                            </ul><!--end icon-->
                        </div><!--end col-->
                    </div><!--end row-->
                </div><!--end col-->
            </div><!--end row-->
        </div><!--end container-->

        <div class="container mt-5">
            <div class="pt-4 footer-bar">
                <div class="row align-items-center">
                    <div class="col-sm-6">
                        <div class="text-sm-start text-center">
                            <p class="mb-0"><script>document.write(new Date().getFullYear())</script> © Doctris. Design with <i class="mdi mdi-heart text-danger"></i> by <a href="index.html" target="_blank" class="text-reset">Shreethemes</a>.</p>
                        </div>
                    </div><!--end col-->

                    <div class="col-sm-6 mt-4 mt-sm-0">
                        <ul class="list-unstyled footer-list text-sm-end text-center mb-0">
                            <li class="list-inline-item"><a href="terms.html" class="text-foot me-2">Terms</a></li>
                            <li class="list-inline-item"><a href="privacy.html" class="text-foot me-2">Privacy</a></li>
                            <li class="list-inline-item"><a href="aboutus.html" class="text-foot me-2">About</a></li>
                            <li class="list-inline-item"><a href="contact.html" class="text-foot me-2">Contact</a></li>
                        </ul>
                    </div><!--end col-->
                </div><!--end row-->
            </div>
        </div><!--end container-->
    </footer><!--end footer-->
    <!-- End -->

    <!-- Back to top -->
    <a href="#" onclick="topFunction()" id="back-to-top" class="btn btn-icon btn-pills btn-primary back-to-top"><i data-feather="arrow-up" class="icons"></i></a>
    <!-- Back to top -->

    <!-- Offcanvas Start -->
    <div class="offcanvas bg-white offcanvas-top" tabindex="-1" id="offcanvasTop">
        <div class="offcanvas-body d-flex align-items-center align-items-center">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="text-center">
                            <h4>Search now.....</h4>
                            <div class="subcribe-form mt-4">
                                <form>
                                    <div class="mb-0">
                                        <input type="text" id="help" name="name" class="border bg-white rounded-pill" required="" placeholder="Search">
                                        <button type="submit" class="btn btn-pills btn-primary">Search</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div><!--end col-->
                </div><!--end row-->
            </div><!--end container-->
        </div>
    </div>
    <!-- Offcanvas End -->



    <div class="offcanvas-footer p-4 border-top text-center">
        <ul class="list-unstyled social-icon mb-0">
            <li class="list-inline-item mb-0"><a href="https://1.envato.market/doctris-template" target="_blank" class="rounded"><i class="uil uil-shopping-cart align-middle" title="Buy Now"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://dribbble.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-dribbble align-middle" title="dribbble"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.facebook.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-facebook-f align-middle" title="facebook"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://www.instagram.com/shreethemes/" target="_blank" class="rounded"><i class="uil uil-instagram align-middle" title="instagram"></i></a></li>
            <li class="list-inline-item mb-0"><a href="https://twitter.com/shreethemes" target="_blank" class="rounded"><i class="uil uil-twitter align-middle" title="twitter"></i></a></li>
            <li class="list-inline-item mb-0"><a href="mailto:support@shreethemes.in" class="rounded"><i class="uil uil-envelope align-middle" title="email"></i></a></li>
            <li class="list-inline-item mb-0"><a href="index.html" target="_blank" class="rounded"><i class="uil uil-globe align-middle" title="website"></i></a></li>
        </ul><!--end icon-->
    </div>



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
</html>
