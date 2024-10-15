/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.User;

/**
 *
 * @author kan3v
 */
@WebServlet(name = "AccountController", urlPatterns = {"/AccountURL"})
public class AccountController extends HttpServlet {

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
        UserDAO dao = new UserDAO();
        try (PrintWriter out = response.getWriter()) {
            String service = request.getParameter("service");

//            if (service.equals("deleteAccount")) {
//                dao.removeUser("userId");
//                response.sendRedirect("AccountURL?service=listAllAccount");
//            }
            if (service == null) {
                service = "listAllAccount";
            }
            if (service.equals("insertAccount")) {
                String submit = request.getParameter("submit");
                if (submit == null) { //show form

                    request.getRequestDispatcher("insertAccount.jsp").forward(request, response);
                } else {
                    String fullName = request.getParameter("fullName");
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    String email = request.getParameter("email");
                    String roleId = request.getParameter("roleId");
                    String phone = request.getParameter("phone");
                    String address = request.getParameter("address");
                    String image = request.getParameter("images");
                    int roleID = Integer.parseInt(roleId);
                    dao.insertUser(fullName, username, password, email, roleID, phone, address, image);
                    response.sendRedirect("AccountURL?service=listAllAccount");
                }
            }

            if (service.equals("listAllAccount")) {
                String sql = "SELECT full_name, image, role_id ,status FROM users";
                String submit = request.getParameter("submit");
                if (submit != null) { //search
                    String cname = request.getParameter("cname").trim();
                    sql = "select * from users where full_name like '%" + cname + "%'";
                }
                ArrayList<User> list = dao.getAllUsers(sql);
                RequestDispatcher dispatch = request.getRequestDispatcher("/AccountList.jsp");
                //Set data view
                request.setAttribute("data", list);
                request.setAttribute("tableTitle", "All User");
                //run
                dispatch.forward(request, response);
            }

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
