<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<!DOCTYPE html>
<html>
    <head>
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
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Manage > Product Manage</h2>
            <div class="search-bar">
                <select>
                    <option>Category</option>
                    <!-- Add more options here -->
                </select>
                <select>
                    <option>Date</option>
                    <!-- Add more options here -->
                </select>
                <select>
                    <option>Price</option>
                    <!-- Add more options here -->
                </select>
                <select>
                    <option>Status</option>
                    <!-- Add more options here -->
                </select>
                <input type="text" id="searchInput" placeholder="Type here to search" />
                <button id="searchButton">Search</button>
            </div>

            <div>
                <form id="deleteForm" action="ProductDeleteServlet" method="post">
                    <input type="hidden" name="productID" id="productIDToDelete">
                    <button type="button" onclick="deleteSelected()">Delete Selected</button>
                </form>
                <button onclick="window.location.href = 'product/addxx'">Add</button>
            </div>

            <table id="productTable">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="selectAll" onclick="toggleAll(this)" /></th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>ID</th>
                        <th>Status</th>
                        <th>Total Sold</th>
                        <th>Version</th>
                        <th>Date</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody id="productBody">
                    <%
                        List<Product> productList = (List<Product>) request.getAttribute("productList");
                        if (productList != null && !productList.isEmpty()) {
                            for (Product product : productList) {
                    %>
                    <tr>
                        <td><input type="checkbox" value="<%= product.getProductID() %>" class="productCheckbox" /></td>
                        <td><img src="<%= product.getImagePath() %>" alt="Product Image" width="50" /></td>
                        <td><%= product.getProductName() %></td> <!-- Tên sản phẩm -->
                        <td><%= product.getProductID() %></td>
                        <td><%= product.getStatus() %></td>
                        <td><%= product.getSold() %></td>
                        <td><%= product.getProductVersion() %></td>
                        <td><%= product.getDateCreated() %></td>
                        <td class="actions">
                            <button type="button" onclick="deleteProduct('<%= product.getProductID() %>')">Delete</button>
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

            let allRows = []; // Lưu trữ tất cả các hàng để tìm kiếm

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
                    const productName = row.querySelector('td:nth-child(3)').textContent.toLowerCase();
                    return productName.includes(query);
                });

                // Nếu không tìm thấy hàng nào, ẩn tất cả
                if (filteredRows.length === 0) {
                    allRows.forEach(row => row.style.display = 'none');
                    pagination.innerHTML = ''; // Xóa phân trang nếu không có kết quả
                } else {
                    // Hiển thị phân trang cho danh sách đã lọc
                    paginate(filteredRows);
                }
            }

            searchButton.onclick = search;

            // Khởi tạo bảng và phân trang
            function init() {
                allRows = Array.from(productBody.getElementsByTagName('tr'));
                paginate(allRows); // Phân trang tất cả sản phẩm
            }

            // Hàm chọn tất cả sản phẩm
            function toggleAll(source) {
                const checkboxes = document.querySelectorAll('.productCheckbox');
                checkboxes.forEach(checkbox => checkbox.checked = source.checked);
            }

            // Hàm xóa sản phẩm
            function deleteProduct(productID) {
                if (confirm('Are you sure you want to delete this product?')) {
                    document.getElementById('productIDToDelete').value = productID;
                    document.getElementById('deleteForm').submit();
                }
            }

            // Hàm xóa nhiều sản phẩm được chọn
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

            init(); // Khởi tạo hệ thống phân trang
        </script>

    </body>
</html>
