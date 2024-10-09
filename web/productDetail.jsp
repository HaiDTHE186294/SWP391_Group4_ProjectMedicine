<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.Ingredient" %>
<%@ page import="model.ProductPriceQuantity" %>
<%@ page import="model.ProductUnit" %>
<%@ page import="model.Category" %>

<html>
    <head>
    <a href="http://localhost:8080/MedicineShop/testMenu.jsp" class="button">Home</a>
    <title>Product Detail</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;

        }
        h1 {
            color: #333;
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
            color: black;
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
            display: none; /* Bắt đầu ẩn mô tả đầy đủ và FAQ */
        }
    </style>
    <script>
        function toggleDescription(id) {
            var fullDescriptionElement = document.getElementById(id);
            if (fullDescriptionElement.style.display === 'none' || fullDescriptionElement.style.display === '') {
                fullDescriptionElement.style.display = 'block'; // Hiện mô tả đầy đủ
            } else {
                fullDescriptionElement.style.display = 'none'; // Ẩn mô tả đầy đủ
            }
        }
    </script>
</head>
<body>

    <h1>Product Detail</h1>

    <table>
        <tr>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Brand</th>
            <th>Description</th>
            <th>Category Name</th> 
            <th>Pharmaceutical Form</th>
            <th>Brand Origin</th>
            <th>Manufacturer</th>
            <th>Country of Production</th>
            <th>Short Description</th>
            <th>Registration Number</th>
            <th>FAQ</th>
            <th>Status</th>
            <th>Sold</th>
            <th>Date Created</th>
            <th>Product Version</th>
            <th>Prescription Required</th>
            <th>Target Audience</th>
            <th>Image</th>

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
            <td class="shortened-text" 
                onclick="toggleDescription('fullDescription1')">
                <%= product.getProductDescription() != null ? product.getProductDescription() : "No description available." %>
            </td>
            <td>

            </td>
            <td><%= product.getPharmaceuticalForm() %></td>
            <td><%= product.getBrandOrigin() %></td>
            <td><%= product.getManufacturer() %></td>
            <td><%= product.getCountryOfProduction() %></td>
            <td class="shortened-text" 
                onclick="toggleDescription('fullDescription2')">
                <%= product.getShortDescription() != null ? product.getShortDescription() : "No short description available." %>
            </td>
            <td><%= product.getRegistrationNumber() %></td>
            <td class="shortened-text" 
                onclick="toggleDescription('fullDescription3')">
                <%= product.getProductReviews() != null ? product.getProductReviews() : "No FAQ available." %>
            </td>
            <td>
                <%
                    // Chuyển đổi Status từ 1/0 sang "Active"/"Inactive"
                    String status = product.getStatus() == 1 ? "Active" : "Inactive";
                %>
                <%= status %>
            </td> 
            <td><%= product.getSold() %></td>
            <td><%= product.getDateCreated() %></td>
            <td><%= product.getProductVersion() %></td>
            <td><%= product.getPrescriptionRequired() %></td>
            <td><%= product.getTargetAudience() %></td>
            <td><img class="product-image" src="<%= product.getImagePath() %>" alt="Product Image"></td>
        </tr>
        <tr>
            <td colspan="3" class="full-description" id="fullDescription1">
                <%= product.getProductDescription() != null ? product.getProductDescription() : "No description available." %>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="full-description" id="fullDescription2">
                <%= product.getShortDescription() != null ? product.getShortDescription() : "No short description available." %>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="full-description" id="fullDescription3">
                <%= product.getProductReviews() != null ? product.getProductReviews() : "No FAQ available." %>
            </td>
        </tr>
    </table>



    <!-- Ingredient List -->    
    <h2>Ingredient List</h2>
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

    <!-- Product Price Quantity List -->
    <h2>Product Price Quantity List</h2>
    <table>
        <tr>
            <th>Product Unit ID</th>
            <th>Packaging Details</th>
            <th>Product ID</th>
            <th>Unit Name</th>
        </tr>
        <%
            List<ProductPriceQuantity> priceQuantities = (List<ProductPriceQuantity>) request.getAttribute("priceQuantities");
            List<ProductUnit> units = (List<ProductUnit>) request.getAttribute("units");
            
            if (priceQuantities != null && !priceQuantities.isEmpty()) {
                for (ProductPriceQuantity ppq : priceQuantities) {
                    String unitName = "";
                    
                    if (units != null) {
                        for (ProductUnit unit : units) {
                            if (unit.getUnitID().equals(ppq.getUnitID())) {
                                unitName = unit.getUnitName();
                                break;
                            }
                        }
                    }
        %>
        <tr>
            <td><%= ppq.getProductUnitID() %></td>
            <td><%= ppq.getPackagingDetails() %></td>
            <td><%= ppq.getProductID() %></td>
            <td><%= unitName %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4" class="no-data">No price quantities available.</td>
        </tr>
        <%
            }
        %>
    </table>

</body>
</html>









<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Product Detail View</title>
        <style>
        </style>
    </head>
    <body>
        <---------------------------------------------------->
        <h1>Product Detail</h1>

        <!-- Table for product information display -->
    <td></td>

    <table>
        <tr>
            <th>ID - Unique</th>
            <td><%= product.getProductID() %></td>
            <th>Pharmaceutical Form</th>
            <td><%= product.getPharmaceuticalForm() %></td>
        </tr>
        <tr>
            <th>Target Audience</th>
            <td><%= product.getTargetAudience() %></td>
            <th>Packaging Details</th>
            <td>Box of 10 strips</td>
        </tr>
        <tr>
            <th>Brand</th>
            <td><%= product.getBrand() %></td>
            <th>Brand Origin</th>
            <td><%= product.getBrandOrigin() %></td>
        </tr>
        <tr>
            <th>Product Name</th>
            <td><%= product.getProductName() %></td>
            <th>Manufacturer</th>
            <td><%= product.getManufacturer() %></td>
        </tr>
        <tr>
            <th>Image</th>
            <td><img class="product-image" src="<%= product.getImagePath() %>" alt="Product Image"></td>
            <th>Country of Production</th>
            <td><%= product.getCountryOfProduction() %></td>
        </tr>
        <tr>
            <th>Short Description</th>
            <td colspan="3">This is a fast-acting pain reliever used to treat mild to moderate pain...</td>
        </tr>
        <tr>
            <th>FAQ</th>
            <td colspan="3">Q: What is this product used for? A: Pain relief...</td>
        </tr>
        <tr>
            <th>Description</th>
            <td colspan="3">Paracetamol 500mg is used to treat...</td>
        </tr>
        <tr>
            <th>Registration Number</th>
            <td>VN-12345</td>
            <th>Status</th>
            <td>Active</td>
        </tr>
        
        <td><%= product.getSold() %></td>
            <td><%= product.getDateCreated() %></td>
            
            <td><%= product.getPrescriptionRequired() %></td>
            
            
            
        <tr>
            <th>Prescription Required</th>
            <td>Yes</td>
            <th>Category</th>
            <td>                    <%
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
                <%= categoryName %></td>
        </tr>
    </table>

    <!-- Ingredients Section -->
    <h2>Ingredients</h2>
    <table>
        <tr>
            <th>Ingredient Name</th>
            <td>Paracetamol</td>
            <th>Unit</th>
            <td>mg</td>
            <th>Quantity</th>
            <td>500</td>
        </tr>
    </table>

    <!-- Unit and Packaging Section -->
    <h2>Unit and Packaging Details</h2>
    <table>
        <tr>
            <th>Unit</th>
            <td>Box</td>
            <th>Packaging Details</th>
            <td>10 strips per box</td>
        </tr>
    </table>

</body>
</html>
