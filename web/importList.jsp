<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="model.ProductPriceQuantity" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Import List</title>
    <link rel="stylesheet" href="path/to/your/styles.css">
    <%@include file="dashboardHeader.jsp" %>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            margin: 0;
            padding: 0;
        }
        h1 {
            text-align: center;
            color: #333;
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
            border: 1px solid #ccc;
            border-radius: 4px;
            transition: border-color 0.3s;
        }
        select:focus, input[type="text"]:focus, input[type="date"]:focus, input[type="number"]:focus {
            border-color: #007bff;
            outline: none;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
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
        tr:nth-child(even) {
            background-color: #f2f2f2;
        }
        tr:hover {
            background-color: #e9ecef;
        }
        button {
            background-color: #343a40;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
            float: right;
            transition: background-color 0.3s;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
    <script>
        function validateDates() {
            const form = document.forms[0];
            const today = new Date();
            const minProductionDate = new Date(today);
            minProductionDate.setDate(today.getDate() - 2);

            const maxExpirationDate = new Date(today);
            maxExpirationDate.setDate(today.getDate() + 3);

            const dateManufactureInputs = form.querySelectorAll('input[name="dateManufacture[]"]');
            const dateExpiredInputs = form.querySelectorAll('input[name="dateExpired[]"]');
            for (let i = 0; i < dateManufactureInputs.length; i++) {
                const manufactureDate = new Date(dateManufactureInputs[i].value);
                const expirationDate = new Date(dateExpiredInputs[i].value);

                if (manufactureDate > minProductionDate) {
                    alert("Ngày sản xuất không được gần quá 2 ngày trước ngày hôm nay.");
                    return false;
                }

                if (expirationDate < maxExpirationDate) {
                    alert("Ngày hết hạn không được gần quá 3 ngày tới.");
                    return false;
                }

                if (manufactureDate >= expirationDate) {
                    alert("Ngày sản xuất không được nhập sau ngày hết hạn.");
                    return false;
                }
            }

            return true;
        }

        <% List<Stock> stocks = (List<Stock>) request.getAttribute("stocks"); %>
        const stocks = [
        <%
        if (stocks != null) {
            for (int i = 0; i < stocks.size(); i++) {
                Stock stock = stocks.get(i);
        %> {
                productId: "<%= stock.getProductId().trim() %>",
                batchNo: "<%= stock.getBatchNo().trim() %>",
                dateManufacture: "<%= stock.getDateManufacture() != null ? stock.getDateManufacture().toString() : "" %>",
                dateExpired: "<%= stock.getDateExpired() != null ? stock.getDateExpired().toString() : "" %>"
            }<%= (i < stocks.size() - 1) ? "," : "" %>
        <%
            }
        }
        %>
        ];

        function checkStockExistence(input) {
            const batchNo = input.value.trim();
            const productId = input.getAttribute('data-product-id');
            const dateManufactureInput = input.closest('tr').querySelector('input[name="dateManufacture[]"]');
            const dateExpiredInput = input.closest('tr').querySelector('input[name="dateExpired[]"]');
            console.log('Checking stock for:', { productId, batchNo });
            
            if (!batchNo) return; // Do nothing if batch number is empty

            const stock = stocks.find(stock => stock.productId === productId && stock.batchNo === batchNo);
            console.log('Stock found:', stock);
            if (stock) {
                dateManufactureInput.value = stock.dateManufacture; // Set production date
                dateExpiredInput.value = stock.dateExpired; // Set expiration date
                input.style.borderColor = "green"; // Change border color to indicate success
                document.getElementById('statusMessage').innerText = "Số lô đã tồn tại trong kho."; // Show message
            } else {
                dateManufactureInput.value = ""; // Clear if not found
                dateExpiredInput.value = ""; // Clear if not found
                input.style.borderColor = "red"; // Change border color to indicate error
                document.getElementById('statusMessage').innerText = "Số lô chưa tồn tại trong kho."; // Show message
            }
        }
        
        function validateNullInput() {
                const form = document.forms[0];
                const requiredFields = form.querySelectorAll('input[required], select[required]');

                for (const field of requiredFields) {
                    // Trim whitespace and check if the input is empty
                    if (field.value.trim() === "") {
                        alert("Vui lòng điền thông tin hợp lệ vào tất cả các trường bắt buộc.");
                        field.focus();
                        confirmCheckbox.checked = false;
                        return false; // Prevent form submission
                    }
                }
                return validateDates(); // Call date validation as well
            }
            
            function validateForm() {
            return validateNullInput(); // Call all check functions
            }
    </script>
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
    <h1>Import List</h1>
    <form action="ImportList" method="post" onsubmit="return validateDates();">
        <label for="providerSelect">Chọn Nhà Cung Cấp *:</label>
        <select name="providerId" id="providerSelect" required>
            <option value="">-- Chọn Nhà Cung Cấp --</option>
            <c:forEach var="provider" items="${providerList}">
                <option value="${provider.providerID}">${provider.providerName}</option>
            </c:forEach>
        </select>
        
        <div id="statusMessage" style="color: red;"></div> <!-- Status message area -->

        <table border="1">
            <thead>
                <tr>
                    <th>Tên sản phẩm</th>
                    <th>ID sản phẩm</th>
                    <th>Đơn vị cơ bản</th>
                    <th>Số lô *</th>
                    <th>Ngày sản xuất *</th>
                    <th>Ngày hết hạn *</th>
                    <th>Ngày Nhập hàng *</th>
                    <th>Giá Nhập - VND *</th>
                    <th>Số lượng nhập *</th>
                </tr>
            </thead>
            <tbody>
                <%
                    List<Product> productList = (List<Product>) request.getAttribute("productList");
                    List<ProductPriceQuantity> productPriceQuantityList = (List<ProductPriceQuantity>) request.getAttribute("productPriceQuantityList");
                    
                    for (int i = 0; i < productList.size(); i++) {
                        Product product = productList.get(i);
                        ProductPriceQuantity ppq = productPriceQuantityList.get(i);
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
                        <input type="text" name="batchNo[]" required data-product-id="<%= product.getProductID() %>" 
                               onchange="checkStockExistence(this)" />
                    </td>
                    <td>
                        <input type="date" name="dateManufacture[]" required />
                    </td>
                    <td>
                        <input type="date" name="dateExpired[]" required />
                    </td>
                    <td>
                        <input type="date" name="dateImport[]" />
                    </td>

                        <input type="hidden" name="priceSale[]" value="<%= ppq.getSalePrice() %>" />

                    <td>
                        <input type="number" name="priceImport[]" required />
                    </td>
                    <td>
                        <input type="number" name="quantity[]" required />
                    </td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
            <label>
                <input type="checkbox" id="confirmCheckbox" required onclick="validateNullInput()">
                Confirm
            </label>
            <button type="submit" onclick="validateNullInput()">Submit</button>
    </form>
</body>
</html>
