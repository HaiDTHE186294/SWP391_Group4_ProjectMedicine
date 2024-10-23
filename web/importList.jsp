<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductPriceQuantity" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map" %>
<html>
    <head>
        <title>Import List</title>
        <link rel="stylesheet" href="path/to/your/styles.css"> <!-- Đường dẫn đến tệp CSS nếu có -->
        <%@include file="dashboardHeader.jsp" %>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa; /* Màu nền sáng */
                margin: 0;
                padding: 20px;
            }
            h1 {
                text-align: center;
                color: #333; /* Màu chữ tối */
            }
            form {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                max-width: 100%;
                margin: auto;
            }
            label {
                font-weight: bold;
                margin-bottom: 10px;
                display: block;
            }
            select, input[type="text"], input[type="date"], input[type="number"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin-bottom: 20px;
                border: 1px solid #ccc; /* Màu viền xám */
                border-radius: 4px;
                transition: border-color 0.3s; /* Hiệu ứng chuyển màu viền */
            }
            select:focus, input[type="text"]:focus, input[type="date"]:focus, input[type="number"]:focus {
                border-color: #007bff; /* Màu viền khi focus */
                outline: none; /* Bỏ outline */
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border: 1px solid #ddd; /* Màu viền bảng */
            }
            th {
                background-color: #343a40; /* Màu nền tối cho tiêu đề bảng */
                color: white; /* Màu chữ trắng */
            }
            tr:nth-child(even) {
                background-color: #f2f2f2; /* Màu nền cho hàng chẵn */
            }
            tr:hover {
                background-color: #e9ecef; /* Màu nền khi hover */
            }
            button {
                background-color: #343a40; /* Màu nền cho nút */
                color: white; /* Màu chữ trắng */
                padding: 10px 15px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin-top: 10px;
                float: bottom; /* Nút submit nằm bên phải */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền */
            }
            button:hover {
                background-color: #0056b3; /* Màu nền khi hover */

            }
        </style>
        <script>
            function validateDates() {
                const form = document.forms[0];
                const today = new Date();
                const minProductionDate = new Date(today);
                minProductionDate.setDate(today.getDate() - 2); // Ngày sản xuất không được gần quá 2 ngày trước

                const maxExpirationDate = new Date(today);
                maxExpirationDate.setDate(today.getDate() + 3); // Ngày hết hạn không được gần quá 3 ngày tới

                const dateManufactureInputs = form.querySelectorAll('input[name="dateManufacture[]"]');
                const dateExpiredInputs = form.querySelectorAll('input[name="dateExpired[]"]');

                for (let i = 0; i < dateManufactureInputs.length; i++) {
                    const manufactureDate = new Date(dateManufactureInputs[i].value);
                    const expirationDate = new Date(dateExpiredInputs[i].value);

                    // Kiểm tra ngày sản xuất không được gần quá 2 ngày trước
                    if (manufactureDate > minProductionDate) {
                        alert("Ngày sản xuất không được gần quá 2 ngày trước ngày hôm nay.");
                        return false;
                    }

                    // Kiểm tra ngày hết hạn không được gần quá 3 ngày tới
                    if (expirationDate < maxExpirationDate) {
                        alert("Ngày hết hạn không được gần quá 3 ngày tới.");
                        return false;
                    }

                    // Kiểm tra ngày sản xuất không được nhập sau ngày hết hạn
                    if (manufactureDate >= expirationDate) {
                        alert("Ngày sản xuất không được nhập sau ngày hết hạn.");
                        return false;
                    }
                }

                return true; // Tất cả kiểm tra đều hợp lệ
            }



        </script>
    </head>
    <body>
        <h1>Import List</h1>
        <form action="ImportList" method="post" onsubmit="return validateDates();"> <!-- Thay đổi yourActionURL theo yêu cầu -->

            <!-- Dropdown cho nhà cung cấp -->
            <label for="providerSelect">Chọn Nhà Cung Cấp *:</label>
            <select name="providerId" id="providerSelect" required>
                <option value="">-- Chọn Nhà Cung Cấp --</option>
                <c:forEach var="provider" items="${providerList}">
                    <option value="${provider.providerID}">${provider.providerName}</option>
                </c:forEach>
            </select>
            <table border="1">
                <thead>
                    <tr>
                        <th>Tên sản phẩm</th>
                        <th>ID sản phẩm</th>
                        <th>Đơn vị cơ bản </th>
                        <th>Số lô</th>
                        <th>Ngày sản xuất</th>
                        <th>Ngày hết hạn</th>
                        <th>Giá Bán</th>
                        <th>Giá Nhập</th>
                        <th>Số lượng nhập</th>
                    </tr>
                </thead>

                <tbody>
                    <%
                        List<Product> productList = (List<Product>) request.getAttribute("productList");
                        List<ProductPriceQuantity> productPriceQuantityList = (List<ProductPriceQuantity>) request.getAttribute("productPriceQuantityList");
                    %>
                    <%
                        // Duyệt qua từng sản phẩm trong productList
                        for (int i = 0; i < productList.size(); i++) {
                            Product product = productList.get(i);
                            ProductPriceQuantity ppq = productPriceQuantityList.get(i); // Lấy giá nhập tương ứng
                    %>
                    <tr>
                        <td>
                            <input type="hidden" name="productName[]" value="<%= product.getProductName() %>"/>
                            <%= product.getProductName() %>
                        </td>
                        <td>
                            <input type="hidden" name="productId[]" value="<%= product.getProductID() %>"/>
                            <%= product.getProductID() %>
                        </td>
                        <%
                        Map<String, String> unitMap = (Map<String, String>) request.getAttribute("unitMap");
                        %>
                        <td>
                            <input type="hidden" name="baseUnitId[]" value="<%= ppq.getUnitID() %>" required />
                                <%= unitMap.get(ppq.getUnitID()) != null ? unitMap.get(ppq.getUnitID()) : "Unknown Unit" %>
                        </td>
                        <td>
                            <input type="text" name="batchNo[]" required /> <!-- Thay đổi ở đây -->
                        </td>
                        <td>
                            <input type="date" name="dateManufacture[]" required /> <!-- Thay đổi ở đây -->
                        </td>
                        <td>
                            <input type="date" name="dateExpired[]" required /> <!-- Thay đổi ở đây -->
                        </td>
                        <td>
                            <input type="number" name="priceSale[]" required 
                                   value="<%= ppq.getSalePrice() %>" />
                        </td>
                        <td>
                            <input type="number" name="priceImport[]" required />
                        </td>
                        <td>
                            <input type="number" name="quantity[]" required /> <!-- Thay đổi ở đây -->
                        </td>
                    </tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
            <button type="submit">Submit</button>
        </form>
    </body>
</html>
