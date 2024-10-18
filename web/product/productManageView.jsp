<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %> 
<%@ page import="model.Product" %>
<%@ page import="model.Category" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>

<!-- Include jQuery (required for Select2) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Include Select2 CSS -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<!-- Include Select2 JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">


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
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Manage</title>
        <style>
            body {
                font-family: Arial, sans-serif;
            }
            .container {
                width: 90%;
                margin: auto;
            }
            .search-bar {
                display: flex;
                justify-content: space-between;
                padding: 10px;
                border: 1px solid #ccc;
                margin-bottom: 20px;
            }
            .search-bar input, .search-bar select {
                padding: 8px;
                margin-right: 10px;
            }
            .search-bar button {
                padding: 8px 12px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 20px;
            }
            table th, table td {
                padding: 10px;
                border: 1px solid #ccc;
                text-align: center;
            }
            .actions button {
                margin-right: 10px;
            }
            .pagination {
                text-align: center;
                margin-top: 20px;
            }
            .pagination a {
                margin: 0 5px;
                text-decoration: none;
                color: blue;
            }
            .pagination a:hover {
                text-decoration: underline;
            }

            td {
                padding: 10px; /* Khoảng cách bên trong */
                height: 50px; /* Chiều cao cố định */
            }

            .actions button {
                margin-bottom: 8px; /* Khoảng cách giữa các nút theo chiều dọc */
            }

        </style>
        <%@ include file="dashboardHeader.jsp" %>
    </head>
    <body>
        <% 
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
        <div class="alert alert-success" role="alert">
            <%= message %>
        </div>
        <% 
            }
        %>

        <div class="container">
            <h2>Product Manage Menu</h2>
            <div class="search-bar">
                <th>
                    <button type="button" onclick="sortByDate()">Sort by date</button>
                </th>

                <button type="button" onclick="clearFilters()">Clear Filters</button>

                <div>
                    <form id="deleteForm" action="ProductDeleteServlet" method="post">
                        <input type="hidden" name="productID" id="productIDToDelete">
                        <button type="button" onclick="deleteSelected()">Delete Selected</button>
                    </form>
                </div>
                <button onclick="window.location.href = 'product/addxx'">Add</button>

                <select id="categoryFilter" style="width: 200px;"> <!-- Added width for better display -->
                    <option value="">All Category</option>
                    <c:forEach var="category" items="${categories}">
                        <option value="${category.categoryID}">${category.categoryName}</option>
                    </c:forEach>
                </select>

                <select id="statusFilter">
                    <option value="">All Statuses</option>
                    <option value="Inactive">Inactive</option>
                    <option value="Active">Active</option>
                    <option value="Pending">Pending</option>
                    <option value="Discontinued">Discontinued</option>
                    <option value="Out of stock">Out of stock</option>
                </select>
                <input type="date" id="dateFilter" />
                <input type="text" id="searchInput" placeholder="Type here to search" />
                <button id="searchButton">Search</button>
            </div>



            <table id="productTable">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll" onclick="toggleAll(this)" /></th>
                        <th>No.</th> <!-- Cột số thứ tự -->
                        <th>Image</th>
                        <th>ID</th> <!-- Đổi chỗ ID và Name -->
                        <th>Name</th>
                        <th>Status</th>
                        <th>Total Sold</th>
                        <th>Version</th>
                        <th>Date</th>
                        <th>Category ID</th>
                        <th>Category</th> <!-- Hiển thị tên danh mục -->
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="productBody">
                    <%
                        List<Product> productList = (List<Product>) request.getAttribute("productList");
                        List<Category> categories = (List<Category>) request.getAttribute("categories"); // Lấy danh sách danh mục
                        Map<String, Float> totalQuantities = (Map<String, Float>) request.getAttribute("totalQuantities"); 
                        if (productList != null && !productList.isEmpty()) {
                            int index = 1; // Biến để theo dõi số thứ tự
                            for (Product product : productList) {
                                String statusText;
                                switch (product.getStatus()) {
                                    case 0:
                                        statusText = "Inactive";
                                        break;
                                    case 1:
                                        statusText = "Active";
                                        break;
                                    case 2:
                                        statusText = "Out of stock";
                                        break;
                                    case 3:
                                        statusText = "Pending";
                                        break;
                                    case 4:
                                        statusText = "Discontinued";
                                        break;
                                    default:
                                        statusText = "Unknown";
                                }
                    %>
                    <tr>
                        <td><input type="checkbox" value="<%= product.getProductID() %>" class="productCheckbox" /></td>
                        <td><%= index++ %></td> <!-- Hiển thị số thứ tự -->
                        <td><img src="<%= product.getImagePath() %>" alt="Product Image" width="50" /></td>
                        <td><%= product.getProductID() %></td> <!-- ID sản phẩm -->
                        <td><%= product.getProductName() %></td> <!-- Tên sản phẩm -->
                        <td><%= statusText %></td> <!-- Hiển thị trạng thái -->
                        <td><%= product.getSold() %></td>
                        <td><%= product.getProductVersion() %></td>
                        <td><%= product.getDateCreated() %></td>
                        <td><%= product.getCategoryID() %></td>
                        <td>
                            <%
                                List<Category> categories1 = (List<Category>) session.getAttribute("categories");
                                String categoryName = "No category available.";
                                if (categories != null) {
                                    for (Category category : categories1) {
                                        if (category.getCategoryID().equals(product.getCategoryID())) {
                                            categoryName = category.getCategoryName();
                                            break;
                                        }
                                    }
                                }
                            %>
                            <%= categoryName %>
                        </td>
                        <td>
                            <!-- Set the quantity from stock object -->
                            <c:set var="quantity" value="<%= product.getProductID() %>" />

                            <!-- Retrieve the value for quantity from totalQuantities using the 'quantity' key and display 0 if null -->
                            <%= (totalQuantities.get((String)pageContext.getAttribute("quantity")) != null ? totalQuantities.get((String)pageContext.getAttribute("quantity")) : 0) %>
                        </td>

                        <td class="actions">
                            <!-- Thay nút Delete bằng biểu tượng thùng rác -->
                            <button type="button" onclick="deleteProduct('<%= product.getProductID() %>')" style="margin-right: 10px;">
                                <i class="fas fa-trash-alt"></i>
                            </button>

                            <!-- Thay nút Detail bằng biểu tượng con mắt -->
                            <button type="button" style="margin-right: 10px;">
                                <a href="ProductDetail?productID=<%= product.getProductID() %>">
                                    <i class="fas fa-eye"></i>
                                </a>
                            </button>

                            <button type="button" style="margin-right: 10px;">
                                <a href="Update?productID=<%= product.getProductID() %>">
                                    <i class="fas fa-edit"></i>
                                </a>
                            </button>

                            <form action="importServlet" method="get" style="display:inline;">
                                <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                                <button type="submit" onclick="return confirm('Are you sure you want to import this product?');" style="margin-right: 10px;">
                                    <i class="fas fa-download"></i> <!-- Use an icon for the import button -->
                                </button>
                            </form>
                        </td>

                    </tr>
                    <%
                            }
                        }
                    %>
                </tbody>
            </table>

            <div class="pagination" id="pagination"></div>
        </div>

        <script>
            const itemsPerPage = 10; // Số sản phẩm trên mỗi trang
            const productBody = document.getElementById('productBody');
            const pagination = document.getElementById('pagination');
            const searchInput = document.getElementById('searchInput');
            const searchButton = document.getElementById('searchButton');

            function clearFilters() {
                // Reset the category filter
                document.getElementById('categoryFilter').selectedIndex = 0;

                // Reset the status filter
                document.getElementById('statusFilter').selectedIndex = 0;

                // Reset the date input
                document.getElementById('dateFilter').value = '';

                // Reset the search input
                document.getElementById('searchInput').value = '';

                // Reinitialize the product table to show all products
                filterProducts();
            }

            let isAscending = true; // Variable to track sorting order

            function sortByDate() {
                const rows = Array.from(productBody.getElementsByTagName('tr'));

                // Sort the rows based on the date column
                rows.sort((a, b) => {
                    const dateA = new Date(a.querySelector('td:nth-child(9)').textContent); // Adjust column index as needed
                    const dateB = new Date(b.querySelector('td:nth-child(9)').textContent); // Adjust column index as needed
                    return isAscending ? dateA - dateB : dateB - dateA; // Toggle between ascending and descending
                });

                isAscending = !isAscending; // Toggle sorting order

                // Clear current table body and append sorted rows
                productBody.innerHTML = '';
                rows.forEach(row => productBody.appendChild(row));

                // Reinitialize pagination for sorted rows
                paginate(rows);
            }


            let allRows = []; // Lưu trữ tất cả các hàng để tìm kiếm
            function filterProducts() {
                const selectedCategory = document.getElementById('categoryFilter').value;
                const selectedStatus = document.getElementById('statusFilter').value;
                const selectedDate = document.getElementById('dateFilter').value;

                const filteredRows = allRows.filter(row => {
                    const productCategoryID = row.querySelector('td:nth-child(10)').textContent; // Adjust column index as needed
                    const productStatus = row.querySelector('td:nth-child(6)').textContent; // Adjust column index as needed
                    const productDate = row.querySelector('td:nth-child(9)').textContent; // Adjust column index as needed

                    const matchesCategory = selectedCategory === "" || productCategoryID === selectedCategory;
                    const matchesStatus = selectedStatus === "" || productStatus === selectedStatus;
                    const matchesDate = selectedDate === "" || productDate === selectedDate;

                    return matchesCategory && matchesStatus && matchesDate;
                });

                clearSearch(); // Optionally clear search results
                paginate(filteredRows); // Update pagination with the filtered results
            }

            // Attach filter function to filters
            document.getElementById('categoryFilter').onchange = filterProducts;
            document.getElementById('statusFilter').onchange = filterProducts;
            document.getElementById('dateFilter').onchange = filterProducts;

            function paginate(rows) {
                const totalPages = Math.ceil(rows.length / itemsPerPage);

                function showPage(page) {
                    const start = (page - 1) * itemsPerPage;
                    const end = start + itemsPerPage;

                    rows.forEach((row, index) => {
                        row.style.display = (index >= start && index < end) ? '' : 'none';
                    });
                }

                function createPagination() {
                    pagination.innerHTML = ''; // Xóa các nút cũ
                    for (let i = 1; i <= totalPages; i++) {
                        const pageLink = document.createElement('a');
                        pageLink.textContent = i;
                        pageLink.href = '#';
                        pageLink.onclick = (e) => {
                            e.preventDefault();
                            showPage(i);
                        };
                        pagination.appendChild(pageLink);
                    }
                }

                createPagination();
                showPage(1); // Hiển thị trang đầu tiên
            }

            function clearSearch() {
                // Ẩn tất cả các hàng trước khi thực hiện tìm kiếm
                allRows.forEach(row => row.style.display = 'none');
            }

            function search() {
                clearSearch();
                const query = searchInput.value.toLowerCase();
                const filteredRows = allRows.filter(row => {
                    const productName = row.querySelector('td:nth-child(5)').textContent.toLowerCase(); // Cột Tên sản phẩm
                    return productName.includes(query);
                });

                if (filteredRows.length === 0) {
                    pagination.innerHTML = ''; // Xóa phân trang nếu không có kết quả
                } else {
                    paginate(filteredRows);
                }
            }

            searchButton.onclick = search;

            function init() {
                allRows = Array.from(productBody.getElementsByTagName('tr'));
                paginate(allRows); // Phân trang tất cả sản phẩm
            }

            function toggleAll(source) {
                const checkboxes = document.querySelectorAll('.productCheckbox');
                checkboxes.forEach(checkbox => checkbox.checked = source.checked);
            }

            function deleteProduct(productID) {
                if (confirm('Are you sure you want to delete this product?')) {
                    document.getElementById('productIDToDelete').value = productID;
                    document.getElementById('deleteForm').submit();
                }
            }

            function deleteSelected() {
                const selected = document.querySelectorAll('.productCheckbox:checked');
                if (selected.length === 0) {
                    alert('No products selected');
                    return;
                }

                if (confirm('Are you sure you want to delete selected products?')) {
                    let ids = Array.from(selected).map(cb => cb.value).join(',');
                    document.getElementById('productIDToDelete').value = ids;
                    document.getElementById('deleteForm').submit();
                }
            }


            $(document).ready(function () {
                $('#categoryFilter').select2({
                    placeholder: "Select a category", // Placeholder
                    allowClear: true // Allow clearing the selection
                });
            });

            init(); // Khởi tạo hệ thống phân trang
        </script>
    </body>
</html>
