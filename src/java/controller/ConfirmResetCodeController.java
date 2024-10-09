/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author trant
 */
@WebServlet(name = "ConfirmResetCodeController", urlPatterns = {"/confirmresetcode"})
public class ConfirmResetCodeController extends HttpServlet {

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
            out.println("<title>Servlet ConfirmResetCodeController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ConfirmResetCodeController at " + request.getContextPath() + "</h1>");
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
        UserDAO ud = new UserDAO();
        String resetCode = request.getParameter("resetcode");
        String code = (String) session.getAttribute("code");

        // Lấy thời gian tạo mã từ session
        Long codeCreationTime = (Long) session.getAttribute("codeCreationTime");

        // Kiểm tra thời gian mã có hợp lệ không (ví dụ: 1 phút)
        long timeLimit = 1 * 60 * 1000; // 1 phút

        String email = request.getParameter("email");
//        String message = (String) request.getAttribute("message");
//        String check = (String) request.getAttribute("check");

       if (code == null || codeCreationTime == null) {
            request.setAttribute("expiredMessage", "Session expired. Please request a new code.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
            return;
        }

        if (System.currentTimeMillis() - codeCreationTime > timeLimit) {
            // Mã đã hết hạn sau 1 phút
            request.setAttribute("expiredMessage", "The reset code has expired. Please request a new one.");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
        } else if (code.equalsIgnoreCase(resetCode)) {
            String userName = ud.getUserNameByEmail(email);

            request.removeAttribute("code");
            request.setAttribute("uName", userName);
            request.setAttribute("check", "true");
            request.getRequestDispatcher("newpassword.jsp").forward(request, response);
        } else {
            session.setAttribute("code", code);
            request.setAttribute("email", email);
            request.setAttribute("check", "true");
            request.setAttribute("message", "Sorry, reset code incorrect");
            request.getRequestDispatcher("forgot.jsp").forward(request, response);
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
