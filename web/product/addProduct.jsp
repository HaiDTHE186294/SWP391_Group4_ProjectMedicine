<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>

<%
    List<Product> products = (List<Product>) session.getAttribute("products");
%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management - Add Product</title>
        <style>
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
            .ingredientRow {
                display: flex;
                gap: 10px;
                margin-bottom: 10px;
            }
            .ingredientInput {
                width: 30%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
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
                return checkDuplicateProductId() && checkDuplicateUnits() && checkPackagingDetails(); // Call all check functions
            }

            // Function to add ingredient row
            function addIngredientRow() {
                const container = document.getElementById('ingredientContainer');
                const newRow = document.createElement('div');
                newRow.className = 'ingredientRow';
                newRow.innerHTML = `
            <input type="text" name="ingredientName[]" placeholder="Ingredient Name *" class="ingredientInput" required>
            <input type="text" name="InUnit[]" placeholder="Unit *" class="ingredientInput" required>
            <input type="number" name="InQuantity[]" min="1" placeholder="Quantity *" class="ingredientInput" required>
        `;
                container.appendChild(newRow);
            }

            function addUnitRow() {
                const table = document.getElementById("unitTable");

                // Validate packaging details before adding a new row
                if (!checkPackagingDetails()) {
                    return; // Prevent adding if validation fails
                }

                const row = table.insertRow(-1);
                // Clone the select options from the hidden template
                const unitOptions = document.getElementById("unitOptions").cloneNode(true);
                unitOptions.style.display = "block";
                unitOptions.name = "unit[]"; // Ensure the name attribute is added for form submission

                // Create a new row with the dropdown and input field for packaging details
                row.innerHTML = `
            <td></td> <!-- Empty cell for the unit dropdown -->
            <td><input type="text" name="packagingDetails[]" placeholder="Packaging details *"></td>
        `;

                // Append the dropdown into the first cell of the new row
                row.cells[0].appendChild(unitOptions);
            }

            // Call the function on page load
            window.onload = function () {
                preventNegativeNumbers();
            };
        </script>



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
                        <input type="text" id="productId" name="productId" required>

                        <label for="targetAudience">Target Audience</label>
                        <input type="text" id="targetAudience" name="targetAudience">

                        <label for="brand">Brand</label>
                        <input type="text" id="brand" name="brand">

                        <label for="productName">Product Name *</label>
                        <input type="text" id="productName" name="productName" required>


                        <label for="imageUpload">Upload Image *</label>
                        <input type="file" id="imageUpload" name="imageUpload" required>

                        <label for="shortDescription">Short Description</label>
                        <textarea id="shortDescription" name="shortDescription"></textarea>

                        <label for="faq">FAQ</label>
                        <textarea id="faq" name="faq"></textarea>

                        <label for="description">Description</label>
                        <textarea id="description" name="description"></textarea>
                    </div>

                    <!-- Right Section -->
                    <div>
                        <label for="pharmaceuticalForm">Pharmaceutical Form</label>
                        <input type="text" id="pharmaceuticalForm" name="pharmaceuticalForm">

                        <label for="packagingDetails">Packaging Details *</label>
                        <input type="text" id="packagingDetails" name="packagingDetails" required>

                        <label for="brandOrigin">Brand Origin</label>
                        <input type="text" id="brandOrigin" name="brandOrigin">

                        <label for="manufacturer">Manufacturer</label>
                        <input type="text" id="manufacturer" name="manufacturer">

                        <label for="countryOfProduction">Country of Production</label>
                        <input type="text" id="countryOfProduction" name="countryOfProduction">

                        <label for="registrationNumber">Registration Number *</label>
                        <input type="text" id="registrationNumber" name="registrationNumber" required>

                        <label for="status">Status *</label>
                        <select id="status" name="status" required>
                            <option value="1">Active</option>
                            <option value="0">Inactive</option>
                            <option value="3">Pending</option>
                            <option value="4">Discontinued</option>
                        </select>

                        <label for="prescriptionRequired">Prescription Required *</label>
                        <select id="prescriptionRequired" name="prescriptionRequired" required>
                            <option value="yes">Yes</option>
                            <option value="no">No</option>
                        </select>

                        <label >Category *</label>
                        <select id="categoryDropdown" name="categoryId" style="width: 100%;" required>
                            <option value="">Select Category</option>
                            <c:forEach var="category" items="${sessionScope.categories}">
                                <option value="${category.categoryID}">${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Ingredient Section -->
                <div class="form-section">
                    <h3>Ingredients</h3>
                    <div id="ingredientContainer">
                        <div class="ingredientRow">
                            <input type="text" name="ingredientName[]" placeholder="Ingredient Name *" class="ingredientInput" required>
                            <input type="text" name="InUnit[]" placeholder="Unit *" class="ingredientInput" required>
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
                        </tr>
                        <tr>
                            <td>
                                <select name="unit[]">
                                    <c:forEach var="unit" items="${sessionScope.units}">
                                        <option value="${unit.unitID}">${unit.unitName}</option>
                                    </c:forEach>
                                </select>
                            </td>
                            <td><input type="text" name="packagingDetails[]" placeholder="Packaging details *"></td>
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
