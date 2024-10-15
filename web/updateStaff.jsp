<%-- 
    Document   : updateStaff
    Created on : Oct 16, 2024, 5:02:20 AM
    Author     : kan3v
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList,model.Staff" %>

<!DOCTYPE html>
<html>
<%
    ArrayList<Staff> staffList = (ArrayList<Staff>) request.getAttribute("data");
    Staff staff = staffList.get(0);
%>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Update Staff</title>
</head>
<body>
    <form action="StaffURL" method="post">
        <input type="hidden" name="service" value="updateStaff">
        <table>
            <caption>Update Staff</caption>
            <tr>
                <td><label for="staff_id">Staff ID</label></td>
                <td><input type="text" name="staff_id" id="staff_id" value="<%= staff.getStaffId() %>" readonly></td>
            </tr>
            <tr>
                <td><label for="full_name">Full Name</label></td>
                <td><input type="text" name="full_name" id="full_name" required value="<%= staff.getFullName() %>"></td>
            </tr>
            <tr>
                <td><label for="email">Email</label></td>
                <td><input type="email" name="email" id="email" required value="<%= staff.getEmail() %>"></td>
            </tr>
            <tr>
                <td><label for="phone">Phone</label></td>
                <td><input type="text" name="phone" id="phone" required value="<%= staff.getPhone() %>"></td>
            </tr>
            <tr>
                <td><label for="status">Status</label></td>
                <td>
                    <select name="status" id="status">
                        <option value="1" <%= staff.getStatus() == 1 ? "selected" : "" %>>Active</option>
                        <option value="0" <%= staff.getStatus() == 0 ? "selected" : "" %>>Inactive</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="role_id">Role ID</label></td>
                <td><input type="text" name="role_id" id="role_id" required value="<%= staff.getRoleId() %>"></td>
            </tr>
            <tr>
                <td><label for="address">Address</label></td>
                <td><input type="text" name="address" id="address" value="<%= staff.getAddress() %>"></td>
            </tr>
            <tr>
                <td><label for="image">Image URL</label></td>
                <td><input type="text" name="image" id="image" value="<%= staff.getImage() %>"></td>
            </tr>
            <tr>
                <td><input type="submit" value="Update Staff" name="submit"></td>
                <td><input type="reset" value="Clear"></td>
            </tr>
        </table>
    </form>
</body>
</html>

