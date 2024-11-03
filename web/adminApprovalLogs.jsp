<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Product" %>
<%@ page import="model.ProductPriceQuantity" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
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
            .edit-button {
                background-color: #007bff; /* Bootstrap primary color */
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
            }
            .edit-button:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }
            .update-button {
                background-color: #007bff; /* Bootstrap primary color */
                color: white;
                padding: 5px 10px;
                border: none;
                border-radius: 4px;
                text-decoration: none;
            }
            .update-button:hover {
                background-color: #0056b3; /* Darker blue on hover */
            }
        </style>
        <%@include file="dashboardHeader.jsp" %>
    </head>
    <body>
        <h2>Admin Approval Logs</h2>

        <table>
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
                    <th>Actions</th> <!-- Added column for actions -->
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
                            <a href="EditApprovalLogServlet?approvalID=${log.approvalID}" class="edit-button">Edit</a> <!-- Edit button -->
                            <a href="ProductDetail?productID=${log.pid}" class="edit-button">View Product</a> <!-- Edit button -->    
                            <a href="Update?productID=${log.pid}" class="update-button">Update Product</a> <!-- Edit button -->                                                      
                        </td>

                    </tr>
                </c:forEach>
            </tbody>
        </table>

    </body>
</html>
