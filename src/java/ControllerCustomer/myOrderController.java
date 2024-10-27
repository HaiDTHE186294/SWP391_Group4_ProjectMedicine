/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package ControllerCustomer;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.OrderUserDAO;
import dal.ProductDAO;
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
import model.User;

/**
 *
 * @author M7510
 */
public class myOrderController extends HttpServlet {
   
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
            response.setContentType("text/html;charset=UTF-8");
            
            // Get parameters for pagination
            int limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "5");
            int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
            int offset = (page - 1) * limit;
            String sortColumn = request.getParameter("sortColumn") != null ? request.getParameter("sortColumn") : "order_date";
            String sortOrder = request.getParameter("sortOrder") != null ? request.getParameter("sortOrder") : "DESC";
            
            // Get the order status from the request (default to -1 for all)
            String statusParam = request.getParameter("status");
            int status = (statusParam != null && !statusParam.isEmpty()) ? Integer.parseInt(statusParam) : -1;
            
            OrderDAO orderDAO = new OrderDAO();
            OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
            ProductDAO productDAO = new ProductDAO();
            OrderUserDAO orderuserDAO = new OrderUserDAO();
            int userId = orderuserDAO.getUserByEmail(((User) request.getSession(true).getAttribute("User")).getEmail()).getId();
            int totalOrders = orderDAO.getTotalOrderCountByUserIdAndStatus(userId, status); // Get total orders by status
            int totalPages = (int) Math.ceil((double) totalOrders / limit); // Calculate total pages
            
            // Get orders with pagination and status filtering
            List<Order> orderList = orderDAO.getOrdersByUserIdWithPaginationAndStatus(userId, limit, offset, sortColumn, sortOrder, status);
            
            // Fetch details for each order
            for (Order order : orderList) {
                List<OrderDetail> detailList = orderDetailDAO.getOrderDetailsByOrderId(order.getOrder_id());
                for (OrderDetail detail : detailList) {
                    detail.setProduct(productDAO.getProductByID(detail.getProductID()));
                }
                order.setOrderDetail(detailList);
            }

            request.setAttribute("orderList", orderList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("limit", limit);
            request.setAttribute("sortColumn", sortColumn);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("currentStatus", status); // Pass the current status to the JSP
            request.getRequestDispatcher("myorder.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(myOrderController.class.getName()).log(Level.SEVERE, null, ex);
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
