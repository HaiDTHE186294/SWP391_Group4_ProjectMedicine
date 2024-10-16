<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Imports</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">

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

        <script>
            // Sort the table based on the column index (Order ID or Product ID)
            function sortTable(n, table) {
                let rows, switching, i, x, y, shouldSwitch, dir, switchcount = 0;
                switching = true;
                dir = "asc"; // Set the sorting direction to ascending initially

                while (switching) {
                    switching = false;
                    rows = table.rows;

                    for (i = 1; i < (rows.length - 1); i++) {
                        shouldSwitch = false;
                        x = rows[i].getElementsByTagName("TD")[n];
                        y = rows[i + 1].getElementsByTagName("TD")[n];

                        let xValue = x.innerHTML.toLowerCase();
                        let yValue = y.innerHTML.toLowerCase();

                        // Split the value by "_" and get both parts
                        let xParts = xValue.split('_');
                        let yParts = yValue.split('_');

                        // Compare the part before "_"
                        let xPrefix = xParts[0];
                        let yPrefix = yParts[0];

                        if (xPrefix === yPrefix) {
                            // If the prefixes are the same, compare the part after "_"
                            let xNumber = parseInt(xParts[1]) || 0;
                            let yNumber = parseInt(yParts[1]) || 0;

                            if (dir == "asc") {
                                if (xNumber > yNumber) {
                                    shouldSwitch = true;
                                    break;
                                }
                            } else if (dir == "desc") {
                                if (xNumber < yNumber) {
                                    shouldSwitch = true;
                                    break;
                                }
                            }
                        } else {
                            // If prefixes are different, compare them directly
                            if (dir == "asc") {
                                if (xPrefix > yPrefix) {
                                    shouldSwitch = true;
                                    break;
                                }
                            } else if (dir == "desc") {
                                if (xPrefix < yPrefix) {
                                    shouldSwitch = true;
                                    break;
                                }
                            }
                        }
                    }

                    if (shouldSwitch) {
                        rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                        switching = true;
                        switchcount++;
                    } else {
                        if (switchcount == 0 && dir == "asc") {
                            dir = "desc";
                            switching = true;
                        }
                    }
                }
            }

            // Search the table based on Product ID
            function searchTable() {
                let input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("searchInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("importTable");
                tr = table.getElementsByTagName("tr");

                for (i = 1; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[2]; // Assuming Product ID is the 3rd column
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }


            const itemsPerPage = 5; // Số sản phẩm trên mỗi trang
            const productBody = document.getElementById('productBody');
            const pagination = document.getElementById('pagination');


            function paginate(rows) {
                const totalPages = Math.ceil(rows.length / itemsPerPage);

                function showPage(page) {
                    const start = (page - 1) * itemsPerPage;
                    const end = start + itemsPerPage;

                    rows.forEach((row, index) => {
                        row.style.display = (index >= start && index < end) ? '' : 'none';
                    });
                }

                function createPagination() {
                    pagination.innerHTML = ''; // Xóa các nút cũ
                    for (let i = 1; i <= totalPages; i++) {
                        const pageLink = document.createElement('a');
                        pageLink.textContent = i;
                        pageLink.href = '#';
                        pageLink.onclick = (e) => {
                            e.preventDefault();
                            showPage(i);
                        };
                        pagination.appendChild(pageLink);
                    }
                }

                createPagination();
                showPage(1); // Hiển thị trang đầu tiên
            }

            function init() {
                allRows = Array.from(productBody.getElementsByTagName('tr'));
                paginate(allRows); // Phân trang tất cả sản phẩm
            }

            // Call paginate when the window is loaded
            window.onload = function () {
                paginate();
            };

            init();

        </script>
        <%@include file="dashboardHeader.jsp" %>
    </head>
    <body>

        <h1>Import History</h1>

        <!-- Search Box for Product ID -->
        <input type="text" id="searchInput" onkeyup="searchTable()" placeholder="Search for Product ID..." style="margin-bottom: 10px; padding: 10px; width: 200px; border: 1px solid #ccc; border-radius: 4px;">

        <table id="importTable">
            <thead>
                <tr>
                    <th onclick="sortTable(0, this.closest('table'))">Order ID <i class="fas fa-sort"></i></th>
                    <th>Provider</th>
                    <th onclick="sortTable(2, this.closest('table'))">Product ID <i class="fas fa-sort"></i></th>
                    <th>Base Unit ID</th>
                    <th>Batch No</th>
                    <th>Date Manufacture</th>
                    <th>Date Expired</th>
                    <th>Price Import</th>
                    <th>Importer</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="productBody">
                <!-- Iterate through the importList and display each import -->
                <c:forEach var="importData" items="${importList}">
                    <tr>
                        <td>${importData.orderId}</td>
                        <td>${importData.provider}</td>
                        <td>${importData.productId}</td>
                        <td>${importData.baseUnitId}</td>
                        <td>${importData.batchNo}</td>
                        <td>${importData.dateManufacture}</td>
                        <td>${importData.dateExpired}</td>
                        <td>${importData.priceImport}</td>
                        <td>${importData.importer}</td>
                        <td>${importData.quantity}</td>
                        <td>
                            <button type="button" onclick="window.location.href = 'ProductDetail?productID=${importData.productId}'" style="margin-right: 10px;">
                                <i class="fas fa-eye"></i>
                            </button>

                            <form action="importServlet" method="get" style="display:inline;">
                                <input type="hidden" name="productID" value="${importData.productId}">
                                <button type="submit" onclick="return confirm('Are you sure you want to import this product?');" style="margin-right: 10px;">
                                    <i class="fas fa-download"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>

        <!-- Pagination Controls -->
        <div id="pagination" style="margin-top: 10px; text-align: center;"></div>

    </body>
</html>
