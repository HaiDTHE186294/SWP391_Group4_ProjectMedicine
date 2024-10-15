/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.DAOCategory;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
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

            String service = request.getParameter("service");
            if (service == null) {
                service = "listAllCategory";
            }
            if (service.equals("deleteCategory")) {
                dao.removeCategory("CategoryID");
                response.sendRedirect("CategoryURL?service=listAllCategory");
            }
            
            if (service.equals("updateCategory")) {
                String submit = request.getParameter("submit");
                if (submit == null) { //show form
                    String cid = request.getParameter("CategoryID");
                    String sql = "select * from Category where CategoryID = " + cid;
                    ArrayList<Category> list = dao.getCategory(sql);
                    request.setAttribute("list", list);
                    request.getRequestDispatcher("/Category/CategoryUpdateScreen.jsp").forward(request, response);
                } else {
                    String CategoryID = request.getParameter("CategoryID");
                    String Icon = request.getParameter("Icon");
                    String CategoryName = request.getParameter("CategoryName");
                    String ParentCategoryID = request.getParameter("ParentCategoryID");
                    Category pro = new Category(CategoryID, Icon, CategoryName, ParentCategoryID, 1);
                    dao.updateCategory(pro);
                    response.sendRedirect("CategoryURL?service=listAllCategory");
                }
            }
            if (service.equals("insertCategory")) {
                String submit = request.getParameter("submit");
                if (submit == null) { //show form

                    request.getRequestDispatcher("/Category/CategoryAddScreen.jsp").forward(request, response);
                } else {
                    String CategoryID = request.getParameter("CategoryID");
                    String Icon = request.getParameter("Icon");
                    String CategoryName = request.getParameter("CategoryName");
                    String ParentCategoryID = request.getParameter("ParentCategoryID");
                    Category pro = new Category(CategoryID, Icon, CategoryName, ParentCategoryID, 1);
                    dao.insertCategory(pro);
                    response.sendRedirect("CategoryURL?service=listAllCategory");
                }
            }

            if (service.equals("listAllCategory")) {
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
                ArrayList<Category> list = dao.getCategory(sql);
                RequestDispatcher dispatch = request.getRequestDispatcher("/Category/CategoryList.jsp");
                //Set data view
                request.setAttribute("data", list);
                request.setAttribute("tableTitle", "Category manage");
                //run
                dispatch.forward(request, response);
            }
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
