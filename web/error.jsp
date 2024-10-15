<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <link rel="stylesheet" href="styles.css"> <!-- Link to your CSS file if you have one -->
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 600px;
            margin: 50px auto;
            padding: 20px;
            background: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #d9534f;
        }
        p {
            color: #555;
        }
        a {
            display: inline-block;
            margin-top: 20px;
            padding: 10px 15px;
            background: #5bc0de;
            color: white;
            text-decoration: none;
            border-radius: 5px;
        }
        a:hover {
            background: #31b0d5;
        }
    </style>
</head>
<body>

<div class="container">
    <h1>Error</h1>
    <p>
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null) {
                out.println(message);
            } else {
                out.println("An unexpected error occurred. Please try again later.");
            }
        %>
    </p>
    <a href="showProductManageView">Back to Product Manage</a>
</div>

</body>
</html>
