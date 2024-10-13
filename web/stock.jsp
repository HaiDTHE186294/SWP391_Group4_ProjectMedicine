<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Stock" %>
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
            <th>Base Unit ID</th>
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
            if (stockList != null) {
                for (Stock stock : stockList) {
        %>
        <tr>
            <td><%= stock.getBatchNo() %></td>
            <td><%= stock.getProductId() %></td>
            <td><%= stock.getBaseUnitId() %></td>
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
            <td colspan="7">No stocks available</td>
        </tr>
        <%
            }
        %>
    </tbody>
</table>

</body>
</html>
