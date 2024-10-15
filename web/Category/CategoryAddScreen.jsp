<%-- 
    Document   : CategoryAddScreen
    Created on : Sep 17, 2024, 11:08:04 PM
    Author     : kan3v
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Category Table</title>

    </head>
    <body>

        <form action="CategoryURL" method="post">
            <input type="hidden" name="service" value="insertCategory">
            <table>
                <caption>Add Category Table</caption>
                <tr>
                    <td><label for="CategoryID">Category ID</label></td>
                    <td><input type="text" name="CategoryID" id="CategoryID"></td>
                </tr>
                <tr>
                    <td><label for="Icon">Icon</label></td>
                    <td><input type="file" id="icon"></td>
                </tr>
                <tr>
                    <td><label for="CategoryName">Category Name</label></td>
                    <td><input type="text" name="CategoryName" id="CategoryName"></td>
                </tr>
                <tr>
                    <td><label for="ParentCategoryID">Parent Category ID</label></td>
                    <td><input type="text" name="ParentCategoryID" id="ParentCategoryID"></td>
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
