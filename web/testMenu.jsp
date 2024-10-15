<%-- 
    Document   : testMenu
    Created on : Sep 21, 2024, 11:42:27 PM
    Author     : Asus
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Test Links</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        .button {
            display: inline-block;
            padding: 10px 20px;
            margin: 10px;
            font-size: 16px;
            color: white;
            background-color: #6c757d; /* Màu xám */
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
        .button:hover {
            background-color: #5a6268; /* Màu xám đậm khi hover */
        }
    </style>
</head>
<body>
    <h1>Test Links</h1>
    <a href="http://localhost:8080/MedicineShop/login" class="button">Test Login</a>
    <a href="http://localhost:8080/MedicineShop/changeProfile" class="button">Change Profile</a>
    <a href="http://localhost:8080/MedicineShop/home.jsp" class="button">Change Password</a>
    <a href="http://localhost:8080/MedicineShop/product/addxx" class="button">Add Product</a>
    <a href="http://localhost:8080/MedicineShop/product/ShowProductInformation" class="button">View Product Information</a>
    <a href="http://localhost:8080/MedicineShop/register" class="button">Register</a>
    <a href="http://localhost:8080/MedicineShop/confirmpass" class="button">Confirm Password</a>
    <a href="http://localhost:8080/MedicineShop/showProductManageView" class="button">Product Manage Menu</a>
    <a href="http://localhost:8080/MedicineShop/CategoryURL?service=listAllCategory" class="button">Category List</a>
    <a href="http://localhost:8080/MedicineShop/AccountURL" class="button">Account List</a>
    <a href="http://localhost:8080/MedicineShop/StaffURL" class="button">Staff   List</a>
</body>
</html>
