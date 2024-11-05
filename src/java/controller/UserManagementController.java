/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Random;
import model.Email;
import model.User;

/**
 *
 * @author trant
 */
public class UserManagementController extends HttpServlet {

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
            out.println("<title>Servlet UserManagementController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UserManagementController at " + request.getContextPath() + "</h1>");
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
        UserDAO userDAO = new UserDAO();

        // Get the "role" parameter from the request
        String role = request.getParameter("role");

        if (role == null || "staff".equals(role)) {
            // If "role" is "staff", get the staff list and forward to stafflist.jsp
            List<User> staff = userDAO.getAllUsersWithRoleId(3);
            request.setAttribute("userList", staff);
            request.getRequestDispatcher("stafflist.jsp").forward(request, response);
        } else if ("customer".equals(role)) {
            // If "role" is "customer", get the customer list and forward to customerlist.jsp
            List<User> customers = userDAO.getAllUsersWithRoleId(2);
            request.setAttribute("userList", customers);
            request.getRequestDispatcher("customerlist.jsp").forward(request, response);
        } else if ("admin".equals(role)) {
            List<User> staffList = userDAO.getTop5Staff();
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("addstaff.jsp").forward(request, response);
        } else {
            // Default case (if "role" is missing or unrecognized), handle as needed
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid role parameter.");
        }
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
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        UserDAO userDao = new UserDAO();

        // Extract username from email by splitting at "@"
        String username = email.split("@")[0];

        // Generate random password
        String password = generateRandomString(6);

        if (userDao.checkStaffExists(username, email, phone)) {
            request.setAttribute("addError", "Add failed. Email or phone might already be taken!");
            request.getRequestDispatcher("addstaff.jsp").forward(request, response);
        } else {
            // Create new user
            userDao.createStaff(fullName, username, password, email, phone, address, "images/users/user.png");

            // Send email with the new user's information
            Email handleEmail = new Email();
            String subject = handleEmail.subjectStaffInfor();
            String msgEmail = handleEmail.messageStaffInfor(username, password);
            handleEmail.sendEmail(subject, msgEmail, email);

            response.sendRedirect("usermanagement");
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

    // Method to generate a random string of a given length
    private String generateRandomString(int length) {
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
        StringBuilder sb = new StringBuilder(length);
        Random random = new Random();
        for (int i = 0; i < length; i++) {
            sb.append(chars.charAt(random.nextInt(chars.length())));
        }
        return sb.toString();
    }

}
