<%@ page language="java" %>
<div class="header">
    <div class="navigation">
        <a href="#" onclick="confirmNavigation('http://localhost:8080/MedicineShop/home')">Home</a>
        <a href="http://localhost:8080/MedicineShop/showProductManageView">Product Manage Menu</a>       
        <a href="http://localhost:8080/MedicineShop/product/addxx">Add Product</a> 
        <a href="http://localhost:8080/MedicineShop/GetImport">Import Product</a> 
        <a href="http://localhost:8080/MedicineShop/stockManagement">Stock</a>
        <a href="http://localhost:8080/MedicineShop/viewImports">Import History</a>
        <a href="http://localhost:8080/MedicineShop/CategoryServlet">Category List</a>
        <a href="http://localhost:8080/MedicineShop/AdminApprovalLogServlet?status=3">Admin Approval</a>
        <a href="http://localhost:8080/MedicineShop/usermanagement">User Management</a>

        <script>
            function showError(event) {
                event.preventDefault(); // Ng?n ch?n chuy?n h??ng
                alert("Error: Missing part - Can not access");
            }
        </script>
        <a href="http://localhost:8080/MedicineShop/changeProfile">Profile</a>
        <a href="http://localhost:8080/MedicineShop/login">Login</a>
        <a href="#" onclick="confirmLogout()">Logout</a>
    </div>
</div>

<style>
    body {
        font-family: Arial, sans-serif;
        margin: 0;
        background-color: #f8f9fa;
    }
    .header {
        background-color: #343a40;
        color: white;
        padding: 15px;
        text-align: center;
    }
    .navigation {
        margin-top: 10px; /* Space between title and links */
    }
    .navigation a {
        color: #f8f9fa;
        text-decoration: none;
        padding: 10px 15px;
        margin: 0 5px; /* Spacing between links */
        border-radius: 5px;
        display: inline-block; /* Align links horizontally */
    }
    .navigation a:hover {
        background-color: #495057;
    }
    .main {
        padding: 20px;
    }
    .button {
        display: inline-block;
        padding: 10px 20px;
        margin: 10px 0;
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

<script>
    function confirmLogout() {
        if (confirm("Are you sure you want to logout?")) {
            window.location.href = "http://localhost:8080/MedicineShop/logout"; // Redirect to logout page
        }
    }

    function confirmNavigation(url) {
        if (confirm("Are you sure you want to navigate to Home?")) {
            window.location.href = url; // Redirect to the specified URL
        }
    }
</script>
