
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
            }

            .actions button {
                margin-bottom: 8px; /* Khoảng cách giữa các nút theo chiều dọc */
            }

            table th, table td {
                padding: 10px;
                text-align: center;
                border: 1px solid #ddd;
            }

            table th {
                background-color: #f2f2f2;
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
        <%@include file="dashboardHeader.jsp" %>
    </head>
    <body>

        <h2>Stock Management</h2>

        <c:forEach var="entry" items="${groupedStock}">
            <h3>
                <span style="display: inline-block; margin-right: 10px;">
                    Product: ${entry.key} - ${entry.value.productName}
                </span>
                <button type="button" onclick="window.location.href = 'ProductDetail?productID=P${fn:substringAfter(entry.key, 'P')}'" style="margin-right: 10px;">
                    <i class="fas fa-eye"></i>
                </button>
                <form action="importServlet" method="get" style="display:inline;">
                    <!-- Set productID dynamically using the value from entry.key -->
                    <input type="hidden" name="productID" value="P${fn:substringAfter(entry.key, 'P')}">
                    <button type="submit" onclick="return confirm('Are you sure you want to import this product?');" style="margin-right: 10px; margin-top: 10px;">
                        <i class="fas fa-download"></i>
                    </button>
                </form>
            </h3>


            <table border="1">
                <thead>
                    <tr>
                        <th>Batch No</th>
                        <th>Base Unit</th>
                        <th>Quantity</th>
                        <th>Price</th>
                        <th>Manufacture Date</th>
                        <th>Expiration Date</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="stock" items="${entry.value.stocks}">
                        <tr>
                            <td>${stock.batchNo}</td>
                            <td><c:out value="${unitMap[stock.baseUnitId]}" /></td>

                            <td>${stock.quantity}</td>
                            <td>${stock.priceImport}</td>
                            <td>${stock.dateManufacture}</td>
                            <td>${stock.dateExpired}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <h4>Total Quantity: 
                <c:set var="totalQuantity" value="0" />
                <c:forEach var="stock" items="${entry.value.stocks}">
                    <c:set var="totalQuantity" value="${totalQuantity + stock.quantity}" />
                </c:forEach>
                ${totalQuantity}
            </h4>
        </c:forEach>

    </body>
</html>
