<%-- 
    Document   : AccountList
    Created on : Oct 7, 2024, 8:09:12 AM
    Author     : kan3v
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,model.User" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <%
           ArrayList<User> list = (ArrayList<User>)request.getAttribute("data");
           String title =(String)request.getAttribute("tableTitle");
        %>
        <h1>Account Management</h1>
        <form action="AccountURL" method="get">
            <p>Search name <input type="text" name="cname" id="">
                <input type="submit" value="Search" name="submit">
                <input type="reset" value="Clear">
            </p>
        </form>
        <table border="1">
            <tr>
            <h3><%=title%></h3>        <p><a href="insertAccount.jsp"><input type="button" value="Add New User" /></a></p>
            <th colspan="2">User Name</th>
            <th>Image</th>
            <th colspan="2">Role</th>
            <th>Status</th>
            <th colspan="2">Manage</th>
        </tr>
        <%for (User user : list) {%>
        <tr>
            <td colspan="2"><%=user.getFullName()%></td>
            <td><%=user.getImage()%></td>
            <td colspan="2"><%=user.getRoleId()%></td>
            <td><%=user.getStatus()%></td>
            <td colspan="2"><a href="profile.jsp"><i class="fa fa-pencil-square-o" aria-hidden="true">View</i> </a>
        </tr>
        <%}%>
    </table>
</body>
</html>
