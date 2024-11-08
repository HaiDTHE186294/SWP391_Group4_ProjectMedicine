<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

<%
    List<Product> products = (List<Product>) session.getAttribute("products");
%>
<%
Integer userRoleID = (Integer) session.getAttribute("userRoleID");
if (userRoleID == null || userRoleID != 3) {
    // Điều hướng về trang đăng nhập nếu roleID không hợp lệ
    response.sendRedirect("http://localhost:8080/MedicineShop/login");
    return; // Ngừng xử lý JSP
}
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management - Add Product</title>
        <style>

            label {
                margin-top: 20px; /* Điều chỉnh khoảng cách này theo nhu cầu */
                margin-bottom: 5px; /* Khoảng cách dưới label */
                display: block; /* Đảm bảo nhãn được hiển thị dưới dạng khối */
            }

            img.product-image {
                max-width: 100%; /* Đảm bảo hình ảnh không vượt quá chiều rộng của container */
            }
            textarea {
                width: 100%; /* Đặt độ rộng textarea bằng với độ rộng container */
                height: 150px; /* Chiều cao ban đầu */
                padding: 10px; /* Khoảng cách giữa văn bản và biên textarea */
                font-size: 14px; /* Cỡ chữ */
                border-radius: 4px; /* Bo tròn các góc */
                border: 1px solid #ccc; /* Đường viền */
                resize: vertical; /* Cho phép người dùng thay đổi chiều cao */
            }

            input[type="text"], input[type="number"], select, textarea {
                width: 100%; /* Ensures full width */
                padding: 8px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                width: 95%;
                margin: 0 auto; /* Căn giữa container */
                padding: 20px;
                overflow: visible;
            }
            .form-section {
                border: 1px solid #ccc;
                padding: 10px;
                margin-bottom: 20px;
            }
            input[type="text"], select, textarea {
                width: 100%;
                padding: 8px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .grid-container {
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 10px;
                text-align: left;
            }
            button {
                padding: 10px 20px;
                margin-top: 20px;
            }
            .ingredientRow, .unitRow {
                display: flex;
                gap: 10px;
                margin-bottom: 10px;
            }
            .ingredientInput, .unitInput {
                width: 30%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            .remove-btn {
                background-color: red;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                padding: 5px;
            }
        </style>
        <script>
            const existingProductIds = [
            <% for (Product product : products) { %>
            '<%= product.getProductID() %>',
            <% } %>
            ];
            // Function to check for duplicate product IDs
            function checkDuplicateProductId() {
            const productIdInput = document.getElementById("productId").value;
            if (existingProductIds.includes(productIdInput)) {
            alert("The Product ID already exists. Please use a unique ID.");
            return false; // Prevent form submission
            }
            return true; // Allow form submission
            }

            // Function to prevent negative numbers in quantity and packaging inputs
            function preventNegativeNumbers() {
            const quantityInputs = document.querySelectorAll('input[name="InQuantity[]"], input[name="packagingDetails[]"]');
            quantityInputs.forEach(input => {
            input.addEventListener('input', function () {
            const positiveIntegerRegex = /^[1-9]\d*$/; // Matches integers 1 and above
            if (this.value === '' || positiveIntegerRegex.test(this.value)) {
            return; // Valid input, do nothing
            } else {
            alert("Please enter a positive integer.");
            this.value = ''; // Reset the value
            }
            });
            });
            }

            // Function to check for duplicate units
            function checkDuplicateUnits() {
            const unitSelects = document.querySelectorAll('select[name="unit[]"]');
            const unitValues = [];
            for (let select of unitSelects) {
            const value = select.value;
            if (value) { // Only consider non-empty values
            const selectedOption = Array.from(select.options).find(option => option.value === value);
            const unitName = selectedOption ? selectedOption.text : ''; // Get the name or set to empty if not found

            if (unitValues.includes(value)) {
            alert("Duplicate unit found: " + unitName); // Show unit name
            return false; // Duplicate found
            }
            unitValues.push(value);
            }
            }
            return true; // No duplicates found
            }

            // Function to check packaging details
            function checkPackagingDetails() {
            const packagingInputs = document.querySelectorAll('input[name="packagingDetails[]"]');
            let countOne = 0; // Count of packaging details with value "1"
            const nonNumericRegex = /[^0-9]/; // Regex to check for non-numeric characters

            for (let input of packagingInputs) {
            if (!input.value.trim()) { // Check for empty packaging detail
            alert("All packaging details must be filled out.");
            return false; // Prevent form submission
            }

            // Check for non-numeric characters
            if (nonNumericRegex.test(input.value)) {
            alert("Packaging details must contain only numeric values.");
            return false; // Prevent form submission
            }

            // Count how many have the value "1"
            if (input.value.trim() === "1") {
            countOne++;
            }
            }

            if (countOne !== 1) { // Check if there's exactly one "1"
            alert("There must be exactly one packaging detail with a value of '1'.");
            return false; // Prevent form submission
            }

            return true; // All packaging details are valid
            }



            // Form validation before submission
            function validateForm() {
            return checkDuplicateProductId() && checkDuplicateUnits() && checkPackagingDetails() && validateNullInput(); // Call all check functions
            }

            // Function to add ingredient row
            function addIngredientRow() {
            const container = document.getElementById('ingredientContainer');
            const newRow = document.createElement('div');
            newRow.className = 'ingredientRow';
            newRow.innerHTML = `
            <input type="text" name="ingredientName[]" placeholder="Ingredient Name *" class="ingredientInput" required maxlength="50">
            <input type="text" name="InUnit[]" placeholder="Unit *" class="ingredientInput" required maxlength="20">
            <input type="number" name="InQuantity[]" min="1" placeholder="Quantity *" class="ingredientInput" required>
            <button type="button" onclick="removeIngredientRow(this)">Remove</button> <!-- Remove button -->
        `;
            container.appendChild(newRow);
            }

            // Function to check if the packaging detail is "1" and show/hide the Based Unit message
            function checkBasedUnit(input) {
            const messageSpan = input.nextElementSibling; // Get the next sibling span
            if (input.value.trim() === "1") {
            messageSpan.style.display = "inline"; // Show the message
            } else {
            messageSpan.style.display = "none"; // Hide the message
            }
            }

            function addUnitRow() {
            const table = document.getElementById("unitTable");
            // Validate packaging details before adding a new row
            if (!checkPackagingDetails()) {
            return; // Prevent adding if validation fails
            }

            const row = table.insertRow( - 1);
            // Clone the select options from the hidden template
            const unitOptions = document.getElementById("unitOptions").cloneNode(true);
            unitOptions.style.display = "block";
            unitOptions.name = "unit[]"; // Ensure the name attribute is added for form submission

            // Create a new row with the dropdown and input field for packaging details
            row.innerHTML = `
                <td></td> <!-- Empty cell for the unit dropdown -->
                <td>
                    <input type="text" name="packagingDetails[]" placeholder="Packaging details *" oninput="checkBasedUnit(this)" required>
                    <span class="based-unit-message" style="display: none; color: green;">Based Unit</span>
                </td>
                <td>
                    <select name="unitStatus[]">
                        <option value="1">Available</option>
                        <option value="0">Unavailable</option>
                        <option value="2">OutOfStock</option>
                    </select>
                </td>
                <td>
                    <input type="number" min="0" name="salePrice[]" placeholder="Sale Price - VND">
                </td>
                <td>
                    <button type="button" onclick="removeUnitRow(this)">Remove</button> <!-- Remove button -->
                </td>
            `;

                // Append the dropdown into the first cell of the new row
                row.cells[0].appendChild(unitOptions);
            }

            function removeIngredientRow(button) {
                const row = button.parentElement; // Lấy phần tử dòng cha của nút "Remove"
                row.remove(); // Xoá dòng nguyên liệu cụ thể
            }
            
            function updateTargetAudience() {
                const checkboxes = document.querySelectorAll('input[name="targetAudience"]:checked');
                const values = Array.from(checkboxes).map(cb => cb.value);
                document.getElementById('targetAudienceInput').value = values.join(',');
            }

// Function to remove a unit row
            function removeUnitRow(button) {
                const row = button.parentElement.parentElement; // Get the row
                row.remove(); // Remove the row from the DOM
            }

            // Call the function on page load
            window.onload = function () {
                preventNegativeNumbers();
            };

            $(document).ready(function () {
                $('#brandOrigin').select2({
                    placeholder: "Select Country",
                    allowClear: true
                });
                $('#countryOfProduction').select2({
                    placeholder: "Select Country",
                    allowClear: true
                });
                $('#categoryDropdown').select2({
                    placeholder: "Select Category",
                    allowClear: true
                });
            });
            
            function validateNullInput() {
                const form = document.forms[0];
                const requiredFields = form.querySelectorAll('input[required], select[required]');

                for (const field of requiredFields) {
                    // Trim whitespace and check if the input is empty
                    if (field.value.trim() === "") {
                        alert("Vui lòng điền thông tin hợp lệ vào tất cả các trường bắt buộc.");
                        field.focus();
                        return false; // Prevent form submission
                    }
                }
                return true; 
            }

        </script>
        <%@ include file="dashboardHeader.jsp" %>


    </head>
    <body>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>

        <div class="container">
            <h1>Add Product Information</h1>
            <span>
                <c:if test="${noti != null}">
                    ${noti}
                </c:if>
            </span>
            <form action="addxx" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                <div class="grid-container">
                    <!-- Left Section -->
                    <div>
                        <label for="productId">ID - Unique *</label>
                        <input type="text" id="productId" name="productId" required maxlength="8" 
                               pattern="^P[A-Za-z0-9]{1,14}$" 
                               title="Product ID must start with 'P' followed by up to 14 alphanumeric characters">


                        <label for="targetAudience">Target Audience *</label>
                        <div id="targetAudience" style="display: grid; grid-template-columns: repeat(auto-fill, minmax(200px, 1fr)); gap: 5px;">
                            <c:forEach var="audience" items="${sessionScope.audiences}">
                                <label>
                                    <input type="checkbox" class="targetAudienceCheckbox" value="${audience}" onchange="updateTargetAudience()">
                                    ${audience}
                                </label>
                            </c:forEach>
                        </div>
                        <input type="hidden" id="targetAudienceInput" name="targetAudience" value="">

                        <script>
                            function updateTargetAudience() {
                                const checkboxes = document.querySelectorAll('.targetAudienceCheckbox:checked'); // Sử dụng class để chọn tất cả checkbox
                                const values = Array.from(checkboxes).map(cb => cb.value);
                                document.getElementById('targetAudienceInput').value = values.join(', '); // Nối các giá trị bằng dấu phẩy
                            }
                        </script>



                        <label for="brand">Brand *</label>
                        <input type="text" id="brand" name="brand" required maxlength="50">

                        <label for="productName">Product Name *</label>
                        <input type="text" id="productName" name="productName" required maxlength="1000">


                        <label for="shortDescription">Product Uses</label>
                        <textarea id="shortDescription" name="shortDescription">Do not bold text</textarea>

                        <label for="faq">Another details</label>
                        <textarea id="faq" name="faq">Do not bold text (How to use + Side effects + Notes + Storage)</textarea>

                        <label for="description">Product Description</label>
                        <textarea id="description" name="description">Do not bold text</textarea>
                    </div>

                    <!-- Right Section -->
                    <div>
                        <label for="pharmaceuticalForm">Pharmaceutical Form *</label>
                        <input type="text" id="pharmaceuticalForm" name="pharmaceuticalForm" required maxlength="50">

                        <label for="brandOrigin">Brand Origin *</label>
                        <select id="brandOrigin" name="brandOrigin" style="width: 100%;" required>
                            <option value=""></option> <!-- Placeholder -->
                            <c:forEach var="country" items="${sessionScope.countries}">
                                <option value="${country}">${country}</option>
                            </c:forEach>
                        </select>


                        <label for="manufacturer">Manufacturer</label>
                        <input type="text" id="manufacturer" name="manufacturer" maxlength="1000">

                        <label for="countryOfProduction">Country of Production *</label>
                        <select id="countryOfProduction" name="countryOfProduction" style="width: 100%;" required>
                            <option value=""></option> <!-- Placeholder -->
                            <c:forEach var="country" items="${sessionScope.countries}">
                                <option value="${country}">${country}</option>
                            </c:forEach>
                        </select>

                        <label for="registrationNumber">Registration Number *</label>
                        <input type="text" id="registrationNumber" name="registrationNumber" required maxlength="50">

                        <label for="status">Adding request will be reviewed by admin</label>
                        <select id="status" name="status" required>
                            <!--                            <option value="1">Active</option>
                                                        <option value="0">Inactive</option>-->
                            <option value="3">Pending</option>
                            <!--                            <option value="4">Discontinued</option>
                                                        <option value="2">Out of stock</option>-->
                        </select>

                        <label for="prescriptionRequired">Prescription Required *</label>
                        <select id="prescriptionRequired" name="prescriptionRequired" required >
                            <option value="yes">Yes</option>
                            <option value="no">No</option>
                        </select>

                        <label for="categoryDropdown">Category *</label>
                        <select id="categoryDropdown" name="categoryId" style="width: 100%;" required>
                            <option value=""></option> <!-- Placeholder -->
                            <c:forEach var="category" items="${sessionScope.categories}">
                                <option value="${category.categoryID}">${category.categoryName}</option>
                            </c:forEach>
                        </select>

                        <label for="ing">Ingredient per Unit *</label>
                        <input type="text" id="ing" name="ing" placeholder="Unit *" required maxlength="100">

                        <label for="imageUpload" >Upload Image *</label>
                        <input type="file" id="imageUpload" name="imageUpload" accept="image/*" onchange="previewImage(this)" required maxlength="100">

                        <!-- Thẻ img để hiển thị hình ảnh đã chọn -->
                        <img id="imagePreview" src="#" alt="Preview Image" style="max-width: 200px; display: none; margin-top: 10px;">

                        <script>
                            // Hàm để hiển thị ảnh người dùng chọn
                            function previewImage(input) {
                                const preview = document.getElementById('imagePreview');
                                if (input.files && input.files[0]) {
                                    const reader = new FileReader();
                                    reader.onload = function (e) {
                                        preview.src = e.target.result;
                                        preview.style.display = 'block'; // Hiển thị thẻ img
                                    }
                                    reader.readAsDataURL(input.files[0]);
                                } else {
                                    preview.style.display = 'none'; // Ẩn thẻ img nếu không có file được chọn
                                }
                            }
                        </script>
                    </div>
                </div>

                <!-- Ingredient Section -->
                <div class="form-section">
                    <h3>Ingredients</h3>
                    <div id="ingredientContainer">
                        <div class="ingredientRow">
                            <input type="text" name="ingredientName[]" placeholder="Ingredient Name *" class="ingredientInput" required maxlength="50">
                            <input type="text" name="InUnit[]" placeholder="Unit *" class="ingredientInput" required maxlength="20">
                            <input type="number" min="1" name="InQuantity[]" placeholder="Quantity *" class="ingredientInput" required>
                        </div>
                    </div>
                    <button type="button" onclick="addIngredientRow()">+</button>
                </div>

                <!-- Unit Section -->
                <div class="form-section">
                    <h3>Unit and Packaging Details</h3>
                    <table id="unitTable">
                        <tr>
                            <th>Unit</th>
                            <th>Packaging Quantity Details</th>
                            <th>Unit Status</th>
                            <th>Sale Price by VND</th>
                        </tr>
                        <tr>
                            <td>
                                <select name="unit[]">
                                    <c:forEach var="unit" items="${sessionScope.units}">
                                        <option value="${unit.unitID}">${unit.unitName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td>
                                <input type="text" name="packagingDetails[]" placeholder="Packaging details *" oninput="checkBasedUnit(this)">
                                <span class="based-unit-message" style="display: none; color: green;">Based Unit</span>
                            </td>
                            <td>
                                <select name="unitStatus[]">
                                    <option value="1">Available</option>
                                    <option value="0">Unavailable</option>
                                </select>
                            </td>
                            <td>
                                <input type="number" min="0" name="salePrice[]" placeholder="Sale Price - VND">
                            </td>
                        </tr>
                    </table>
                    <button type="button" onclick="addUnitRow()">+</button>
                </div>

                <!-- Hidden select template for dynamically added rows -->
                <select id="unitOptions" style="display: none;">
                    <c:forEach var="unit" items="${sessionScope.units}">
                        <option value="${unit.unitID}">${unit.unitName}</option>
                    </c:forEach>
                </select>

                <div>
                    <p>All fields must be filled in correctly.</p>
                    <input type="radio" id="confirm" name="confirmation" required>
                    <label for="confirm">Confirm add information</label>
                </div>

                <button type="submit">OK</button>
                <button type="reset">Cancel</button>
            </form>
        </div>
    </body>
</html>
