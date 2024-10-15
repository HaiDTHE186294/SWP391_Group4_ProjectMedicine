<%-- 
    Document   : insertStaff
    Created on : Oct 16, 2024, 5:02:12 AM
    Author     : kan3v
--%>

<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert Staff</title>
</head>
<body>
    <form action="StaffURL" method="post">
        <input type="hidden" name="service" value="insertStaff">
        <table>
            <caption>Insert Staff</caption>
            <tr>
                <td><label for="staff_id">Staff ID</label></td>
                <td><input type="text" name="staff_id" id="staff_id" required></td>
            </tr>
            <tr>
                <td><label for="full_name">Full Name</label></td>
                <td><input type="text" name="full_name" id="full_name" required></td>
            </tr>
            <tr>
                <td><label for="email">Email</label></td>
                <td><input type="email" name="email" id="email" required></td>
            </tr>
            <tr>
                <td><label for="phone">Phone</label></td>
                <td><input type="text" name="phone" id="phone" required></td>
            </tr>
            <tr>
                <td><label for="status">Status</label></td>
                <td>
                    <select name="status" id="status">
                        <option value="1">Active</option>
                        <option value="0">Inactive</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td><label for="role_id">Role ID</label></td>
                <td><input type="text" name="role_id" id="role_id" required></td>
            </tr>
            <tr>
                <td><label for="address">Address</label></td>
                <td><input type="text" name="address" id="address"></td>
            </tr>
            <tr>
                <td><label for="image">Image URL</label></td>
                <td><input type="text" name="image" id="image"></td>
            </tr>
            <tr>
                <td><input type="submit" value="Insert Staff" name="submit"></td>
                <td><input type="reset" value="Clear"></td>
            </tr>
        </table>
    </form>
</body>
</html>

