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
        <script>
            function checkBatchNo() {
                var input = document.getElementById("batchNo");
                var manufactureDate = document.getElementById("dateManufacture");
                var expiryDate = document.getElementById("dateExpired");
                var provider = document.getElementById("provider");
                var messageElement = document.getElementById("batchMessage");

                // If batchNo is empty, disable the fields
                if (!input.value) {
                    manufactureDate.disabled = true;
                    expiryDate.disabled = true;
                    provider.disabled = true;
                    messageElement.innerText = ""; // Clear message
                } else {
                    // If batchNo has a value, enable the fields
                    manufactureDate.disabled = false;
                    expiryDate.disabled = false;
                    provider.disabled = false;
                    messageElement.innerText = ""; // Clear message
                }
            }
        </script>

        <%@ include file="dashboardHeader.jsp" %>
    </head>
    <body>
        <h1>Import Product</h1>

        <%
            // Retrieve the productID from the request attribute
            String productID = (String) request.getAttribute("productID");
    
            // Fetch product details using the productID
            ProductDAO productDAO = new ProductDAO();
            stockDAO sDAO = new stockDAO();
            Product product = productDAO.getProductByID(productID); 
            List<Stock> stock = sDAO.getAllStocksByPid(productID); 
            ProductPriceQuantity ppq = (ProductPriceQuantity) request.getAttribute("ppq");
            
  
            int userId = (Integer)session.getAttribute("userId"); 



            // Check if the product was found
            if (product != null) {
        %>

        <script>
            window.onload = function () {
                checkBatchNo();
            };
        </script>



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

            <%
                List<Stock> stocks = (List<Stock>) request.getAttribute("stocks");
                String placeholder = (stocks == null || stocks.isEmpty()) ? "Trong kho trống" : "Chọn hoặc nhập Batch No";
            %>

            <label for="batchNo" class="form-label">Batch No:</label>
            <div class="custom-container">
                <input type="text" id="batchNo" name="batchNo" placeholder="<%= placeholder %>" list="batchNoList" class="custom-input" readonly required>

                <select id="batchNoSelect" name="batchNoSelect" onchange="checkCustomOption()" class="custom-select" required>
                    <option value="" disabled selected>Chọn hoặc nhập Batch No</option>
                    <%
                        if (stocks != null && !stocks.isEmpty()) {
                            for (Stock st : stocks) {
                    %>
                    <option value="<%= st.getBatchNo() %>"><%= st.getBatchNo() %></option>
                    <%
                            }
                        }
                    %>
                    <option value="custom">Nhập thủ công...</option>
                </select>
            </div>

            <label for="provider">Provider:</label>
            <input type="text" id="provider" name="provider" required maxlength="100">

            <script>
                function checkCustomOption() {
                    var select = document.getElementById("batchNoSelect");
                    var input = document.getElementById("batchNo");
                    var manufactureDate = document.getElementById("dateManufacture");
                    var expiryDate = document.getElementById("dateExpired");
                    var provider = document.getElementById("provider");
                    var messageElement = document.getElementById("batchMessage"); // Element to display the message


                    if (select.value === "custom") {
                        input.value = "";
                        input.readOnly = false;
                        input.placeholder = "Nhập Batch No";
                        input.focus();
                        manufactureDate.disabled = false;
                        expiryDate.disabled = false;
                        provider.disabled = false;
                        messageElement.innerText = ""; // Clear the message
                    } else {
                        input.value = select.value;
                        input.readOnly = true;
                        input.placeholder = "<%= placeholder %>";
                        manufactureDate.disabled = true;
                        provider.disabled = true;
                        expiryDate.disabled = true;
                        messageElement.innerText = "The manufacture/expiry date and provider for this batch already exists."; // Display the message
                    }
                }
            </script>

            <style>
                /* Container for the input and select fields */
                .custom-container {
                    display: flex;
                    flex-direction: column;
                    max-width: 400px;
                    margin: 20px 0;
                }

                /* Label styling */
                .form-label {
                    font-size: 16px;
                    font-weight: bold;
                    margin-bottom: 8px;
                    color: #333;
                }

                /* Input styling */
                .custom-input {
                    width: 100%;
                    padding: 10px;
                    font-size: 16px;
                    border: 2px solid #ccc;
                    border-radius: 8px;
                    transition: border-color 0.3s, box-shadow 0.3s;
                    margin-bottom: 10px;
                }

                .custom-input:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                }

                /* Select dropdown styling */
                .custom-select {
                    width: 100%;
                    padding: 10px;
                    font-size: 16px;
                    border: 2px solid #ccc;
                    border-radius: 8px;
                    background-color: #fff;
                    cursor: pointer;
                    transition: border-color 0.3s, box-shadow 0.3s;
                }

                .custom-select:hover,
                .custom-select:focus {
                    border-color: #007bff;
                    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
                }

                /* Arrow styling for select dropdown */
                .custom-select {
                    appearance: none; /* Removes default arrow */
                    background-image: url('data:image/svg+xml;charset=US-ASCII,%3Csvg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 4 5"%3E%3Cpath fill="%23999" d="M2 0L0 2h4z"/%3E%3C/svg%3E');
                    background-repeat: no-repeat;
                    background-position: right 10px center;
                    background-size: 8px 10px;
                }

                .custom-select::-ms-expand {
                    display: none; /* Removes the dropdown arrow in IE */
                }
            </style>




            <div id="batchMessage" style="color: red; margin-top: 10px; margin-bottom: 10px;"></div>

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

    </body>
</html>
