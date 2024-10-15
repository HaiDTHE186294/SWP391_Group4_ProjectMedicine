<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Stock" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductUnit" %>
<%@ page import="java.util.Map" %> <!-- Import Map -->
<%@ page import="java.util.HashMap" %> <!-- Import HashMap -->
<!DOCTYPE html>
<html>
<head>
    <title>Stock View</title>
</head>
<body>
<h1>Stock List</h1>

<table border="1">
    <thead>
        <tr>
            <th>Batch No</th>
            <th>Product ID</th>
            <th>Product Name</th>
            <th>Unit Name</th>
            <th>Quantity</th>
            <th>Price Import</th>
            <th>Date Manufacture</th>
            <th>Date Expired</th>
        </tr>
    </thead>
    <tbody>
        <%
            // Get the list of stocks from the request
            List<Stock> stockList = (List<Stock>) request.getAttribute("stockList");
            List<Product> productList = (List<Product>) request.getAttribute("productList");
            List<ProductUnit> pUnits = (List<ProductUnit>) request.getAttribute("pUnits");

            // Create a map for product ID to product name
            Map<String, String> productMap = new HashMap<>();
            for (Product product : productList) {
                productMap.put(product.getProductID(), product.getProductName());
            }

            // Create a map for base unit ID to unit name
            Map<String, String> unitMap = new HashMap<>();
            for (ProductUnit unit : pUnits) {
                unitMap.put(unit.getUnitID(), unit.getUnitName());
            }

            if (stockList != null) {
                for (Stock stock : stockList) {
                    String productName = productMap.get(stock.getProductId());
                    String unitName = unitMap.get(stock.getBaseUnitId());
        %>
        <tr>
            <td><%= stock.getBatchNo() %></td>
            <td><%= stock.getProductId() %></td>
            <td><%= productName != null ? productName : "Unknown Product" %></td>
            <td><%= unitName != null ? unitName : "Unknown Unit" %></td>
            <td><%= stock.getQuantity() %></td>
            <td><%= stock.getPriceImport() %></td>
            <td><%= stock.getDateManufacture() %></td>
            <td><%= stock.getDateExpired() %></td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="8">No stocks available</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

</body>
</html>
