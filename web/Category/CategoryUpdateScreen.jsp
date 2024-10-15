<%-- 
    Document   : CategoryUpdateScreen
    Created on : Sep 17, 2024, 11:08:32 PM
    Author     : kan3v
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList,model.Category" %>

<!DOCTYPE html>
<html>
    <%
        ArrayList<Category> list = (ArrayList<Category>)request.getAttribute("list");
        Category category = list.get(0);
    %>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Category Table</title>

    </head>
    <body>

        <form action="CategoryURL" method="post">
            <input type="hidden" name="service" value="updateCategory">
            <table>
                <caption>Update Category Table</caption>
                <tr>
                    <td><label for="CategoryID">Category ID</label></td>
                    <td><input type="text" name="CategoryID" id="CategoryID" value="<%= category.getCategoryID() %>"></td>
                </tr>
                <tr>
                    <td><label for="Icon">Icon</label></td>
                    <td><input type="file" id="icon"></td>
                </tr>
                <tr>
                    <td><label for="CategoryName">Category Name</label></td>
                    <td><input type="text" name="CategoryName" id="CategoryName" value="<%= category.getCategoryName() %>"></td>
                </tr>
                <tr>
                    <td><label for="ParentCategoryID">Parent Category ID</label></td>
                    <td><input type="text" name="ParentCategoryID" id="ParentCategoryID" value="<%= category.getStatus() %>"></td>
                </tr>

                <tr>
                    <td><input type="submit" value="Add" name="submit">
                    <a href="../CategoryURL?service=listAllCategory"><input type="button" value="Back" /></a></td>
                    <td><input type="reset" value="Clear"></td>
                </tr>
            </table>
        </form>

    </body>
</html>
