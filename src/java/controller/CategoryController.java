/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAOCategory;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Category;

/**
 *
 * @author kan3v
 */
@WebServlet(name = "CategoryController", urlPatterns = {"/CategoryURL"})
public class CategoryController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOCategory dao = new DAOCategory();
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet CategoryController</title>");
            out.println("<link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css\">");
            out.println("</head>");
            out.println("<body>");
            
            String sql = "select * from Category";
            String submit = request.getParameter("submit");
            String sortColumn = request.getParameter("sortColumn"); // Get sort column from request
            String sortOrder = request.getParameter("sortOrder");   // Get sort order from request

            if (submit != null) { // search or sort
                String cname = request.getParameter("cname");
                if (cname != null && !cname.isEmpty()) {
                    sql = "select * from Category where CategoryName like '%" + cname + "%'";
                }
            }

            // Check if both sortColumn and sortOrder are specified
            if (sortColumn != null && sortOrder != null) {
                sql += " order by " + sortColumn + " " + sortOrder;
            } else {
                sql += " order by CategoryName asc"; // Default sort order if not specified
            }
            List<Category> list = dao.getCategory(sql);
            // Output form and table
            out.print("<form action=\"CategoryURL\" method=\"get\">\n"
                    + "        <p>Search name <input type=\"text\" name=\"cname\" id=\"\">\n"
                    + "            <input type=\"submit\" value=\"Search\" name=\"submit\">\n"
                    + "            <input type=\"reset\" value=\"Clear\">\n"
                    + "        </p>\n"
                    + "        <p>Sort by: \n"
                    + "            <select name=\"sortColumn\">\n"
                    + "                <option value=\"CategoryID\">CategoryID</option>\n"
                    + "                <option value=\"CategoryName\">CategoryName</option>\n"
                    + "                <option value=\"ParentCategoryID\">ParentCategoryID</option>\n"
                    + "            </select>\n"
                    + "            <select name=\"sortOrder\">\n"
                    + "                <option value=\"asc\">Ascending</option>\n"
                    + "                <option value=\"desc\">Descending</option>\n"
                    + "            </select>\n"
                    + "            <input type=\"submit\" value=\"Sort\" name=\"submit\">\n"
                    + "        </p>\n"
                    + "    </form>");

            out.print("<p><a href=\"Category/CategoryAddScreen.jsp\" class=\"button\">Insert Category</a>\n"
                    + "");
            out.print("<table border=\"1\">\n"
                    + "        <tr>\n"
                    + "            <th>CategoryID</th>\n"
                    + "            <th>Icon</th>\n"
                    + "            <th>CategoryName</th>\n"
                    + "            <th>ParentCategoryID</th>\n"
                    + "            <th>update</th>\n"
                    + "            <th>delete</th>\n"
                    + "        </tr>");
            for (Category category : list) {
                out.print("""
                          <tr>
                                      <td>""" + category.getCategoryID() + "</td>\n"
                        + "            <td>" + category.getIcon() + "</td>\n"
                        + "            <td>" + category.getCategoryName() + "</td>\n"
                        + "            <td>" + category.getParentCategoryID() + "</td>\n"
                        + "            <td><a href=\"Category/CategoryUpdateScreen.jsp\"><i class=\"fa fa-pencil-square-o\" aria-hidden=\"true\"></i>Update</a></td>\n"
                        + "            <td><a href=\"\"><i class=\"fa fa-trash-o\" aria-hidden=\"true\"></i>Delete</a></td>\n"
                        + "        </tr>");
            }
            out.print("</table>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
