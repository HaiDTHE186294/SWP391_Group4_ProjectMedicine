/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package ControllerCustomer.order;

import dal.OrderDAO;
import dal.OrderDetailDAO;
import dal.OrderUserDAO;
import dal.ProductDAO;
import dal.UnitDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order;
import model.OrderDetail;
import model.OrderUser;
import model.ProductPriceQuantity;

/**
 *
 * @author M7510
 */
public class orderCompletion extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private final int DEFAULT_STATUS = 0;
    private final int PAY_STATUS = 1;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productId = request.getParameter("productId");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String unit = request.getParameter("selectedUnit");

        ProductDAO productDAO = new ProductDAO();
        ProductPriceQuantity pp = productDAO.getProductPriceByProductIDandUnitID(productId, unit);
        if (pp != null) {
            UnitDAO unitDAO = new UnitDAO();
            pp.setProduct(productDAO.getProductByID(productId));
            pp.setUnit(unitDAO.getById(unit));
            HashMap<ProductPriceQuantity, Integer> order = new HashMap<>();
            order.put(pp, quantity);
            request.getSession().setAttribute("orders", order);
        }

        request.getRequestDispatcher("cartCompletion.jsp").forward(request, response);
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
        try {
            OrderUserDAO orderUserDAO = new OrderUserDAO();
            OrderDAO orderDAO = new OrderDAO();
            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String paymentMethod = request.getParameter("paymentMethod");
            float totalCost = Float.parseFloat(request.getParameter("totalCost"));
            OrderUser orderUser;
            if (orderUserDAO.userExists(email)) {
                orderUser = orderUserDAO.getUserByEmail(email);
            } else {
                orderUser = new OrderUser(0, fullname, email, phone, address); // Temporary ID of 0
                int userId = orderUserDAO.createUser(orderUser);
                orderUser.setId(userId); // Set the generated ID
            }

            Order order = new Order();
            //
            order.setOrder_date(new Date());
            order.setOrder_total(totalCost);
            switch(paymentMethod){
                case "creditCard" -> order.setStatus(DEFAULT_STATUS);
                case "cashOnDelivery" -> order.setStatus(PAY_STATUS);
            }
            order.setUser_id(orderUser.getId());
            int order_id = orderDAO.addOrder(order);
            if (order_id != -1) {
                HashMap<ProductPriceQuantity, Integer> orders = new HashMap<>();
                if (request.getSession().getAttribute("orders") != null){
                    orders = (HashMap<ProductPriceQuantity, Integer>) request.getSession().getAttribute("orders");
                }
                orders.forEach((k, v) -> {
                    OrderDetail detail = new OrderDetail();
                    detail.setOrder_id(order_id);
                    detail.setProductID(k.getProductID());
                    detail.setUnitID(k.getUnitID());
                    detail.setQuantity(v);
                    detail.setPrice(k.getSalePrice() * v);
                    OrderDetailDAO detailDAO = new OrderDetailDAO();
                    detailDAO.addOrderDetail(detail);
                });
            }
            //todo lead user to pages to further proceed order

            request.getSession().setAttribute("successMessage", "Đặt hàng thành công! Cảm ơn bạn đã mua hàng.");
response.sendRedirect("home"); 

            response.sendRedirect("home.jsp");

        } catch (SQLException ex) {
            Logger.getLogger(orderCompletion.class.getName()).log(Level.SEVERE, null, ex);
        }
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
