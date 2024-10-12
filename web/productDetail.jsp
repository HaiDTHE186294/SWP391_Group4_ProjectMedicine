<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Category" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product Management - View Product</title>
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
                background-color: #f9f9f9; /* Màu nền để hiện thị không cho chỉnh sửa */
                pointer-events: none; /* Không cho phép tương tác với trường nhập liệu */
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
            .product-image {
                max-width: 200px;
                display: block;
                margin-top: 10px;
            }
            .ingredientRow {
                display: flex; /* Đảm bảo xếp hàng ngang */
                gap: 10px;
                margin-bottom: 10px;
            }

            .ingredientInput {
                width: 30%;
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 4px;
                color: black; /* Đặt màu chữ thành đen */
            }
            label {
                color: black; /* Đặt màu chữ nhãn thành đen */
            }

            .required {
                color: black; /* Đặt màu chữ cho các nhãn yêu cầu thành đen */
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>View Product Information</h1>
            <form>
                <div class="grid-container">
                    <div>
                        <label for="productId" class="required">ID - Unique</label>
                        <input type="text" id="productId" name="productId" value="${product.productID}" readonly>

                        <label for="targetAudience">Target Audience</label>
                        <input type="text" id="targetAudience" name="targetAudience" value="${product.targetAudience}">

                        <label for="brand">Brand</label>
                        <input type="text" id="brand" name="brand" value="${product.brand}">

                        <label for="productName" class="required">Product Name</label>
                        <input type="text" id="productName" name="productName" value="${product.productName}">

                        <label for="imageUpload" class="required">Image</label>
                        <img id="imagePreview" class="product-image" src="${product.imagePath}" alt="Product Image">

                        <label for="shortDescription">Short Description</label>
                        <textarea id="shortDescription" name="shortDescription" readonly>${product.shortDescription}</textarea>

                        <label for="faq">FAQ</label>
                        <textarea id="faq" name="faq" readonly>${product.faq}</textarea>

                        <label for="description" class="required">Description</label>
                        <textarea id="productDescription" name="description" readonly>${product.productDescription}</textarea>
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
                        <input type="text" id="registrationNumber" name="registrationNumber" value="${product.registrationNumber}">

                        <label for="status" class="required">Status</label>
                        <select id="status" name="status" disabled>
                            <option value="1" ${product.status == 1 ? "selected" : ""}>Active</option>
                            <option value="0" ${product.status == 0 ? "selected" : ""}>Inactive</option>
                            <option value="3" ${product.status == 3 ? "selected" : ""}>Pending</option>
                            <option value="4" ${product.status == 4 ? "selected" : ""}>Discontinued</option>
                        </select>

                        <label for="prescriptionRequired" class="required">Prescription Required</label>
                        <select id="prescriptionRequired" name="prescriptionRequired" disabled>
                            <option value="yes" ${product.prescriptionRequired.equals("yes") ? "selected" : ""}>Yes</option>
                            <option value="no" ${product.prescriptionRequired.equals("no") ? "selected" : ""}>No</option>
                        </select>

                        <label>Category *</label>
                        <select id="categoryDropdown" name="categoryId" disabled>
                            <option value="${product.categoryID}">${categoryName}</option> <!-- Hiển thị tên danh mục -->
                            <c:forEach var="category" items="${sessionScope.categories}">
                                <option value="${category.categoryID}" ${category.categoryID == product.categoryID ? "selected" : ""}>${category.categoryName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <!-- Ingredients Section -->
                <div class="form-section">
                    <h3>Ingredients</h3>
                    <div id="ingredientContainer">
                        <c:forEach var="ingredient" items="${ingredients}">
                            <div class="ingredientRow">
                                <input type="text" name="ingredientName[]" value="${ingredient.ingredientName}" readonly class="ingredientInput">
                                <input type="text" name="InUnit[]" value="${ingredient.unit}" readonly class="ingredientInput">
                                <input type="number" min="1" name="InQuantity[]" value="${ingredient.quantity}" readonly class="ingredientInput">
                            </div>
                        </c:forEach>
                    </div>
                </div>

                <!-- Unit Section -->
                <div class="form-section">
                    <h3>Unit and Packaging Details</h3>
                    <table id="unitTable">
                        <tr>
                            <th>Unit</th>
                            <th>Packaging Quantity Details</th>
                            <th>Unit Status</th>
                            <th>Sale Price (VND)</th>
                            
                        </tr>
                        <c:forEach var="priceQuantity" items="${priceQuantities}">
                            <tr>
                                <td>
                                    <select name="unit[]" disabled>
                                        <c:forEach var="unit" items="${units}">
                                            <option value="${unit.unitID}" ${priceQuantity.unitID == unit.unitID ? "selected" : ""}>${unit.unitName}</option>
                                        </c:forEach>
                                    </select>
                                </td>
                                <td><input type="number" name="packagingDetails[]" value="${priceQuantity.packagingDetails}" readonly placeholder="Packaging details *"></td>
                                <td>
                                    <select name="unitStatus[]" required>
                                        <option value="1" ${priceQuantity.unitStatus == 1 ? "selected" : ""}>Available</option>
                                        <option value="0" ${priceQuantity.unitStatus == 0 ? "selected" : ""}>Unavailable</option>
                                        <option value="2" ${priceQuantity.unitStatus == 2 ? "selected" : ""}>Out of stock</option>
                                    </select>
                                </td>
                                <td><input type="number" name="salePrice[]" value="${priceQuantity.salePrice}" readonly placeholder="Sale Price *"></td> <!-- Ô cho Price -->
                            </tr>
                        </c:forEach>
                    </table>
                </div>

                <button type="button" onclick="window.history.back();">Back</button>
            </form>
        </div>
    </body>
</html>