<%-- 
    Document   : CategoryAddScreen
    Created on : Sep 17, 2024, 11:08:04 PM
    Author     : kan3v
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Category Table</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            border: 1px solid #000;
            width: 400px;
            padding: 20px;
            margin: auto;
            margin-top: 50px;
        }
        h3 {
            text-align: center;
        }
        .row {
            margin-bottom: 15px;
        }
        .row label {
            display: inline-block;
            width: 120px;
            text-align: right;
            padding-right: 10px;
        }
        .row input[type="text"], .row input[type="file"] {
            width: 180px;
        }
        .row input[type="file"] {
            width: 140px;
        }
        .row input[type="button"], .row input[type="submit"], .row input[type="reset"] {
            margin-left: 130px;
        }
        .icon-preview {
            width: 40px;
            height: 40px;
            border: 1px solid black;
            display: inline-block;
        }
        .buttons {
            text-align: center;
        }
    </style>
</head>
<body>

<div class="container">
    <h3>Add Category Table</h3>
    
    <div class="row">
        <label for="category-id">Category ID</label>
        <input type="text" id="category-id" value="Auto generated" readonly>
    </div>
    
    <div class="row">
        <label for="category-name">Category Name</label>
        <input type="text" id="category-name" value="catename">
    </div>

    <div class="row">
        <label for="icon">Icon</label>
        <div class="icon-preview"></div>
        <input type="file" id="icon">
        <input type="button" value="Add">
    </div>
    
    <div class="row">
        <label for="parent-category-id">Parent Category ID</label>
        <input type="text" id="parent-category-id" value="xxx">
        <input type="button" value="Check">
    </div>

    <div class="buttons">
        <input type="submit" value="Add">
        <input type="reset" value="Back">
    </div>
</div>

</body>
</html>
