<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Category List</title>
        <style>
            .nested {
                display: none; /* Ẩn danh mục con mặc định */
            }
            .toggle {
                cursor: pointer; /* Đổi con trỏ khi hover qua danh mục */
            }

            body {
                font-family: Arial, sans-serif; /* Chọn font chữ thân thiện */
                margin: 20px; /* Thêm khoảng cách cho toàn bộ body */
            }

            h1 {
                color: #333; /* Màu sắc tiêu đề */
                text-align: center; /* Căn giữa tiêu đề */
            }

            #category-list {
                list-style-type: none; /* Bỏ đánh dấu cho danh sách */
                padding: 0; /* Bỏ padding cho danh sách */
            }

            li {
                margin: 10px 0; /* Thêm khoảng cách giữa các mục danh sách */
                padding: 10px; /* Thêm padding cho các mục danh sách */
                background-color: #f9f9f9; /* Màu nền cho mục danh sách */
                border-radius: 5px; /* Bo góc cho các mục danh sách */
                transition: background-color 0.3s; /* Hiệu ứng chuyển màu nền */
            }

            li:hover {
                background-color: #e0f7fa; /* Màu nền khi hover */
            }

            .toggle {
                cursor: pointer; /* Đổi con trỏ khi hover qua danh mục */
                font-weight: bold; /* Làm đậm chữ cho danh mục */
            }

            .nested {
                display: none; /* Ẩn danh mục con mặc định */
                padding-left: 20px; /* Thêm khoảng cách bên trái cho danh mục con */
            }

            button {
                margin-left: 10px; /* Khoảng cách giữa tên danh mục và nút cập nhật */
                padding: 5px 10px; /* Padding cho nút */
                background-color: #007BFF; /* Màu nền nút */
                color: white; /* Màu chữ trên nút */
                border: none; /* Bỏ viền cho nút */
                border-radius: 3px; /* Bo góc cho nút */
                cursor: pointer; /* Đổi con trỏ khi hover qua nút */
            }

            button:hover {
                background-color: #0056b3; /* Màu nền khi hover qua nút */
            }
            
        </style>
        <script>
            function toggleSubCategories(categoryId) {
                var subList = document.getElementById("subCategories-" + categoryId);
                if (subList.style.display === "block") {
                    subList.style.display = "none";
                } else {
                    subList.style.display = "block";
                }
            }
        </script>
        <%@include file="dashboardHeader.jsp" %>
    </head>
    <body>
        <%
    // Get roleID from session
    Integer roleID = (Integer) session.getAttribute("userRoleID");

    // Check if roleID is not 3
    if (roleID == null || roleID == 2) {
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
        <h1>Danh sách danh mục</h1>
        <ul id="category-list">
            <c:forEach var="category" items="${categories}">
                <c:if test="${category.parentCategoryID == null}">
                    <li>
                        <span class="toggle" onclick="toggleSubCategories('${category.categoryID}')">${category.categoryName}</span>
                        <button onclick="window.location.href = 'CategoryServlet?action=edit&id=${category.categoryID}'">Update</button>
                        <button onclick="window.location.href = 'CategoryServlet?action=insert&id=${category.categoryID}'">Add Sub-Category</button>
                        <ul id="subCategories-${category.categoryID}" class="nested">
                            <c:forEach var="subCategory" items="${categories}">
                                <c:if test="${subCategory.parentCategoryID == category.categoryID}">
                                    <li>
                                        <span class="toggle" onclick="toggleSubCategories('${subCategory.categoryID}')">${subCategory.categoryName}</span>
                                        <button onclick="window.location.href = 'CategoryServlet?action=edit&id=${subCategory.categoryID}'">Update</button>
                                        <button onclick="window.location.href = 'CategoryServlet?action=insert&id=${subCategory.categoryID}'">Add Sub-Category</button>
                                        <ul id="subCategories-${subCategory.categoryID}" class="nested">
                                            <c:forEach var="subSubCategory" items="${categories}">
                                                <c:if test="${subSubCategory.parentCategoryID == subCategory.categoryID}">
                                                    <li>${subSubCategory.categoryName}</li>
                                                    <button onclick="window.location.href = 'CategoryServlet?action=edit&id=${subSubCategory.categoryID}'">Update</button>   
                                                </c:if>
                                            </c:forEach>
                                        </ul>
                                    </li>
                                </c:if>
                            </c:forEach>
                        </ul>
                    </li>
                </c:if>
            </c:forEach>
        </ul>
    </body>
</html>
