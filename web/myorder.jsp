
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>


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
            background-color: #4CAF50;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f2f2f2;
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
      .btn-back-home {
    display: inline-block;
    padding: 10px 20px;
    font-size: 16px;
    color: #ffffff;
    background-color: #00aaff; /* Màu xanh biển nhạt */
    border: none;
    border-radius: 5px;
    text-align: center;
    text-decoration: none;
    margin-top: 40px; /* Khoảng cách đẩy nút xuống */
    transition: background-color 0.3s ease, transform 0.2s ease; /* Hiệu ứng mượt */
}

.btn-back-home:hover {
    background-color: #008ecc; /* Màu xanh đậm hơn khi hover */
    transform: scale(1.05); /* Hiệu ứng phóng to nhẹ */
    color: #ffffff; /* Đảm bảo chữ vẫn màu trắng */
    text-decoration: underline; /* Gạch dưới khi hover */
}

.btn-back-home:active {
    transform: scale(0.98); /* Hiệu ứng nhấn nhẹ */
    background-color: #006699; /* Màu xanh đậm khi nhấn */
}
    </style>

</head>
<body>
    <section class="section py-5">
        <div class="container">
            <div class="row">
                <div class="col-lg-3 col-md-4">
                    <div class="filter-form" style="max-height: 700px; overflow-y: auto;">
                       

                        <!-- Nước sản xuất -->
                      
                        <div id="countryContainer">
                            <!-- Search bar for filtering countries -->
                            <a href="home" class="btn btn-back-home mb-3">< Tiếp Tục Mua Sắm</a>

                            <!-- Country checkboxes -->
                            <div id="countryList">
                                <c:forEach var="country" items="${countryList}" varStatus="status">
                                    <div class="country-item" style="display: none;">
                                        <input type="checkbox" name="countryofproduction" value="${country}" onclick="filterByCountry()"> ${country}<br>
                                    </div>
                                </c:forEach>
                            </div>

                           
                        </div>
                    </div>
                </div>
                <!-- Card ch?a s?n ph?m -->
                <div class ="col-lg-9">
                    <ul class="nav nav-tabs justify-content-center" id="orderStatusTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == -1 ? 'active' : ''}" id="all-tab" href="?status=-1" role="tab" aria-controls="all-orders" aria-selected="${currentStatus == -1}">All Orders</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 0 ? 'active' : ''}" id="pending-tab" href="?status=0" role="tab" aria-controls="pending-orders" aria-selected="${currentStatus == 0}">Pending</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 1 ? 'active' : ''}" id="delivering-tab" href="?status=1" role="tab" aria-controls="delivering-orders" aria-selected="${currentStatus == 1}">Submitted</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 2 ? 'active' : ''}" id="delivering-tab" href="?status=2" role="tab" aria-controls="delivering-orders" aria-selected="${currentStatus == 2}">Delivering</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 3 ? 'active' : ''}" id="completed-tab" href="?status=3" role="tab" aria-controls="completed-orders" aria-selected="${currentStatus == 3}">Completed</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 4 ? 'active' : ''}" id="canceled-tab" href="?status=4" role="tab" aria-controls="canceled-orders" aria-selected="${currentStatus == 4}">Canceled</a>
                        </li>
                        <li class="nav-item" role="presentation">
                            <a class="nav-link ${currentStatus == 5 ? 'active' : ''}" id="canceled-tab" href="?status=5" role="tab" aria-controls="canceled-orders" aria-selected="${currentStatus == 5}">Refunded</a>
                        </li>
                    </ul>
                    <div class="card border-0 shadow-lg rounded-md overflow-hidden">
                        <div class="row g-0 align-items-center">
                            <c:choose>
                                <c:when test="${not empty orderList}">   
                                    <table id="productTable">
                                        <tr>
                                            <th>
                                                <a href="?sortColumn=order_id&status=${currentStatus}&sortOrder=${sortColumn == 'order_id' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Product ID
                                                    <c:if test="${sortColumn == 'order_id'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                            <th>
                                                <a href="?sortColumn=order_date&status=${currentStatus}&sortOrder=${sortColumn == 'order_date' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Order Date
                                                    <c:if test="${sortColumn == 'order_date'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                            <th>Products</th>
                                            <th>
                                                <a href="?sortColumn=order_total&status=${currentStatus}&sortOrder=${sortColumn == 'order_total' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Total Cost
                                                    <c:if test="${sortColumn == 'order_total'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                            <th>
                                                <a href="?sortColumn=status&status=${currentStatus}&sortOrder=${sortColumn == 'status' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Status
                                                    <c:if test="${sortColumn == 'status'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                        </tr>

                                        <c:forEach var = "order" items = "${orderList}">
                                            <tr>
                                                <td>
                                                    <a href = 'orderdtl?id=${order.order_id}'" class = "btn btn-primary">${order.order_id}</a>
                                                </td>
                                                <td>
                                                    ${order.order_date}
                                                </td>
                                                <td class="shortened-text" data-full-text="${order.orderDetail}">
                                                    <c:if test="${not empty order.orderDetail}">
                                                        ${order.orderDetail.get(0).product.productName}
                                                        <c:if test="${order.orderDetail.size() > 1}">
                                                            and ${order.orderDetail.size() - 1} more product
                                                            <c:choose>
                                                                <c:when test="${order.orderDetail.size() - 1 != 1}">s</c:when>
                                                            </c:choose>
                                                        </c:if>
                                                    </c:if>
                                                </td>
                                                <td>$${order.order_total}</td>
                                                <td>${order.getStatus(order.status)}</td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center mt-3">
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=1&status=${currentStatus}&limit=${limit}" aria-label="First" tabindex="${currentPage == 1 ? '-1' : '0'}">
                                                    <span aria-hidden="true">First</span>
                                                </a>
                                            </li>
                                            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage - 1}&status=${currentStatus}&limit=${limit}" aria-label="Previous" tabindex="${currentPage == 1 ? '-1' : '0'}">
                                                    <span aria-hidden="true">Previous</span>
                                                </a>
                                            </li>

                                            <c:forEach var="i" begin="1" end="${totalPages}">
                                                <li class="page-item ${i == currentPage ? 'active' : ''}">
                                                    <a class="page-link" href="?page=${i}&status=${currentStatus}&limit=${limit}">${i}</a>
                                                </li>
                                            </c:forEach>

                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${currentPage + 1}&status=${currentStatus}&limit=${limit}" aria-label="Next" tabindex="${currentPage == totalPages ? '-1' : '0'}">
                                                    <span aria-hidden="true">Next</span>
                                                </a>
                                            </li>
                                            <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                                                <a class="page-link" href="?page=${totalPages}&status=${currentStatus}&limit=${limit}" aria-label="Last" tabindex="${currentPage == totalPages ? '-1' : '0'}">
                                                    <span aria-hidden="true">Last</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                </c:when>
                                <c:otherwise>
                                    <table id="productTable">
                                        <tr>
                                            <th>
                                                <a href="?sortColumn=order_id&sortOrder=${sortColumn == 'order_id' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Product ID
                                                    <c:if test="${sortColumn == 'order_id'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                            <th>
                                                <a href="?sortColumn=order_date&sortOrder=${sortColumn == 'order_date' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Order Date
                                                    <c:if test="${sortColumn == 'order_date'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                            <th>Products</th>
                                            <th>
                                                <a href="?sortColumn=order_total&sortOrder=${sortColumn == 'order_total' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Total Cost
                                                    <c:if test="${sortColumn == 'order_total'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                            <th>
                                                <a href="?sortColumn=status&sortOrder=${sortColumn == 'status' && sortOrder == 'ASC' ? 'DESC' : 'ASC'}">
                                                    Status
                                                    <c:if test="${sortColumn == 'status'}">
                                                        <span class="${sortOrder == 'ASC' ? 'sort-icon-asc' : 'sort-icon-desc'}">&#9650;</span>
                                                    </c:if>
                                                </a>
                                            </th>
                                        </tr>
                                    </table>
                                    <nav aria-label="Page navigation">
                                        <ul class="pagination justify-content-center mt-3">
                                            <li class="page-item disabled">
                                                <a class="page-link" href="?page=1&amp;limit=5" aria-label="First" tabindex="-1">
                                                    <span aria-hidden="true">First</span>
                                                </a>
                                            </li>
                                            <li class="page-item disabled">
                                                <a class="page-link" href="?page=0&amp;limit=5" aria-label="Previous" tabindex="-1">
                                                    <span aria-hidden="true">Previous</span>
                                                </a>
                                            </li>
                                            <li class="page-item active">
                                                <a class="page-link" href="?page=1&amp;limit=5">1</a>
                                            </li>
                                            <li class="page-item disabled">
                                                <a class="page-link" href="?page=2&amp;limit=5" aria-label="Next" tabindex="-1">
                                                    <span aria-hidden="true">Next</span>
                                                </a>
                                            </li>
                                            <li class="page-item disabled">
                                                <a class="page-link" href="?page=2&amp;limit=5" aria-label="Last" tabindex="-1">
                                                    <span aria-hidden="true">Last</span>
                                                </a>
                                            </li>
                                        </ul>
                                    </nav>
                                    <p style = "text-align:center">No orders available.</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
    </section>
