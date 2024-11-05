
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="model.Stock" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductUnit" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<link rel="stylesheet" href="styles.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Stock Management</title>
        <link rel="stylesheet" href="styles.css">
        <style>
            /* Style for the table */
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }

            .actions button {
                margin-bottom: 8px; /* Vertical spacing between buttons */
            }

            table th, table td {
                padding: 12px;
                text-align: center;
                border: 1px solid #ddd;
                font-size: 14px;
            }

            table th {
                background-color: #4CAF50;
                color: white;
            }

            table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            table tr:hover {
                background-color: #f1f1f1;
            }

            h1 {
                text-align: center;
                margin-bottom: 20px;
                color: #333;
            }

            .pagination {
                text-align: center;
                margin-top: 20px;
            }

            .pagination a {
                display: inline-block;
                padding: 8px 16px;
                margin: 0 4px;
                border: 1px solid #ddd;
                text-decoration: none;
                color: #333;
            }

            .pagination a:hover {
                background-color: #f1f1f1;
            }

            .pagination a.active {
                background-color: #4CAF50;
                color: white;
                border: 1px solid #4CAF50;
            }

            .search-container {
                text-align: center;
                margin-bottom: 20px;
            }

            .search-container input[type="text"] {
                padding: 10px;
                width: 200px;
                margin-right: 10px;
            }

            .search-container button {
                padding: 10px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }

            .search-container button:hover {
                background-color: #45a049;
            }

            /* Styling the product display section */
            .product-display {
                border: 1px solid #ddd;
                padding: 15px;
                margin-top: 20px;
                border-radius: 5px;
                background-color: #f4f4f4;
                margin-bottom: 20px;
            }

            .product-display h3 {
                font-size: 18px;
                margin-bottom: 10px;
                color: #333;
            }

            .product-display button {
                background-color: #007BFF;
                color: white;
                border: none;
                padding: 8px 15px;
                border-radius: 5px;
                margin-right: 10px;
            }

            .product-display button:hover {
                background-color: #0056b3;
            }

            .product-display .fa {
                margin-right: 5px;
            }

            /* For each product's stock table */
            .product-table {
                width: 100%;
                margin-top: 10px;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            }

            .product-table th, .product-table td {
                padding: 12px;
                text-align: center;
            }

            .product-table th {
                background-color: #6c757d;
                color: white;
            }

            .product-table tr:nth-child(even) {
                background-color: #f9f9f9;
            }

            .product-table tr:hover {
                background-color: #f1f1f1;
            }

            .total-quantity {
                font-weight: bold;
                font-size: 18px;
                color: #333;
                margin-top: 10px;
                padding: 10px 0;
            }

            /* Responsive adjustments */
            @media (max-width: 768px) {
                .product-display {
                    padding: 10px;
                }

                table, .product-table {
                    width: 100%;
                }

                .search-container input[type="text"] {
                    width: 100%;
                    margin: 10px 0;
                }

                .pagination a {
                    padding: 5px 10px;
                }
            }
        </style>
        <%


            // Get the stock list from the request
            List<Stock> stockList = (List<Stock>) request.getAttribute("stockList");
            List<Product> productList = (List<Product>) request.getAttribute("productList");
            List<ProductUnit> pUnits = (List<ProductUnit>) request.getAttribute("pUnits");

            // Create maps for product and unit names
            Map<String, String> productMap = new HashMap<>();
            for (Product product : productList) {
                productMap.put(product.getProductID(), product.getProductName());
            }

            Map<String, String> unitMap = new HashMap<>();
            for (ProductUnit unit : pUnits) {
                unitMap.put(unit.getUnitID(), unit.getUnitName());
            }

        %>
        <script>
            function filterProducts() {
                var input = document.getElementById('searchInput').value.toLowerCase().trim();  // Lấy và chuyển thành chữ thường, loại bỏ khoảng trắng
                var keywords = input.split(/\s+/);  // Tách từ khóa thành các từ dựa trên khoảng trắng
                var products = document.querySelectorAll('.product-wrapper');  // Chọn tất cả các phần tử sản phẩm

                // Lặp qua mỗi sản phẩm
                products.forEach(function (product) {
                    var productName = product.querySelector('.product-display h3').textContent.toLowerCase();
                    var productId = productName.split('-')[0].trim();  // Tách phần ID của sản phẩm từ tên (nếu ID nằm trước dấu '-')

                    // Kiểm tra nếu bất kỳ từ nào trong keywords xuất hiện trong tên hoặc ID sản phẩm
                    var isMatch = keywords.some(function (keyword) {
                        return productName.includes(keyword) || productId.includes(keyword);
                    });

                    // Hiển thị hoặc ẩn sản phẩm tùy thuộc vào kết quả khớp
                    if (isMatch) {
                        product.style.display = '';  // Hiển thị sản phẩm
                    } else {
                        product.style.display = 'none';  // Ẩn sản phẩm
                    }
                });
            }
        </script>



        <%@include file="dashboardHeader.jsp" %>
    </head>
    <body>

        <h2>Stock View</h2>
        <div class="search-container">
            <input type="text" id="searchInput" placeholder="Search by Product Name or ID..." onkeyup="filterProducts()">
        </div>


        <c:forEach var="entry" items="${groupedStock}">
            <div class="product-wrapper" id="product-${entry.key}">
                <div class="product-display">
                    <h3>
                        Product: ${entry.key} - ${entry.value.productName}
                    </h3>
                    <button type="button" onclick="window.location.href = 'ProductDetail?productID=P${fn:substringAfter(entry.key, 'P')}'">
                        <i class="fas fa-eye"></i> View Product
                    </button>

                    <form action="viewImports" method="POST" style="display:inline;">
                        <input type="hidden" name="Pid" value="P${fn:substringAfter(entry.key, 'P')}">
                        <button type="submit">
                            <i class="fas fa-eye"></i> View Imports
                        </button>
                    </form>
                </div>

                <table class="product-table">
                    <thead>
                        <tr>
                            <th>Batch No</th>
                            <th>Base Unit</th>
                            <th>Quantity</th>
                            <th>Price Import (VND)</th>
                            <th>Manufacture Date</th>
                            <th>Expiration Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="stock" items="${entry.value.stocks}">
                            <tr>
                                <td>${stock.batchNo}</td>
                                <td>
                                    <c:set var="baseUnitId" value="${stock.baseUnitId}" />
                                    <%= unitMap.get((String)pageContext.getAttribute("baseUnitId")) %>
                                </td>
                                <td>${stock.quantity}</td>
                                <td>${stock.priceImport}</td>
                                <td>${stock.dateManufacture}</td>
                                <td>${stock.dateExpired}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>

                <div class="total-quantity">
                    Total Quantity:
                    <c:set var="totalQuantity" value="0" />
                    <c:forEach var="stock" items="${entry.value.stocks}">
                        <c:set var="totalQuantity" value="${totalQuantity + stock.quantity}" />
                    </c:forEach>
                    ${totalQuantity}
                </div>
            </div>
        </c:forEach>


    </body>
</html>
