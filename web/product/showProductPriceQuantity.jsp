<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.ProductPriceQuantity" %>
<%@ page import="model.ProductUnit" %>
<html>
<head>
    <title>Product Price Quantity List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
        }
        h1 {
            color: #333;
            text-align: center;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            overflow-x: auto; /* Allow horizontal scrolling if necessary */
        }
        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: left;
            white-space: nowrap; /* Prevent text from wrapping */
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
        @media screen and (max-width: 768px) {
            th, td {
                display: block; /* Stack elements vertically on smaller screens */
                width: 100%; /* Make them full width */
            }
        }
        .no-data {
            text-align: center;
            font-weight: bold;
            color: #888;
        }
    </style>
</head>
<body>
    <h1>Product Price Quantity List</h1>
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
            <td colspan="4" class="no-data">No product price quantities available.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
