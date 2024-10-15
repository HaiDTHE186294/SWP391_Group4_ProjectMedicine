<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Stock" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductUnit" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="dashboardHeader.jsp" %>
        <title>Stock View</title>
        <style>
            /* Style for the table */
            table {
                width: 100%;
                border-collapse: collapse;
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
    </head>
    <body>
        <h1>Stock List</h1>

        <!-- Search bar for Product Name -->
        <div class="search-container">
            <form action="" method="get">
                <input type="text" name="search" placeholder="Search by Product Name..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
                <button type="submit">Search</button>
            </form>
        </div>

        <%
            // Define the number of items per page
            int itemsPerPage = 10;

            // Get the current page number from the request (default is 1)
            String pageParam = request.getParameter("page");
            int currentPage = pageParam == null ? 1 : Integer.parseInt(pageParam);

            // Get the search query from the request
            String searchQuery = request.getParameter("search");

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

            // Filter the stock list based on the search query
            if (searchQuery != null && !searchQuery.isEmpty()) {
                stockList.removeIf(stock -> !productMap.get(stock.getProductId()).toLowerCase().contains(searchQuery.toLowerCase()));
            }

            if (stockList != null && !stockList.isEmpty()) {
                // Calculate the total number of pages
                int totalItems = stockList.size();
                int totalPages = (int) Math.ceil((double) totalItems / itemsPerPage);

                // Calculate the starting and ending indices for the current page
                int start = (currentPage - 1) * itemsPerPage;
                int end = Math.min(start + itemsPerPage, totalItems);
        %>

        <table>
            <thead>
                <tr>
                    <th>Batch No</th>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Unit Name</th>
                    <th>
                        Quantity
                        <button id="sortQuantityButton" onclick="sortByNumber(4)">Sort</button>
                    </th>
                    <th>
                        Price Import (VND)
                        <button id="sortPriceButton" onclick="sortByNumber(5)">Sort</button>
                    </th>
                    <th>Date Manufacture
                        <button id="sortManufactureButton" onclick="sortManufacture()">Sort</button></th>
                    <th>
                        Date Expired
                        <button id="sortExpiredButton" onclick="sortExpired()">Sort</button>
                    </th>
                </tr>
            </thead>
            <tbody>
                <%
                    for (int i = start; i < end; i++) {
                        Stock stock = stockList.get(i);
                        String productName = productMap.get(stock.getProductId());
                        String unitName = unitMap.get(stock.getBaseUnitId());
                %>
                <tr>
                    <td><%= stock.getBatchNo() %></td>
                    <td><%= stock.getProductId() %></td>
                    <td><%= productName != null ? productName : "Unknown Product" %></td>
                    <td><%= unitName != null ? unitName : "Unknown Unit" %></td>
                    <td><%= stock.getQuantity() %></td>
                    <td><%= stock.getPriceImport() %></td>
                    <td><%= stock.getDateManufacture() %></td>
                    <td><%= stock.getDateExpired() %></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>

        <!-- Pagination links -->
        <div class="pagination">
            <%
                // Display "Previous" button if not on the first page
                if (currentPage > 1) {
            %>
            <a href="?page=<%= currentPage - 1 %>&search=<%= searchQuery != null ? searchQuery : "" %>">Previous</a>
            <%
                }

                // Display links for all pages
                for (int i = 1; i <= totalPages; i++) {
                    if (i == currentPage) {
            %>
            <a href="?page=<%= i %>&search=<%= searchQuery != null ? searchQuery : "" %>" class="active"><%= i %></a>
            <%
                    } else {
            %>
            <a href="?page=<%= i %>&search=<%= searchQuery != null ? searchQuery : "" %>"><%= i %></a>
            <%
                    }
                }

                // Display "Next" button if not on the last page
                if (currentPage < totalPages) {
            %>
            <a href="?page=<%= currentPage + 1 %>&search=<%= searchQuery != null ? searchQuery : "" %>">Next</a>
            <%
                }
            %>
        </div>

        <%
            } else {
        %>
        <p>No stocks available</p>
        <%
            }
        %>

        <script>
            let sortDirectionMap = {}; // Biến lưu trữ chiều sắp xếp cho các cột

            // Hàm sắp xếp chung cho các cột số (Quantity và Price)
            function sortByNumber(columnIndex) {
                const table = document.querySelector("table tbody");
                const rows = Array.from(table.rows); // Lấy tất cả các hàng trong bảng

                // Kiểm tra chiều sắp xếp hiện tại (tăng dần hoặc giảm dần)
                sortDirectionMap[columnIndex] = !sortDirectionMap[columnIndex];

                // Sắp xếp các hàng dựa trên giá trị số của cột được chỉ định
                rows.sort((rowA, rowB) => {
                    const valueA = parseFloat(rowA.cells[columnIndex].innerText) || 0;
                    const valueB = parseFloat(rowB.cells[columnIndex].innerText) || 0;
                    return sortDirectionMap[columnIndex] ? valueB - valueA : valueA - valueB;
                });

                // Xóa các hàng cũ trong bảng
                while (table.firstChild) {
                    table.removeChild(table.firstChild);
                }

                // Thêm các hàng đã được sắp xếp lại vào bảng
                rows.forEach(row => table.appendChild(row));
            }
            let manufactureSortDirection = false; // Biến để theo dõi chiều sắp xếp ngày sản xuất
            let expiredSortDirection = false; // Biến để theo dõi chiều sắp xếp ngày hết hạn

            // Hàm sắp xếp ngày sản xuất
            function sortManufacture() {
                const table = document.querySelector("table tbody");
                const rows = Array.from(table.rows);

                manufactureSortDirection = !manufactureSortDirection;

                rows.sort((rowA, rowB) => {
                    const valueA = new Date(rowA.cells[6].innerText);
                    const valueB = new Date(rowB.cells[6].innerText);
                    return manufactureSortDirection ? valueB - valueA : valueA - valueB;
                });

                while (table.firstChild) {
                    table.removeChild(table.firstChild);
                }

                rows.forEach(row => table.appendChild(row));
            }

            // Hàm sắp xếp ngày hết hạn
            function sortExpired() {
                const table = document.querySelector("table tbody");
                const rows = Array.from(table.rows);

                expiredSortDirection = !expiredSortDirection;

                rows.sort((rowA, rowB) => {
                    const valueA = new Date(rowA.cells[7].innerText);
                    const valueB = new Date(rowB.cells[7].innerText);
                    return expiredSortDirection ? valueB - valueA : valueA - valueB;
                });

                while (table.firstChild) {
                    table.removeChild(table.firstChild);
                }

                rows.forEach(row => table.appendChild(row));
            }
        </script>
    </body>
</html>