</body>
<script>
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();

            const target = document.querySelector(this.getAttribute('href'));
            const offset = 100; // khoảng cách bù trừ
            const elementPosition = target.getBoundingClientRect().top;
            const offsetPosition = elementPosition - offset;

            window.scrollBy({
                top: offsetPosition,
                behavior: 'smooth'
            });
        });
    });


    // Lấy tất cả các mục sidebar
    const sidebarLinks = document.querySelectorAll('.sidebar ul li a');

    // Lấy tất cả các phần nội dung tương ứng
    const contentSections = document.querySelectorAll('.content-section');

    // Lặp qua từng mục trong sidebar
    sidebarLinks.forEach(link => {
        link.addEventListener('click', function (event) {
            event.preventDefault();

            // Loại bỏ lớp 'active' từ tất cả các phần nội dung
            contentSections.forEach(section => {
                section.classList.remove('active');
            });

            // Thêm lớp 'active' cho phần nội dung được nhấp vào
            const targetSection = document.querySelector(this.getAttribute('href'));
            targetSection.classList.add('active');
        });
    });

    function selectUnit(selectedButton) {
        // Deselect all buttons
        const buttons = document.querySelectorAll('.unit-button');
        buttons.forEach(button => {
            button.classList.remove('btn-dark'); // or any class that indicates 'selected'
            button.classList.add('btn-soft-primary');
        });

        // Select the clicked button
        selectedButton.classList.remove('btn-soft-primary');
        selectedButton.classList.add('btn-dark'); // Change to your selected style

        document.getElementById('selectedUnit').value = selectedButton.value;
    }
</script>


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
</body>

</html>