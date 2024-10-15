<%-- 
    Document   : CategoryList
    Created on : Oct 16, 2024, 4:00:34 AM
    Author     : kan3v
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,model.Category" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <title>JSP Page</title>
    </head>
    <body>
        <%
           ArrayList<Category> list = (ArrayList<Category>)request.getAttribute("data");
           String title =(String)request.getAttribute("tableTitle");
        %>
        <form action="CategoryURL" method="get">
            <p>
                Search name 
                <input type="text" name="cname" id="">
                <input type="submit" value="Search" name="submit">
                <input type="reset" value="Clear">
                <input type="hidden" name="service" value="listAllCategory">
            </p>
            <p>
                Sort by:
                <select name="sortColumn">
                    <option value="CategoryID">Category ID</option>
                    <option value="CategoryName">Category Name</option>
                    <option value="ParentCategoryID">Parent Category ID</option>
                </select>
                <select name="sortOrder">
                    <option value="asc">Ascending</option>
                    <option value="desc">Descending</option>
                </select>
                <input type="submit" value="Sort" name="submit">
            </p>
        </form>

        <p>
            <a href="Category/CategoryAddScreen.jsp" class="button"><input type="button" value="Insert Category" /></a>
        </p>

        <table border="1">
            <tr>
                <th>Category ID</th>
                <th>Icon</th>
                <th>Category Name</th>
                <th>Parent Category ID</th>
                <th>Active</th>
                <th colspan="3">Manage</th>
            </tr>
            <% for (Category category : list) { %>
            <tr>
                <td><%= category.getCategoryID() %></td>
                <td><%= category.getIcon() %></td>
                <td><%= category.getCategoryName() %></td>
                <td><%= category.getParentCategoryID() %></td>
                <td><%= category.getStatus() %></td>
                <td>
                    <a href="CategoryURL?service=updateCategory&CategoryID=<%= category.getCategoryID() %>">
                        <i class="fa fa-pencil-square-o" aria-hidden="true"></i>
                    </a>
                </td>
                <td>
                    <a href="CategoryURL?service=deleteCategory&CategoryID=<%= category.getCategoryID() %>">
                        <i class="fa fa-trash-o" aria-hidden="true"></i>
                    </a>
                </td>
            </tr>
            <% } %>
        </table>

    </body>
</html>
