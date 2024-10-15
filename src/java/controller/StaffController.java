/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Controller;

import dal.DAOStaff;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList; // Changed to ArrayList
import model.Staff;

@WebServlet(name = "StaffController", urlPatterns = {"/StaffURL"})
public class StaffController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DAOStaff dao = new DAOStaff();
        try (PrintWriter out = response.getWriter()) {

            String service = request.getParameter("service");
            if (service == null) {
                service = "listAllStaff";
            }
            if (service.equals("deleteStaff")) {
                dao.removeStaff(Integer.parseInt(request.getParameter("stid")));
                response.sendRedirect("StaffURL?service=listAllStaff");
            }
            if (service.equals("updateStaff")) {
                String submit = request.getParameter("submit");
                if (submit == null) { // show form
                    int stid = Integer.parseInt(request.getParameter("stid"));
                    String sql = "SELECT * FROM staffs WHERE staff_id = " + stid;
                    ArrayList<Staff> staffList = dao.getStaff(sql); // Changed to ArrayList
                    request.setAttribute("staffList", staffList);
                    request.getRequestDispatcher("updateStaff.jsp").forward(request, response);
                } else {
                    String staffId = request.getParameter("staff_id");
                    String fullName = request.getParameter("full_name");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String status = request.getParameter("status");
                    String roleId = request.getParameter("role_id");
                    String address = request.getParameter("address");
                    String image = request.getParameter("image");

                    // Convert
                    int staffIdInt = Integer.parseInt(staffId);
                    int statusInt = Integer.parseInt(status);
                    int roleIdInt = Integer.parseInt(roleId);

                    Staff staff = new Staff(staffIdInt, fullName, email, roleIdInt, statusInt, phone, address, image);
                    int n = dao.updateStaff(staff);
                    System.out.println(n);
                    response.sendRedirect("StaffURL?service=listAllStaff");
                }
            }
            if (service.equals("insertStaff")) {
                String submit = request.getParameter("submit");
                if (submit == null) { // show form
                    request.getRequestDispatcher("insertStaff.jsp").forward(request, response);
                } else {
                    String staffId = request.getParameter("staff_id");
                    String fullName = request.getParameter("full_name");
                    String email = request.getParameter("email");
                    String phone = request.getParameter("phone");
                    String status = request.getParameter("status");
                    String roleId = request.getParameter("role_id");
                    String address = request.getParameter("address");
                    String image = request.getParameter("image");

                    // Convert
                    int staffIdInt = Integer.parseInt(staffId);
                    int statusInt = Integer.parseInt(status);
                    int roleIdInt = Integer.parseInt(roleId);

                    Staff staff = new Staff(staffIdInt, fullName, email, roleIdInt, statusInt, phone, address, image);
                    int n = dao.insertStaff(staff);
                    System.out.println(n);
                    response.sendRedirect("StaffURL?service=listAllStaff");
                }
            }

            if (service.equals("listAllStaff")) {
                String sql = "SELECT * FROM staffs";
                ArrayList<Staff> staffList = dao.getStaff(sql); // Changed to ArrayList
                RequestDispatcher dispatch = request.getRequestDispatcher("ListStaff.jsp");
                request.setAttribute("data", staffList);
                request.setAttribute("tableTitle", "Staff Management"); // Updated title for clarity
                dispatch.forward(request, response);
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}

