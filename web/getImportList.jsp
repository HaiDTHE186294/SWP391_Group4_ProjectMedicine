<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Danh sách ProductID</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 0;
            }
            h1 {
                color: #333;
                text-align: center;
            }
            .search-container {
                display: flex;
                justify-content: center;
                margin-bottom: 20px;
            }
            .search-container input[type="text"] {
                padding: 10px;
                font-size: 16px;
                border: 1px solid #ddd;
                border-radius: 4px;
                width: 300px;
                margin-right: 10px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd;
            }
            th {
                background-color: #343a40;
                color: white;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            .submit-btn {
                margin-top: 20px;
                padding: 12px 20px;
                background-color: #343a40;
                color: white;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                font-size: 16px;
                width: 250px;
                margin-left: auto;
                margin-right: auto;
                display: block;
                transition: background-color 0.3s;
            }
            .submit-btn:hover {
                background-color: #0056b3;
            }
        </style>
        <%@include file="dashboardHeader.jsp" %>
    </head>
    <body>
        <%
    // Get roleID from session
    Integer roleID = (Integer) session.getAttribute("userRoleID");

    // Check if roleID is not 2
    if (roleID == null || roleID != 3) {
        // Get the previous page URL from the referer header
        String referer = request.getHeader("referer");
        %>
        <script>
            alert("You do not have permission to access this page.");
            window.location.href = "<%= (referer != null) ? referer : "http://localhost:8080/MedicineShop/home" %>";
        </script>
        <%
                return;
            }
        %>
        <h1>Import Product</h1>
        <div class="search-container">
            <input type="text" id="searchInput" placeholder="Search by ProductID or Name" onkeyup="searchTable()">
        </div>

        <form action="ImportList" method="get">
            <table id="productTable">
                <thead>
                    <tr>
                        <th>Select</th>
                        <th>ProductID</th>
                        <th>Product Name</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="product" items="${productList}">
                        <tr>
                            <td>
                                <input type="checkbox" name="selectedProductIDs" value="${product.productID}">
                            </td>
                            <td class="product-id">${product.productID}</td>
                            <td class="product-name">${product.productName}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <input type="submit" class="submit-btn" value="Import selected">
        </form>

        <script>
            function searchTable() {
                // Get the input field value and trim whitespace
                var input = document.getElementById("searchInput");
                var filter = input.value.toLowerCase().trim(); // Trim and convert to lowercase

                // Get the table and all rows
                var table = document.getElementById("productTable");
                var tr = table.getElementsByTagName("tr");

                // Loop through all rows, skipping the header row
                for (var i = 1; i < tr.length; i++) {
                    var productId = tr[i].getElementsByClassName("product-id")[0];
                    var productName = tr[i].getElementsByClassName("product-name")[0];

                    if (productId || productName) {
                        var idText = productId.textContent || productId.innerText;
                        var nameText = productName.textContent || productName.innerText;

                        // Check if the row matches the trimmed search query
                        if (idText.toLowerCase().indexOf(filter) > -1 || nameText.toLowerCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }
            }

        </script>
    </body>
</html>
