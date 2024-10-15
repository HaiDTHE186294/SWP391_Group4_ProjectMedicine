<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="dal.*" %>
<html>
    <head>
        <title>Import Product</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 20px;
                background-color: #f8f9fa;
            }
            h1 {
                color: #333;
            }
            form {
                background-color: #ffffff;
                border: 1px solid #ced4da;
                border-radius: 5px;
                padding: 20px;
                margin-bottom: 20px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
            label {
                display: block;
                margin-bottom: 8px;
                font-weight: bold;
            }
            input[type="text"],
            input[type="number"],
            input[type="date"],
            input[type="submit"] {
                width: 100%;
                padding: 10px;
                margin-bottom: 15px;
                border: 1px solid #ced4da;
                border-radius: 5px;
                box-sizing: border-box; /* Make sure padding is included in total width */
            }
            input[type="submit"] {
                background-color: #28a745; /* Green color */
                color: white;
                cursor: pointer;
                border: none;
            }
            input[type="submit"]:hover {
                background-color: #218838; /* Darker green on hover */
            }
            .back-link {
                display: inline-block;
                margin-top: 10px;
                text-decoration: none;
                color: #007bff;
            }
            .back-link:hover {
                text-decoration: underline;
            }
            .ppq-container {
                display: flex;
                justify-content: space-between; /* Space between elements */
                gap: 10px; /* Space between each ppq field */
                margin-bottom: 15px; /* Margin below the ppq row */
            }
            .ppq-container div {
                flex: 1; /* Each item takes equal space */
            }
            .readonly {
                background-color: #e9ecef; /* Light gray background for readonly inputs */
            }
        </style>
        <%@ include file="dashboardHeader.jsp" %>
    </head>
    <body>
        <h1>Import Product</h1>

        <%
            // Retrieve the productID from the request attribute
            String productID = (String) request.getAttribute("productID");
    
            // Fetch product details using the productID
            ProductDAO productDAO = new ProductDAO();
            Product product = productDAO.getProductByID(productID); 
            ProductPriceQuantity ppq = (ProductPriceQuantity) request.getAttribute("ppq");
            
  
            int userId = (Integer)session.getAttribute("userId"); 



            // Check if the product was found
            if (product != null) {
        %>



        <form action="importServlet" method="post">

            <div class="ppq-container">
                <div>
                    <label for="productID">Product Name</label>
                    <input type="text" name="productName" value="<%= product.getProductName() %>" readonly class="readonly">
                </div>
                <div>
                    <label for="productID">Product ID</label>
                    <input type="text" name="productID" value="<%= product.getProductID() %>" readonly class="readonly">
                </div>
            </div>

            <div class="ppq-container">
                <div>
                    <label for="baseUnitId">Base Unit ID:</label>
                    <input type="text" id="baseUnitId" name="baseUnitId" value="<%= ppq != null ? ppq.getUnitID() : "" %>" readonly class="readonly">
                </div>
                <div>
                <%
    String baseUnitName = (String) request.getAttribute("baseUnitName");
                %>

                <!-- Display the baseUnitName in the form -->
                <label for="baseUnitName">Base Unit Name:</label>
                <input type="text" id="baseUnitName" name="baseUnitName" value="<%= baseUnitName %>" readonly class="readonly">
                </div>
                <div>
                    <label for="productUnitID">Product Unit ID:</label>
                    <input type="text" id="productUnitID" name="productUnitID" value="<%= ppq != null ? ppq.getProductUnitID() : "" %>" readonly class="readonly">
                </div>
                <div>
                    <label for="unitStatus">Unit Status:</label>
                    <input type="number" id="unitStatus" name="unitStatus" value="<%= ppq != null ? ppq.getUnitStatus() : "" %>" readonly class="readonly">
                </div>
                <div>
                    <label for="unitStatus">Sale price (VND)</label>
                    <input type="number" id="unitStatus" name="unitStatus" value="<%= ppq != null ? ppq.getSalePrice() : "" %>" readonly class="readonly">
                </div>
            </div>

            <label for="provider">Provider:</label>
            <input type="text" id="provider" name="provider" required>

            <%
                List<Stock> stocks = (List<Stock>) request.getAttribute("stocks");
                String placeholder = (stocks == null || stocks.isEmpty()) ? "Trong kho trống" : "Chọn hoặc nhập Batch No";
            %>

            <label for="batchNo">Batch No:</label>
            <input type="text" id="batchNo" name="batchNo" list="batchNoList" required placeholder="<%= placeholder %>">

            <datalist id="batchNoList">
                <%
                    if (stocks != null && !stocks.isEmpty()) {
                        for (Stock stock : stocks) {
                %>
                <option value="<%= stock.getBatchNo() %>"></option>
                <%
                        }
                    }
                %>
            </datalist>



            <label for="dateManufacture">Date of Manufacture:</label>
            <input type="date" id="dateManufacture" name="dateManufacture" required>

            <label for="dateExpired">Date of Expiry:</label>
            <input type="date" id="dateExpired" name="dateExpired" required>

            <label for="priceImport">Price Import:</label>
            <input type="number" id="priceImport" name="priceImport" step="0.01" required>

            <label for="importer">Importer:</label>
            <input type="number" min="0" id="importer" name="importer" value="<%= userId %>" readonly class="readonly">

            <label for="quantity">Quantity</label>
            <input type="number" min="0" id="quantity" name="quantity" required="">



            <input type="submit" value="Import">
        </form>

        <%
            } else {
        %>
        <p>Product not found!</p>
        <%
            }
        %>

        <a href="ProductList.jsp" class="back-link">Back to Product List</a>
    </body>
</html>
