<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Category" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management - Update Product</title>
        <style>
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
                width: 100%;
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
            // Function to check and display the Based Unit message on page load
            function checkBasedUnitOnLoad() {
                const packagingInputs = document.querySelectorAll('input[name="packagingDetails[]"]');
                packagingInputs.forEach(input => {
                    const messageSpan = input.nextElementSibling; // Get the next sibling span (Based Unit message)
                    if (input.value.trim() === "1") {
                        messageSpan.style.display = "inline"; // Show the message
                    } else {
                        messageSpan.style.display = "none"; // Hide the message
                    }
                });
            }

            // Run the function when the page loads
            window.onload = function () {
                checkBasedUnitOnLoad();
            };
            // Function to check if the packaging detail is "1" and show/hide the Based Unit message
            function checkBasedUnit(input) {
                const messageSpan = input.nextElementSibling; // Get the next sibling span
                if (input.value.trim() === "1") {
                    messageSpan.style.display = "inline"; // Show the message
                } else {
                    messageSpan.style.display = "none"; // Hide the message
                }
            }
            // Hàm để hiển thị ảnh người dùng chọn
            function previewImage(input) {
                const preview = document.getElementById('imagePreview');
                if (input.files && input.files[0]) {
                    const reader = new FileReader();
                    reader.onload = function (e) {
                        preview.src = e.target.result;
                    }
                    reader.readAsDataURL(input.files[0]);
                } else {
                    // If no new image is selected, set preview to the current image
                    preview.src = "${product.imagePath}";

                    // Update a hidden input to carry the current image path
                    document.querySelector("input[name='imagePath']").value = "${product.imagePath}";
                }
            }

            function addIngredientRow() {
                const container = document.getElementById('ingredientContainer');
                const newRow = document.createElement('div');
                newRow.className = 'ingredientRow';
                newRow.innerHTML = `
                    <input type="text" name="ingredientName[]" placeholder="Ingredient Name *" class="ingredientInput" required>
                    <input type="text" name="InUnit[]" placeholder="Unit *" class="ingredientInput" required>
                    <input type="number" name="InQuantity[]" min="1" placeholder="Quantity *" class="ingredientInput" required>
                    <button type="button" class="remove-btn" onclick="removeRow1(this)">Remove</button>
                `;
                container.appendChild(newRow);
            }


            function addUnitRow() {
                const table = document.getElementById("unitTable");
                const row = table.insertRow(-1); // Thêm hàng mới vào cuối bảng

                // Tạo các ô (td) cho hàng mới
                const cell1 = row.insertCell(0);
                const cell2 = row.insertCell(1);
                const cell3 = row.insertCell(2);
                const cell4 = row.insertCell(3); // Ô thứ 4 cho Sale Price

                // Validate packaging details trước khi thêm hàng mới
                if (!checkPackagingDetails()) {
                    return; // Dừng thêm nếu không hợp lệ
                }

                // Cell 1: Unit Dropdown và nút Remove
                cell1.innerHTML = `
        <select name="unit[]">
            <c:forEach var="unit" items="${units}">
                <option value="${unit.unitID}">${unit.unitName}</option>
            </c:forEach>
        </select>
        <button type="button" class="remove-btn" onclick="removeRow(this)">Remove</button>
    `;

                // Cell 2: Packaging Details Input
                cell2.innerHTML = `
        <input type="number" name="packagingDetails[]" placeholder="Packaging details *" oninput="checkBasedUnit(this)" required>
        <span class="based-unit-message" style="display: none; color: green;">Based Unit</span>
    `;

                // Cell 3: Unit Status Dropdown
                cell3.innerHTML = `
        <select name="unitStatus[]" required>
            <option value="1">Available</option>
            <option value="0">Unavailable</option>
            <option value="2">Out of stock</option>
        </select>
    `;

                // Cell 4: Sale Price Input
                cell4.innerHTML = `
        <input type="number" min="0" name="salePrice[]" placeholder="Sale Price - VND *" required>
    `;
            }



            function removeRow(button) {
                const row = button.closest('.ingredientRow') || button.closest('tr');
                if (row) {
                    row.remove();
                }
            }

            function removeRow1(button) {
                const container = document.getElementById('ingredientContainer');
                const rows = container.getElementsByClassName('ingredientRow');

                // Kiểm tra nếu chỉ còn lại 1 dòng thành phần
                if (rows.length > 1) {
                    const row = button.closest('.ingredientRow');
                    if (row) {
                        row.remove();
                    }
                } else {
                    alert("You must have at least one ingredient.");
                }
            }


            function confirmSubmission() {
                return confirm("Are you sure you want to update this product?");
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
                const imageUpload = document.getElementById('imageUpload');
                const imagePathInput = document.querySelector("input[name='currentImagePath']"); // Ensure you're using the correct name

                // If the file input is empty, set the image path to the current value
                if (!imageUpload.files.length) {
                    imagePathInput.value = "${product.imagePath}"; // Set the current image path
                }

                // Call all other check functions for validation
                return checkDuplicateUnits() && checkPackagingDetails(); // Ensure other checks are also valid
            }



        </script>
    </head>
    <body>
        <div class="container">
            <h1>Update Product Information</h1>
            <form action="Update" method="post" enctype="multipart/form-data" onsubmit="return validateForm();">
                <div class="grid-container">
                    <div>
                        <label for="productId" class="required">ID - Unique</label>
                        <input type="text" id="productId" name="productId" value="${product.productID}" readonly required>

                        <label for="targetAudience">Target Audience</label>
                        <input type="text" id="targetAudience" name="targetAudience" value="${product.targetAudience}">

                        <label for="brand">Brand</label>
                        <input type="text" id="brand" name="brand" value="${product.brand}">

                        <label for="productName" class="required">Product Name</label>
                        <input type="text" id="productName" name="productName" value="${product.productName}" required>

                        <label for="imageUpload" class="required">Upload Image *</label>
                        <input type="file" id="imageUpload" name="imageUpload" accept="image/*" onchange="previewImage(this)" required="">

                        <label for="currentImagePath" style="display: none;">Current Image Path</label>
                        <!-- Hidden input to retain the current image path -->
                        <input type="hidden" name="currentImagePath" value="${product.imagePath}">


                        <img id="imagePreview" class="product-image" src="${product.imagePath}" alt="Product Image" style="max-width: 200px; display: block; margin-top: 10px;">


                        <label for="shortDescription">Short Description</label>
                        <textarea id="shortDescription" name="shortDescription">${product.shortDescription}</textarea>

                        <label for="faq">FAQ</label>
                        <textarea id="faq" name="faq">${product.faq}</textarea>

                        <label for="description" class="required">Description</label>
                        <textarea id="productDescription" name="description">${product.productDescription}</textarea>
                    </div>

                    <div>
                        <label for="pharmaceuticalForm">Pharmaceutical Form</label>
                        <input type="text" id="pharmaceuticalForm" name="pharmaceuticalForm" value="${product.pharmaceuticalForm}">

                        <label for="brandOrigin">Brand Origin</label>
                        <input type="text" id="brandOrigin" name="brandOrigin" value="${product.brandOrigin}">

                        <label for="manufacturer">Manufacturer</label>
                        <input type="text" id="manufacturer" name="manufacturer" value="${product.manufacturer}">

                        <label for="countryOfProduction">Country of Production</label>
                        <input type="text" id="countryOfProduction" name="countryOfProduction" value="${product.countryOfProduction}">

                        <label for="registrationNumber" class="required">Registration Number</label>
                        <input type="text" id="registrationNumber" name="registrationNumber" value="${product.registrationNumber}" required>

                        <label for="status" class="required">Status</label>
                        <select id="status" name="status" required>
                            <option value="1" ${product.status == 1 ? "selected" : ""}>Active</option>
                            <option value="0" ${product.status == 0 ? "selected" : ""}>Inactive</option>
                            <option value="3" ${product.status == 3 ? "selected" : ""}>Pending</option>
                            <option value="4" ${product.status == 4 ? "selected" : ""}>Discontinued</option>
                        </select>

                        <label for="prescriptionRequired" class="required">Prescription Required</label>
                        <select id="prescriptionRequired" name="prescriptionRequired" required>
                            <option value="yes" ${product.prescriptionRequired.equals("yes") ? "selected" : ""}>Yes</option>
                            <option value="no" ${product.prescriptionRequired.equals("no") ? "selected" : ""}>No</option>
                        </select>


                        <label>Category *</label>
                        <select id="categoryDropdown" name="categoryId" style="width: 100%;" required>
                            <option value="${product.categoryID}">${categoryName}</option> <!-- Hiển thị tên danh mục -->
                            <c:forEach var="category" items="${sessionScope.categories}">
                                <option value="${category.categoryID}" ${category.categoryID == product.categoryID ? "selected" : ""}>${category.categoryName}</option>
                            </c:forEach>
                        </select>



                    </div>
                </div>

                <!-- Ingredient Section -->
                <div class="form-section">
                    <h3>Ingredients</h3>
                    <div id="ingredientContainer">
                        <c:forEach var="ingredient" items="${ingredients}">
                            <div class="ingredientRow">
                                <input type="text" name="ingredientName[]" value="${ingredient.ingredientName}" class="ingredientInput" required>
                                <input type="text" name="InUnit[]" value="${ingredient.unit}" class="ingredientInput" required>
                                <input type="number" min="1" name="InQuantity[]" value="${ingredient.quantity}" class="ingredientInput" required>
                                <button type="button" class="remove-btn" onclick="removeRow1(this)">Remove</button>
                            </div>
                        </c:forEach>
                    </div>
                    <button type="button" onclick="addIngredientRow()">Add Ingredient</button>
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

                        <!-- Loop through existing units from database -->
                        <c:forEach var="priceQuantity" items="${priceQuantities}">
                            <tr>
                                <td>
                                    <select name="unit[]">
                                        <c:forEach var="unit" items="${units}">
                                            <option value="${unit.unitID}" ${priceQuantity.unitID == unit.unitID ? "selected" : ""}>
                                                ${unit.unitName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <!-- Don't show Remove button for existing units -->
                                </td>
                                <td>
                                    <input type="number" name="packagingDetails[]" value="${priceQuantity.packagingDetails}" placeholder="Packaging details *" oninput="checkBasedUnit(this)" required="">
                                    <span class="based-unit-message" style="display: none; color: green;">Based Unit</span>
                                <td>
                                    <select name="unitStatus[]" required>
                                        <option value="1" ${priceQuantity.unitStatus == 1 ? "selected" : ""}>Available</option>
                                        <option value="0" ${priceQuantity.unitStatus == 0 ? "selected" : ""}>Unavailable</option>
                                        <option value="2" ${priceQuantity.unitStatus == 2 ? "selected" : ""}>Out of stock</option>
                                    </select>
                                </td>
                                <td>
                                    <input type="number" min="0" name="salePrice[]"  value="${priceQuantity.salePrice}" placeholder="Sale Price - VND *" required="">
                                </td>
                            </tr>
                        </c:forEach>

                    </table>
                    <button type="button" onclick="addUnitRow()">Add Unit</button>
                </div>


                <button type="submit" onclick="validateForm()">Update Product</button>
            </form>
        </div>
    </body>
</html>
