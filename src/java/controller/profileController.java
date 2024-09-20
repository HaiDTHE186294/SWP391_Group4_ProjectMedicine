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
        User user = new User();
        HttpSession session = request.getSession();
        session.setAttribute("user", user);

        request.setAttribute("user", user);
        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        int roleId = Integer.parseInt(request.getParameter("roleId"));
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String image = request.getParameter("image");

        currentUser.setFullName(fullName);
        currentUser.setUsername(username);
        currentUser.setEmail(email);
        currentUser.setRoleId(roleId);
        currentUser.setStatus(status);
        currentUser.setPhone(phone);
        currentUser.setAddress(address);
        currentUser.setImage(image);

        UserDAO userDao = new UserDAO();
        boolean updateSuccessful = userDao.updateUser(currentUser);

        if (updateSuccessful) {
            session.setAttribute("user", currentUser);
            response.sendRedirect("profile.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to update user information.");
            request.getRequestDispatcher("profile.jsp").forward(request, response);
        }
    }

}