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
import model.User;

/**
 *
 * @author trant
 */
public class RegisterController extends HttpServlet {

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
            out.println("<title>Servlet RegisterController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterController at " + request.getContextPath() + "</h1>");
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
        request.getRequestDispatcher("register.jsp").forward(request, response);
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
        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Kiểm tra nếu các trường bắt buộc không được nhập
        if (username == null || username.isEmpty()
                || email == null || email.isEmpty()
                || password == null || password.isEmpty()
                || confirmPassword == null || confirmPassword.isEmpty()
                || fullName == null || fullName.isEmpty()
                || phone == null || phone.isEmpty()
                || address == null || address.isEmpty()) {

            request.setAttribute("registerError", "All fields are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra nếu mật khẩu và xác nhận mật khẩu không khớp
        if (!password.equals(confirmPassword)) {
            request.setAttribute("registerError", "Passwords do not match!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        session.setAttribute("fullName", fullName);
//        session.setAttribute("username", username);
//        session.setAttribute("email", email);
        session.setAttribute("phone", phone);
        session.setAttribute("address", address);

        UserDAO userDao = new UserDAO();

        // Kiểm tra nếu username hoặc email đã tồn tại
        if (userDao.checkUserExists(username, email)) {
            request.setAttribute("registerError", "Registration failed. Username or email might already be taken!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            Email handleEmail = new Email();
            Random random = new Random();
            Integer code = 100000 + random.nextInt(900000);
            String verificationCode = code.toString();
            String subject = handleEmail.subjectVerification();
            String msgEmail = handleEmail.messageVerification(code);

            boolean isEmailSent = handleEmail.sendEmail(subject, msgEmail, email);

            if (isEmailSent) {
                session.setAttribute("code", verificationCode);
                session.setAttribute("codeCreationTime", System.currentTimeMillis()); // Lưu thời gian tạo mã

                User user = new User();
                user.setFullName(fullName);
                user.setUsername(username);
                user.setPassword(password);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);
                user.setImage("images/users/user.png");

                session.setAttribute("registrationData", user);
//                session.setAttribute("fullName", fullName);
                session.setAttribute("username", username);
                session.setAttribute("email", email);
//                session.setAttribute("phone", phone);
//                session.setAttribute("address", address);

                request.setAttribute("check", "true");
                request.setAttribute("message", "EXIST - valid email, check your email to have verify code");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            } else {
                request.setAttribute("message", "Failed to send the verification email. Please try again.");
                request.setAttribute("check", "false");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        }else{
            userDao.createUser(fullName, username, password, email, phone, address, "images/users/user.png");
            response.sendRedirect("login.jsp");
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
