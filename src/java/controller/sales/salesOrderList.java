/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.sales;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.OrderUserDAO;
import dal.ProductDAO;
import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.OrderDetail;
import model.User;

/**
 *
 * @author M7510
 */
public class salesOrderList extends HttpServlet {

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

        OrderDAO orderDAO = new OrderDAO();
        OrderDetailDAO orderDetailDAO = new OrderDetailDAO();
        ProductDAO productDAO = new ProductDAO();
        OrderUserDAO orderuserDAO = new OrderUserDAO();
        UserDAO userDAO = new UserDAO();
        // Get parameters for pagination and sorting
        int page = Integer.parseInt(request.getParameter("page") != null ? request.getParameter("page") : "1");
        int limit = Integer.parseInt(request.getParameter("limit") != null ? request.getParameter("limit") : "10");
        int offset = (page - 1) * limit;

        // Get parameters for sorting
        String sortColumn = request.getParameter("sortColumn") != null ? request.getParameter("sortColumn") : "order_id";
        String sortOrder = request.getParameter("sortOrder") != null ? request.getParameter("sortOrder") : "ASC";
        
        String fromDate = request.getParameter("from");
        String toDate = request.getParameter("to");
        
        int status = Integer.parseInt((request.getParameter("status") != null && !request.getParameter("status").equals("")) ? request.getParameter("status") : "-1"); // -1 for all statuses
        
        String searchTerm = request.getParameter("search") != null ? request.getParameter("search") : "";
        
        // Fetch the list of orders and the total count based on user ID, status, pagination, and sorting
        List<Order> orders = orderDAO.getOrdersWithSearchAndSort(limit, offset, sortColumn, sortOrder, status, searchTerm, fromDate, toDate);
        for (Order order : orders) {
            try {
                List<OrderDetail> detailList = orderDetailDAO.getOrderDetailsByOrderId(order.getOrder_id());
                for (OrderDetail detail : detailList) {
                    detail.setProduct(productDAO.getProductByID(detail.getProductID()));
                }
                order.setUser(orderuserDAO.getUserById(order.getUser_id()));
                order.setOrderDetail(detailList);
                User u = new User();
                if (userDAO.getUserByID(order.getSales_id()) != null){
                    u = userDAO.getUserByID(order.getSales_id());
                }
                order.setSales(u);
            } catch (SQLException ex) {
                Logger.getLogger(salesOrderList.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        int totalOrders = orderDAO.getTotalOrderCountWithSearchAndStatus(status, searchTerm, fromDate, toDate);
        int totalPages = (int) Math.ceil((double) totalOrders / limit);

        // Set attributes for JSP
        request.setAttribute("orders", orders);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortColumn", sortColumn);
        request.setAttribute("sortOrder", sortOrder);
        request.setAttribute("search", searchTerm);
        request.setAttribute("status", status);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        
        request.setAttribute("statusList", Arrays.asList("Pending", "Submitted", "Delivering", "Completed", "Cancelled", "Refunded"));
        
        request.setAttribute("productList", productDAO.getAllProducts());

        // Forward to the JSP page
        request.getRequestDispatcher("salesOrderList.jsp").forward(request, response);
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
        processRequest(request, response);
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
        processRequest(request, response);
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
