<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Edit Category</title>`
        <style>
            body {
                font-family: Arial, sans-serif; /* Chọn font chữ thân thiện */
                margin: 0; /* Thêm khoảng cách cho toàn bộ body */
                background-color: #f4f4f4; /* Màu nền cho body */
            }

            h2 {
                color: #333; /* Màu sắc tiêu đề */
                text-align: center; /* Căn giữa tiêu đề */
            }

            form {
                max-width: 500px; /* Giới hạn chiều rộng của form */
                margin: 0 auto; /* Căn giữa form */
                padding: 20px; /* Padding cho form */
                background-color: white; /* Màu nền cho form */
                border-radius: 8px; /* Bo góc cho form */
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Hiệu ứng bóng cho form */
            }

            label {
                display: block; /* Đặt mỗi label trên một dòng mới */
                margin-bottom: 8px; /* Khoảng cách giữa label và input */
                font-weight: bold; /* Làm đậm chữ cho label */
            }

            input[type="text"], input[type="submit"], select, textarea {
                width: 100%; /* Chiều rộng 100% cho input và select */
                padding: 10px; /* Padding cho input và select */
                margin-bottom: 20px; /* Khoảng cách dưới mỗi input */
                border: 1px solid #ccc; /* Đường viền cho input */
                border-radius: 4px; /* Bo góc cho input */
                box-sizing: border-box; /* Đảm bảo padding không làm thay đổi kích thước */
            }

            input[type="submit"] {
                background-color: #007BFF; /* Màu nền nút */
                color: white; /* Màu chữ trên nút */
                border: none; /* Bỏ viền cho nút */
                cursor: pointer; /* Đổi con trỏ khi hover qua nút */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền */
            }

            input[type="submit"]:hover {
                background-color: #0056b3; /* Màu nền khi hover qua nút */
            }

            a {
                display: block; /* Đặt link trên một dòng mới */
                text-align: center; /* Căn giữa link */
                margin-top: 20px; /* Khoảng cách trên link */
                color: #007BFF; /* Màu sắc link */
                text-decoration: none; /* Bỏ gạch chân */
            }

            a:hover {
                text-decoration: underline; /* Gạch chân link khi hover */
            }
        </style>
        <script>
            function validateNullInput() {
                const form = document.forms[0];
                const requiredFields = form.querySelectorAll('input[required], select[required]');

                for (const field of requiredFields) {
                    // Trim whitespace and check if the input is empty
                    if (field.value.trim() === "") {
                        alert("Vui lòng điền thông tin hợp lệ vào tất cả các trường bắt buộc.");
                        field.focus();
                        location.reload();
                        return false; // Prevent form submission
                    }
                }
                return true; // Call date validation as well
            }
        </script>
        <%@include file="dashboardHeader.jsp" %>

    </head>
    <body>
        <%
    // Get roleID from session
    Integer roleID = (Integer) session.getAttribute("userRoleID");

    // Check if roleID is not 3
    if (roleID == null || roleID != 3) {
        // Get the previous page URL from the referer header
        String referer = request.getHeader("referer");
        %>
        <script>
            alert("You do not have permission to access this page.");
            window.location.href = "<%= (referer != null) ? referer : "http://localhost:8080/MedicineShop/home" %>";
        </script>
        <%
                return;
            }
        %>
        <h2>Edit Category</h2>
        <form action="CategoryServlet" method="post" onsubmit="return validateNullInput()">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="categoryID" value="${category.categoryID}">

            <label for="categoryName">Category Name *:</label>
            <input type="text" name="categoryName" value="${category.categoryName}" required>
            <input type="hidden" name="icon" value="${category.icon}"><br>
            <input type="hidden" name="parentCategoryID" value="${category.parentCategoryID}" readonly="">

            <label for="status">Status:</label>
            <select name="status">
                <option value="1" <c:if test="${category.status == 1}">selected</c:if>>Active</option>
                <option value="0" <c:if test="${category.status == 0}">selected</c:if>>Inactive</option>
                </select><br>

                <label for="description">Description:</label>
                <textarea name="description">${category.description}</textarea><br>

                <input type="submit" value="Update Category" >
        </form>

        <a href="CategoryServlet">Cancel</a>
    </body>
</html>
