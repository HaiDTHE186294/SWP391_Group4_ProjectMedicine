//package controller;
//
//import model.User;
//import dal.UserDAO;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//import java.io.IOException;
//
//public class ChangePassController extends HttpServlet {
//     @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//    throws ServletException, IOException {
//        //processRequest(request, response);
//        request.getRequestDispatcher("newpassword.jsp").forward(request, response);
//    } 
//
//    /** 
//     * Handles the HTTP <code>POST</code> method.
//     * @param request servlet request
//     * @param response servlet response
//     * @throws ServletException if a servlet-specific error occurs
//     * @throws IOException if an I/O error occurs
//     */
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        HttpSession session = request.getSession();
//        User user = (User) session.getAttribute("User");
//
//        if (user == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
//
//        String oldPassword = request.getParameter("oldPassword");
//        String newPassword = request.getParameter("newPassword");
//        String confirmPassword = request.getParameter("confirmPassword");
//
//        UserDAO userDao = new UserDAO();
//
//        if (!user.getPassword().equals(oldPassword)) {
//            request.setAttribute("errorMessage", "Old password is incorrect.");
//            request.getRequestDispatcher("profile.jsp").forward(request, response);
//            return;
//        }
//
//        if (!newPassword.equals(confirmPassword)) {
//            request.setAttribute("errorMessage", "New password and confirm password do not match.");
//            request.getRequestDispatcher("profile.jsp").forward(request, response);
//            return;
//        }
//
//        boolean updateSuccessful = userDao.changePassword(user.getUsername(), newPassword);
//
//        if (updateSuccessful) {
//            request.setAttribute("successMessage", "Password updated successfully.");
//            request.getRequestDispatcher("login.jsp").forward(request, response);
//
//        } else {
//            request.setAttribute("errorMessage", "Failed to update the password.");
//        }
//
//    }
//}
