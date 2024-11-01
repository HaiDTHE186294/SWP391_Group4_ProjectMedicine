/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.CartDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.DecimalFormat;
import java.util.Map;
import model.Order;
import model.User;

/**
 *
 * @author trant
 */
public class CartController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet CartController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        
        CartDAO cartDao = new CartDAO();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        Order order = cartDao.getOrderNew(user.getUserId());

        if (order != null) {
            request.setAttribute("order", order);
        } else {
            cartDao.createNewOrder(user.getUserId());
            request.setAttribute("mess", "No book in the cart");
        }

        // tính total amount 
//        if (order != null) {
//            double totalAmount = 0;
//            for (OrderDetail oderdetail : order.getOrderDetail()) {
//                totalAmount += oderdetail.getPrice() * oderdetail.getQuantity();
//            }
//
//            // Format totalAmount to two decimal places
//            DecimalFormat df = new DecimalFormat("#.##");
//            String formattedTotalAmount = df.format(totalAmount);
//            request.setAttribute("totalAmount", formattedTotalAmount);
//
//        }

        request.getRequestDispatcher("cart.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }

        String productId = request.getParameter("productId");
        
        int quantity = 1;
        if (request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));
        }

        CartDAO cartDao = new CartDAO();

        Map<String, Object> productData = cartDao.getProductById(productId);

        Order order = cartDao.getOrderNew(user.getUserId());
        
        if (productData != null && !productData.isEmpty()) {   
            float price = ((Number) productData.get("SalePrice")).floatValue();
        }

        boolean addCart = cartDao.addOrUpdateOrderDetail(order.getOrderId(), productId, quantity, price);
       
        response.sendRedirect("cart");
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
