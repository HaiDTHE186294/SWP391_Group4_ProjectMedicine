<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.*" %>
<%@ page import="dal.*" %>
<html>
<head>
    <title>Import Product</title>
</head>
<body>
<h1>Import Product</h1>

<%
    // Retrieve the productID from the request attribute
    String productID = (String) request.getAttribute("productID");
    
    // Fetch product details using the productID
    ProductDAO productDAO = new ProductDAO();
    Product product = productDAO.getProductByID(productID); // Make sure this method exists

    // Check if the product was found
    if (product != null) {
%>

<form action="ProcessImportServlet" method="post">
    <label for="productID">productID</label>
    <input type="text" name="productID" value="<%= productID %>" disabled="">
    
    <label for="provider">Provider:</label>
    <input type="text" id="provider" name="provider" required>
    
    <label for="baseUnitId">Base Unit ID:</label>
    <input type="text" id="baseUnitId" name="baseUnitId" required>
    
    <label for="batchNo">Batch No:</label>
    <input type="text" id="batchNo" name="batchNo" required>
    
    <label for="dateManufacture">Date of Manufacture:</label>
    <input type="date" id="dateManufacture" name="dateManufacture" required>
    
    <label for="dateExpired">Date of Expiry:</label>
    <input type="date" id="dateExpired" name="dateExpired" required>
    
    <label for="priceImport">Price Import:</label>
    <input type="number" id="priceImport" name="priceImport" step="0.01" required>
    
    <label for="importer">Importer (User ID):</label>
    <input type="number" id="importer" name="importer" required>
    
    <input type="submit" value="Import">
</form>

<%
    } else {
%>
    <p>Product not found!</p>
<%
    }
%>

<a href="ProductList.jsp">Back to Product List</a>
</body>
</html>
