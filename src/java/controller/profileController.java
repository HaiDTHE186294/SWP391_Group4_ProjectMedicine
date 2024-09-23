package controller;

import model.User;
import dal.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

public class profileController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");

        if (user == null || user.getUsername() == null) {
            response.sendRedirect("login.jsp");
        } else {
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("User");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get parameters and validate input
        String fullName = request.getParameter("fullName").trim();
        String username = request.getParameter("username").trim();
        String email = request.getParameter("email").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();
        String image = request.getParameter("image").trim();

        // Set updated values
        user.setFullName(fullName);
        user.setUsername(username);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);
        user.setImage(image);

        // Update in the database
        UserDAO userDao = new UserDAO();
        boolean updateSuccessful = userDao.updateUser(user);

        // Handle the response
        if (updateSuccessful) {
            session.setAttribute("User", user); // Update session data
            response.sendRedirect("profile.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update user information.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }
}