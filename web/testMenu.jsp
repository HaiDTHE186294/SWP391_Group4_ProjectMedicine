<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript">
        var kommunicateSettings = {
            "appId": "19a459080780f8a3e18a542ff44c64e9f",
            "userId": "<%= session.getAttribute("userId") %>",
            "email": "<%= session.getAttribute("userEmail") %>",
            "userName": "<%= session.getAttribute("userName") %>"      
        };

        (function (d, m) {
            var s = document.createElement("script");
            s.type = "text/javascript";
            s.async = true;
            s.src = "https://widget.kommunicate.io/v2/kommunicate.app";
            var h = document.getElementsByTagName("head")[0];
            h.appendChild(s);
            window.kommunicate = m;
            m._globals = kommunicateSettings;
        })(document, window.kommunicate || {});
    </script>

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
            background-color: #6c757d; /* Gray color */
            border: none;
            border-radius: 5px;
            text-decoration: none;
        }
        .button:hover {
            background-color: #5a6268; /* Dark gray on hover */
        }
    </style>
</head>
<body>
    <h1>Test Links</h1>
    <button onclick="updateUser()">Update User</button>
    <a href="http://localhost:8080/MedicineShop/login" class="button">Test Login</a>
    <a href="http://localhost:8080/MedicineShop/changeProfile" class="button">Change Profile</a>
    <a href="http://localhost:8080/MedicineShop/product/addxx" class="button">Add Product</a>
    <a href="http://localhost:8080/MedicineShop/product/ShowProductInformation" class="button">View Product Information</a>
    <a href="http://localhost:8080/MedicineShop/register" class="button">Register</a>
    <a href="http://localhost:8080/MedicineShop/showProductManageView" class="button">Product Manage Menu</a>
    <a href="http://localhost:8080/MedicineShop/CategoryURL" class="button">Category List</a>
</body>
</html>
