<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Ingredient" %>
<%@ page import="model.ProductPriceQuantity" %>
<%@ page import="model.ProductUnit" %>
<%@ page import="model.Category" %>

<html>
    <head>
        <title>Product Detail</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 20px;
                background-color: #f9f9f9;
            }
            h1 {
                color: #333;
                text-align: center;
                margin-bottom: 20px;
            }
            .container {
                max-width: 800px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ccc;
                padding: 10px;
                text-align: left;
            }
            th {
                background-color: #4CAF50;
                color: white;
            }
            tr:nth-child(even) {
                background-color: #f2f2f2;
            }
            tr:hover {
                background-color: #e9e9e9;
            }
            .shortened-text {
                max-width: 150px;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                cursor: pointer;
                color: blue;
                text-decoration: underline;
            }
            .no-data {
                text-align: center;
                font-weight: bold;
                color: #888;
            }
            .product-image {
                max-width: 150px;
            }
            .full-description {
                margin-top: 10px;
                border: 1px solid #ccc;
                padding: 10px;
                background-color: #fff;
                display: none; /* Initially hidden */
            }
            .info-section {
                margin-bottom: 20px;
            }
        </style>
        <script>
            function toggleDescription(id) {
                var fullDescriptionElement = document.getElementById(id);
                fullDescriptionElement.style.display = fullDescriptionElement.style.display === 'none' || fullDescriptionElement.style.display === '' ? 'block' : 'none';
            }
        </script>
    </head>
    <body>

        <div class="container">
            <h1>Product Detail</h1>

            <!-- Basic Information -->
            <div class="info-section">
                <table>
                    <tr>
                        <th>Product ID</th>
                        <th>Product Name</th>
                        <th>Brand</th>
                    </tr>
                    <tr>
                        <%
                            Product product = (Product) request.getAttribute("product");
                            if (product != null) {
                        %>
                        <td><%= product.getProductID() %></td>
                        <td><%= product.getProductName() %></td>
                        <td><%= product.getBrand() %></td>
                        <%
                            } else {
                        %>
                        <td colspan="3" class="no-data">No product available.</td>
                        <%
                            }
                        %>
                    </tr>
                </table>
            </div>

            <!-- Description and Category -->
            <div class="info-section">
                <table>
                    <tr>
                        <th>Description</th>
                        <th>Category Name</th> 
                        <th>Pharmaceutical Form</th>
                    </tr>
                    <tr>
                        <td class="shortened-text" onclick="toggleDescription('fullDescription1')">
                            <%= product.getProductDescription() != null ? product.getProductDescription() : "No description available." %>
                        </td>
                        <td>
                            <%
                                List<Category> categories = (List<Category>) session.getAttribute("categories");
                                String categoryName = "No category available.";
                                if (categories != null) {
                                    for (Category category : categories) {
                                        if (category.getCategoryID().equals(product.getCategoryID())) {
                                            categoryName = category.getCategoryName();
                                            break;
                                        }
                                    }
                                }
                            %>
                            <%= categoryName %>
                        </td>
                        <td><%= product.getPharmaceuticalForm() %></td>
                    </tr>
                    <tr>
                        <td colspan="3" class="full-description" id="fullDescription1">
                            <%= product.getProductDescription() != null ? product.getProductDescription() : "No description available." %>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Origin and Manufacturer -->
            <div class="info-section">
                <table>
                    <tr>
                        <th>Brand Origin</th>
                        <th>Manufacturer</th>
                        <th>Country of Production</th>
                    </tr>
                    <tr>
                        <td><%= product.getBrandOrigin() %></td>
                        <td><%= product.getManufacturer() %></td>
                        <td><%= product.getCountryOfProduction() %></td>
                    </tr>
                </table>
            </div>

            <!-- Short Description and Registration -->
            <div class="info-section">
                <table>
                    <tr>
                        <th>Short Description</th>
                        <th>Registration Number</th>
                    </tr>
                    <tr>
                        <td class="shortened-text" onclick="toggleDescription('fullDescription2')">
                            <%= product.getShortDescription() != null ? product.getShortDescription() : "No short description available." %>
                        </td>
                        <td><%= product.getRegistrationNumber() %></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="full-description" id="fullDescription2">
                            <%= product.getShortDescription() != null ? product.getShortDescription() : "No short description available." %>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- FAQ and Status -->
            <div class="info-section">
                <table>
                    <tr>
                        <th>FAQ</th>
                        <th>Status</th>
                    </tr>
                    <tr>
                        <td class="shortened-text" onclick="toggleDescription('fullDescription3')">
                            <%= product.getProductReviews() != null ? product.getProductReviews() : "No FAQ available." %>
                        </td>
                        <td>
                            <%
                                String status = product.getStatus() == 1 ? "Active" : "Inactive";
                            %>
                            <%= status %>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" class="full-description" id="fullDescription3">
                            <%= product.getProductReviews() != null ? product.getProductReviews() : "No FAQ available." %>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- Additional Product Information -->
            <div class="info-section">
                <table>
                    <tr>
                        <th>Sold</th>
                        <th>Date Created</th>
                        <th>Product Version</th>
                    </tr>
                    <tr>
                        <td><%= product.getSold() %></td>
                        <td><%= product.getDateCreated() %></td>
                        <td><%= product.getProductVersion() %></td>
                    </tr>
                </table>
            </div>

            <!-- Prescription and Audience -->
            <div class="info-section">
                <table>
                    <tr>
                        <th>Prescription Required</th>
                        <th>Target Audience</th>
                        <th>Image</th>
                    </tr>
                    <tr>
                        <td><%= product.getPrescriptionRequired() %></td>
                        <td><%= product.getTargetAudience() %></td>
                        <td><img class="product-image" src="<%= product.getImagePath() %>" alt="Product Image"></td>
                    </tr>
                </table>
            </div>

            <!-- Ingredient List -->
            <h2>Ingredient List</h2>
            <div class="info-section">
                <table>
                    <tr>
                        <th>Ingredient ID</th>
                        <th>Product ID</th>
                        <th>Ingredient Name</th>
                        <th>Quantity</th>
                        <th>Unit</th>
                    </tr>
                    <%
                        List<Ingredient> ingredients = (List<Ingredient>) request.getAttribute("ingredients");
                        if (ingredients != null && !ingredients.isEmpty()) {
                            for (Ingredient ingredient : ingredients) {
                    %>
                    <tr>
                        <td><%= ingredient.getProductIngredientID() %></td>
                        <td><%= ingredient.getProductID() %></td>
                        <td><%= ingredient.getIngredientName() %></td>
                        <td><%= ingredient.getQuantity() %></td>
                        <td><%= ingredient.getUnit() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="no-data">No ingredients available.</td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>

            <!-- Price and Packaging Details -->
            <h2>Price and Packaging Details</h2>
            <div class="info-section">
                <table>
                    <tr>
                        <th>Product Unit ID</th>
                        <th>Packaging Details</th>
                        <th>Product ID</th>
                        <th>Unit ID</th>
                    </tr>
                    <%
                        List<ProductPriceQuantity> productPriceQuantities = (List<ProductPriceQuantity>) request.getAttribute("productPriceQuantities");
                        if (productPriceQuantities != null && !productPriceQuantities.isEmpty()) {
                            for (ProductPriceQuantity ppq : productPriceQuantities) {
                    %>
                    <tr>
                        <td><%= ppq.getProductUnitID() %></td>
                        <td><%= ppq.getPackagingDetails() %></td>
                        <td><%= ppq.getProductID() %></td>
                        <td><%= ppq.getUnitID() %></td>
                    </tr>
                    <%
                            }
                        } else {
                    %>
                    <tr>
                        <td colspan="4" class="no-data">No price and packaging details available.</td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            </div>

        </div>
    </body>
</html>
