<%-- 
    Document   : ListStaff
    Created on : Oct 16, 2024, 5:06:09 AM
    Author     : kan3v
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,model.Staff" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Staff List</title>
</head>
<body>
    <%
        ArrayList<Staff> staffList = (ArrayList<Staff>) request.getAttribute("data");
        String title = (String) request.getAttribute("tableTitle");
    %>
    <form action="StaffURL" method="get">
        <p>Search name: <input type="text" name="pname" id="">
            <input type="submit" value="Search" name="submit">
            <input type="reset" value="Clear">
        </p>
    </form>
    <p><a href="StaffURL?service=insertStaff">Insert Staff</a></p>

    <table border="1">
        <caption><%= title %></caption>
        <tr>
            <th>Staff ID</th>
            <th>Full Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Status</th>
            <th>Role ID</th>
            <th>Address</th>
            <th>Image URL</th>
            <th>Update</th>
            <th>Delete</th>
        </tr>
        <% for (Staff staff : staffList) { %>
        <tr>
            <td><%= staff.getStaffId() %></td>
            <td><%= staff.getFullName() %></td>
            <td><%= staff.getEmail() %></td>
            <td><%= staff.getPhone() %></td>
            <td><%= staff.getStatus() == 1 ? "Active" : "Inactive" %></td>
            <td><%= staff.getRoleId() %></td>
            <td><%= staff.getAddress() %></td>
            <td><%= staff.getImage() %></td>
            <td><a href="StaffURL?service=updateStaff&stid=<%= staff.getStaffId() %>"><i class="fa fa-pencil-square-o" aria-hidden="true">Update</i></a></td>
            <td><a href="StaffURL?service=deleteStaff&stid=<%= staff.getStaffId() %>"><i class="fa fa-trash-o" aria-hidden="true">Delete</i></a></td>
        </tr>
        <% } %>
    </table>
</body>
</html>