<%-- 
    Document   : insertAccount
    Created on : Oct 16, 2024, 3:27:32 AM
    Author     : kan3v
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="AccountURL" method="post">
            <input type="hidden" name="service" value="insertAccount">
            <table>
                <caption>Add user</caption>
                <tr>
                    <td><label for="fullName">Full Name</label></td>
                    <td><input type="text" name="fullName" id="fullName" required></td>
                </tr>
                <tr>
                    <td><label for="username">Username</label></td>
                    <td><input type="text" name="username" id="username" required></td>
                </tr>
                <tr>
                    <td><label for="password">Password</label></td>
                    <td><input type="text" name="password" id="password" required></td>
                </tr>
                <tr>
                    <td><label for="email">Email</label></td>
                    <td><input type="text" name="email" id="email" required></td>
                </tr>
                <tr>
                    <td><label for="roleId">Role</label></td>
                    <td><input type="text" name="roleId" id="roleId" required></td>
                </tr>
                <tr>
                    <td><label for="phone">Phone</label></td>
                    <td><input type="text" name="phone" id="phone" required></td>
                </tr>
                <tr>
                    <td><label for="address">Address</label></td>
                    <td><input type="text" name="address" id="address" required></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Add" name="submit"></td>
                    <td><input type="reset" value="Clear"></td>
                </tr>
            </table>
        </form>
    </body>
</html>
