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
import java.util.List;
import model.Order;
import model.OrderDetail;
import model.User;

/**
 *
 * @author trant
 */
public class CartController extends HttpServlet {

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
            out.println("<title>Servlet CartController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartController at " + request.getContextPath() + "</h1>");
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
        // phân quyền 
        CartDAO cartDao = new CartDAO();

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        //xóa cart
         if(request.getParameter("action") != null){
             String action = request.getParameter("action");
             String orderDetailId = request.getParameter("orderDetailId");
             
             if(action.equalsIgnoreCase("deleteCart")){
                  boolean checkRemove = cartDao.removeCartDetailById(orderDetailId);
                if (checkRemove) {
                    System.out.println("Order detail removed successfully.");
                } else {
                    System.out.println("Failed to remove order detail.");
                }
             }
         }
        
        
        
        

        String status = "Cart";
        Order order = cartDao.getOrderWhereStatus(user.getUserId(), status);

        if (order == null) {

            int userId = user.getUserId();
            double orderTotal = 0;
            String phoneNumber = user.getPhone();
            String address = user.getAddress();
            cartDao.createNewOrder(userId, status, orderTotal, phoneNumber, address);

            request.setAttribute("mess", "Chưa có sản phẩm trong giỏ hàng");
            doGet(request, response);
            return;
        }

        List<OrderDetail> listOrderDetail = cartDao.getListCartDetailByOrderId(order.getOrderId());

        request.setAttribute("order", order);
        request.setAttribute("listOrderDetail", listOrderDetail);

        request.getRequestDispatcher("cart.jsp").forward(request, response);
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
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");

        if (user == null) {
            response.sendRedirect("login");
            return;
        }
        CartDAO cartDao = new CartDAO();

        String orderDetailId = request.getParameter("orderDetailId");

        int quantity = 1;
        if (request.getParameter("quantity") != null) {
            quantity = Integer.parseInt(request.getParameter("quantity"));

            if (quantity <= 0) {
                boolean checkRemove = cartDao.removeCartDetailById(orderDetailId);
                if (checkRemove) {
                    System.out.println("Order detail removed successfully.");
                } else {
                    System.out.println("Failed to remove order detail.");
                }
            }
        }
        //add cart
        if (request.getParameter("action") != null) {
            String action = request.getParameter("action");
            if (action.equalsIgnoreCase("addCart")) {
                String productId = request.getParameter("productId");

                // lấy ra cart
                String status = "Cart";
                Order order = cartDao.getOrderWhereStatus(user.getUserId(), status);
                double price = 0;
                if (order == null) {
                    int userId = user.getUserId();
                    double orderTotal = 0;
                    String phoneNumber = user.getPhone();
                    String address = user.getAddress();
                    cartDao.createNewOrder(userId, status, orderTotal, phoneNumber, address);

                    request.setAttribute("mess", "Chưa có sản phẩm trong giỏ hàng");
                    doPost(request, response);
                    return;
                }
                boolean checkAddCart = cartDao.addCart(order.getOrderId(), productId, price,quantity);
                if (checkAddCart) {
                    System.out.println("Order detail add successfully.");
                } else {
                    System.out.println("Failed to add order detail.");
                }
            }
            doGet(request, response);
            return;
        }

        String idOrder = request.getParameter("idOrder");
        String productId = request.getParameter("ProductID");
        double salePrice = Double.parseDouble(request.getParameter("salePrice"));
        String status = "Cart";

        double price = salePrice * quantity;

        String productUnit = request.getParameter("productUnit");
        request.setAttribute("productUnit", productUnit);

        double check = cartDao.updateCartByOrderDetailId(orderDetailId, idOrder, productId, quantity, price, productUnit);

        doGet(request, response);
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
