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
import model.User;

/**
 *
 * @author trant
 */
public class VerifyController extends HttpServlet {

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
            out.println("<title>Servlet VerifyController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet VerifyController at " + request.getContextPath() + "</h1>");
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
        String code = (String) session.getAttribute("code");
        String verifyCode = request.getParameter("verifycode");

        // Lấy thời gian tạo mã từ session
        Long codeCreationTime = (Long) session.getAttribute("codeCreationTime");

        // Kiểm tra thời gian mã có hợp lệ không (ví dụ: 1 phút)
        long timeLimit = 1 * 60 * 1000; // 1 phút

        if (code == null || codeCreationTime == null) {
            request.setAttribute("registerError", "Session expired. Please request a new code.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (System.currentTimeMillis() - codeCreationTime > timeLimit) {
            // Mã đã hết hạn sau 1 phút
            request.setAttribute("registerError", "The reset code has expired. Please request a new one.");
            
            //session.setAttribute("fullName", session.getAttribute("fullName"));
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else if (code.equalsIgnoreCase(verifyCode)) {
            User user = (User) session.getAttribute("registrationData");
            UserDAO userDao = new UserDAO();

            // Tạo người dùng và lấy UserID
            userDao.createUser(user.getFullName(), user.getUsername(), user.getPassword(),
                    user.getEmail(), user.getPhone(), user.getAddress(),
                    "images/users/user.png");

            session.removeAttribute("code");
            session.removeAttribute("registrationData");
            
            request.setAttribute("error", "Register successfully!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        } else {
            session.setAttribute("code", code);
            request.setAttribute("check", "true");
            request.setAttribute("message", "Sorry, verify code incorrect");
            request.getRequestDispatcher("register.jsp").forward(request, response);
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
