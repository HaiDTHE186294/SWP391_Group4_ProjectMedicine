/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 *
 * @author trant
 */
public class ListProductController extends HttpServlet {

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
            out.println("<title>Servlet ListBookController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListBookController at " + request.getContextPath() + "</h1>");
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
        //processRequest(request, response);
        // Lấy categoryID từ request
        HttpSession session = request.getSession();
        String categoryID = request.getParameter("categoryID");

        // Gọi hàm getProductsByCategory từ DAO
        CategoryDAO categoryDAO = new CategoryDAO();
        List<Map<String, Object>> productList = new ArrayList<>();

        // Sử dụng switch để xử lý categoryID
        switch (categoryID) {
            case "R1":
                // Gọi hàm lấy sản phẩm cho R1
                productList = categoryDAO.getProductsByCategoryR1();
                break;
            case "R2":
                // Gọi hàm lấy sản phẩm cho R2
                productList = categoryDAO.getProductsByCategoryR2();
                break;
            case "R3":
                // Gọi hàm lấy sản phẩm cho R3
                productList = categoryDAO.getProductsByCategoryR3();
                break;
            default:
                // Xử lý các subcategory khác
                productList = categoryDAO.getProductsByCategory(categoryID);
                break;
        }

        // Set danh sách sản phẩm vào request
        request.setAttribute("productList", productList);

        List<String> audienceList = categoryDAO.getAllAudiences();
        session.setAttribute("audienceList", audienceList);

        List<String> countryList = categoryDAO.getAllCountries();
        session.setAttribute("countryList", countryList);

        // Chuyển hướng sang trang JSP để hiển thị dữ liệu
        request.getRequestDispatcher("listproduct.jsp").forward(request, response);
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
