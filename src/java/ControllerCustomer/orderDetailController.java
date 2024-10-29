/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package ControllerCustomer;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.OrderUserDAO;
import dal.ProductDAO;
import dal.UnitDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.OrderDetail;
import model.OrderUser;
import model.User;

/**
 *
 * @author M7510
 */
public class orderDetailController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            String orderId = request.getParameter("id");
            if (orderId == null || orderId.isEmpty()) {
                request.setAttribute("errorMessage", "Invalid order ID.");
                request.getRequestDispatcher("/error.jsp").forward(request, response); // Assuming you have an error.jsp
                return;
            }
            UserDAO userDAO = new UserDAO();
            ProductDAO productDAO = new ProductDAO();
            UnitDAO unitDAO = new UnitDAO();
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderdetailDAO = new OrderDetailDAO();
            Order order = orderDAO.getOrderById(orderId);
            List<OrderDetail> detailList = orderdetailDAO.getOrderDetailsByOrderId(order.getOrder_id());
            for (OrderDetail detail : detailList) {
                detail.setProduct(productDAO.getProductByID(detail.getProductID()));
                detail.setUnit(unitDAO.getById(detail.getUnitID()));
            }
            order.setOrderDetail(detailList);
            OrderUserDAO orderuserDAO = new OrderUserDAO();
            OrderUser user = orderuserDAO.getUserById(order.getUser_id());
            order.setSales(userDAO.getUserByID(order.getSales_id()));
            // Check if order exists
            if (order == null) {
                request.setAttribute("errorMessage", "Order not found.");
                request.getRequestDispatcher("/error.jsp").forward(request, response);
                return;
            }
            User u = new User();
            if (request.getSession().getAttribute("User") != null){
                u = (User)request.getSession().getAttribute("User");
            }
            request.setAttribute("isEditable", isEditable(order, u));
            // Set order details in request attributes
            request.setAttribute("order", order);
            request.setAttribute("user", user);
            request.getRequestDispatcher("orderdetails.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(orderDetailController.class.getName()).log(Level.SEVERE, null, ex);
        }
    } 
    
    private boolean isEditable(Order order, User currentUser){
        //user has to be role 1
        if (currentUser.getRoleId() == 1) {
            //and order.salesId must match current user's id
            if (order.getSales_id() == currentUser.getUserId()){
                return true;
            }
        }
        return false;
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
        processRequest(request, response);
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
        processRequest(request, response);
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
