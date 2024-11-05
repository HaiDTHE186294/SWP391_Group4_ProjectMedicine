<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Ingredient" %>
<html>
<head>
    <title>Ingredient List</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            background-color: #f9f9f9;
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
    </style>
</head>
<body>
    <h1>Ingredient List</h1>
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
            <td colspan="5">No ingredients available.</td>
        </tr>
        <%
            }
        %>
    </table>
</body>
</html>
