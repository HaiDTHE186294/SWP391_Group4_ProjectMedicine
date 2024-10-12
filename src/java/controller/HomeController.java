/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.Product;

/**
 *
 * @author trant
 */
public class HomeController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet HomeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet HomeController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        CategoryDAO categoryDao = new CategoryDAO();
        
        // 1. Get and store R1 categories and subcategories
        List<Category> listCategoryR1 = categoryDao.getAllCategoriesR1();
        session.setAttribute("listCategoryR1", listCategoryR1);

        Map<String, List<Category>> subcategoriesMapR1 = new HashMap<>();
        for (Category category : listCategoryR1) {
            List<Category> subcategories = categoryDao.getSubcategoriesByParent(category.getCategoryID());
            subcategoriesMapR1.put(category.getCategoryID(), subcategories);
        }
        session.setAttribute("subcategoriesMapR1", subcategoriesMapR1);

        // 2. Get and store R2 categories and subcategories
        List<Category> listCategoryR2 = categoryDao.getAllCategoriesR2();
        session.setAttribute("listCategoryR2", listCategoryR2);

        Map<String, List<Category>> subcategoriesMapR2 = new HashMap<>();
        for (Category category : listCategoryR2) {
            List<Category> subcategories = categoryDao.getSubcategoriesByParent(category.getCategoryID());
            subcategoriesMapR2.put(category.getCategoryID(), subcategories);
        }
        session.setAttribute("subcategoriesMapR2", subcategoriesMapR2);

        // 3. Get and store R3 categories and subcategories
        List<Category> listCategoryR3 = categoryDao.getAllCategoriesR3();
        session.setAttribute("listCategoryR3", listCategoryR3);

        Map<String, List<Category>> subcategoriesMapR3 = new HashMap<>();
        for (Category category : listCategoryR3) {
            List<Category> subcategories = categoryDao.getSubcategoriesByParent(category.getCategoryID());
            subcategoriesMapR3.put(category.getCategoryID(), subcategories);
        }
        session.setAttribute("subcategoriesMapR3", subcategoriesMapR3);

        // 4. Get the top 8 sold products
        ProductDAO productDao = new ProductDAO();
        List<Product> listTop8SoldProduct = productDao.getTop8SoldProduct();
        request.setAttribute("listTop8SoldProduct", listTop8SoldProduct);

        // Forward the request to the home.jsp page
        request.getRequestDispatcher("home.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
