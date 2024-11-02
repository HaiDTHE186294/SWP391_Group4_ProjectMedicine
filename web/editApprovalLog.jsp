<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.AdminApprovalLog" %>
<%@ page import="java.util.Map" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="model.User" %>
<%@ page import="java.util.List" %>
<%@ page import="dal.stockDAO" %>

<%
    // Fetch log from request scope
    AdminApprovalLog log = (AdminApprovalLog) request.getAttribute("log");
    List<User> users = (List<User>) request.getAttribute("userMap");
    Map<Integer, String> statusMap = (Map<Integer, String>) request.getAttribute("statusMap");
    
    if (log == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Approval Log Not Found");
        return; // Prevent further execution if log is not found
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Edit Approval Log</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f8f9fa;
        }
        .form-container {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .submit-button {
            background-color: #007bff;
            color: white;
            padding: 10px 15px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .submit-button:hover {
            background-color: #0056b3;
        }
    </style>
    <%@include file="dashboardHeader.jsp" %>
</head>
<body>

<div class="form-container">
    <h2>Edit Approval Log</h2>
    <form action="AdminApprovalLogServlet" method="post">
        <input type="hidden" name="approvalID" value="<%= log.getApprovalID() %>">
        
        <div class="form-group">
            <label for="pid">Product ID</label>
            <input type="text" id="pid" name="pid" value="<%= log.getPid() %>" readonly>
        </div>
        
        <div class="form-group">
            <label for="pName">Product Name</label>
            <input type="text"  value="<%= log.getpName() %>" readonly="">
        </div>
        
        <div class="form-group">
            <label for="action">Action</label>
            <input type="text" id="action" name="action" value="<%= log.getAction() %>" readonly>
        </div>
        
        <div class="form-group">
            <label for="action">Date Add/Update</label>
            <input type="text" id="action" name="action" value="<%= log.getDate() %>" readonly="">
        </div>

        <div class="form-group">
            <label for="status">Status</label>
            <select id="status" name="status" required>
                <c:forEach var="statusEntry" items="${statusMap}">
                    <option value="${statusEntry.key}" <c:if test="${statusEntry.key == log.getStatus()}">selected</c:if>>${statusEntry.value}</option>
                </c:forEach>
            </select>
        </div>

        <div class="form-group">
            <label for="detail">Detail</label>
            <input type="text" id="detail" name="detail" value="<%= log.getDetail() %>" required>
        </div>

        <div class="form-group">
            <label for="decider">Decider</label>
            <select id="decider" name="decider" required>
                <c:forEach var="user" items="${userMap}">
                    <option value="${user.getUserId()}" <c:if test="${user.getUserId() == log.getDecider()}">selected</c:if>>${user.getUsername()}</option>
                </c:forEach>
            </select>
        </div>

        <button type="submit" class="submit-button">Update Approval Log</button>
    </form>
</div>

</body>
</html>
