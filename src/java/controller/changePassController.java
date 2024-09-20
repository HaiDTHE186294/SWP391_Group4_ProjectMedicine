package controller;

import model.User;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

public class ChangePassController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get form parameters
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        UserDAO userDao = new UserDAO();

        // Validate old password
        if (!currentUser.getPassword().equals(oldPassword)) {
            request.setAttribute("errorMessage", "Old password is incorrect.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // Validate new and confirm passwords
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New password and confirm password do not match.");
            request.getRequestDispatcher("changePassword.jsp").forward(request, response);
            return;
        }

        // Update the password
        boolean updateSuccessful = userDao.changePassword(currentUser.getUsername(), newPassword);

        if (updateSuccessful) {
            currentUser.setPassword(newPassword); // Update the session with the new password
            session.setAttribute("user", currentUser);
            request.setAttribute("successMessage", "Password updated successfully.");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } else {
            request.setAttribute("errorMessage", "Failed to update the password.");
        }

    }
}