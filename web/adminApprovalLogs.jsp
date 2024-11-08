<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.*" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <%
Integer userRoleID = (Integer) session.getAttribute("userRoleID");
if (userRoleID == null || userRoleID == 2) {
   // Điều hướng về trang đăng nhập nếu roleID không hợp lệ
   response.sendRedirect("login.jsp");
   return; // Ngừng xử lý JSP
}
    %>
    <head>
        <title>Admin Approval Logs</title>
        <style>
            table {
                width: 100%;
                border-collapse: collapse;
            }
            th, td {
                padding: 8px;
                border: 1px solid #ddd;
                text-align: left;
            }
            th {
                background-color: #f2f2f2;
            }
            .button {
                background-color: #007bff;
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
                margin-right: 5px;
            }
            .button:hover {
                background-color: #0056b3;
            }
        </style>
        <%@include file="dashboardHeader.jsp" %>
        <script>
            function searchLogs() {
                // Get the search query
                let input = document.getElementById('searchBar').value.toUpperCase().trim();
                let table = document.getElementById('logTable');
                let rows = table.getElementsByTagName('tr');

                // Loop through table rows and hide those that don't match the search
                for (let i = 1; i < rows.length; i++) {
                    let productID = rows[i].getElementsByTagName('td')[1].textContent || "";
                    let productName = rows[i].getElementsByTagName('td')[2].textContent || "";
                    if (productID.toUpperCase().includes(input) || productName.toUpperCase().includes(input)) {
                        rows[i].style.display = "";
                    } else {
                        rows[i].style.display = "none";
                    }
                }
            }
        </script>
    </head>
    <body>
        <h2>Admin Approval Logs</h2>
         <!-- Search bar -->
        <input type="text" id="searchBar" onkeyup="searchLogs()" placeholder="Search by Product ID or Name">


        <!-- Filter buttons -->
        <div>
            <a href="AdminApprovalLogServlet?status=3" class="button">Pending</a>
            <a href="AdminApprovalLogServlet?status=processed" class="button">Processed</a>
            <a href="AdminApprovalLogServlet?status=4" class="button">Rejected</a>
        </div>

        <table id="logTable">
            <thead>
                <tr>
                    <th>Approval ID</th>
                    <th>Product ID</th>
                    <th>Product Name</th>
                    <th>Action</th>
                    <th>Status</th>
                    <th>Detail</th>
                    <th>Decider</th>
                    <th>Date</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="log" items="${logList}">
                    <tr>
                        <td>${log.approvalID}</td>
                        <td>${log.pid}</td>
                        <td>${log.pName}</td>
                        <td>${log.action}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty statusMap[log.status]}">
                                    ${statusMap[log.status]}
                                </c:when>
                                <c:otherwise>
                                    Unknown Status
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${log.detail}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty userMap[log.decider]}">
                                    ${userMap[log.decider]}
                                </c:when>
                                <c:otherwise>
                                    Unknown Decider
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>${log.date}</td>
                        <td>
                            <c:if test="${log.status == 3}"> <!-- Replace '3' with the correct status value for "Pending" if different -->
                                <a href="EditApprovalLogServlet?approvalID=${log.approvalID}" class="button">Review</a>
                            </c:if>
                            <a href="ProductDetail?productID=${log.pid}" class="button">View Product</a>
                            <a href="Update?productID=${log.pid}" class="button">Update Product</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </body>
</html>
