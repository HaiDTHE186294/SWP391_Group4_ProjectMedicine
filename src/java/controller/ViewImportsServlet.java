/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProductDAO;
import dal.UserDAO;
import dal.stockDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Import;
import model.Provider;
import model.User;

/**
 *
 * @author Asus
 */
public class ViewImportsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Instance of your DAO class to interact with the database
    private stockDAO dao = new stockDAO();
    private stockDAO sDao = new stockDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the list of all imports from the DAO
        List<Import> importList = dao.getAllImport();
        List<User> users = sDao.getAllUser();

        // Tạo map để ánh xạ userId (int) với username (String)
        Map<Integer, String> userMap = new HashMap<>();
        for (User user : users) {
            userMap.put(user.getUserId(), user.getUsername());
        }

        List<Provider> providerList = sDao.getAllProviders();

        // Tạo map cho providers
        Map<Integer, String> providerMap = new HashMap<>();
        for (Provider provider : providerList) {
            providerMap.put(provider.getProviderID(), provider.getProviderName());
        }

        // Set the import list as an attribute in the request
        request.setAttribute("importList", importList);
        request.setAttribute("userMap", userMap);
        request.setAttribute("providerMap", providerMap);
        
        

        // Forward the request to the importView.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/importView.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<User> users = sDao.getAllUser();

        // Tạo map để ánh xạ userId (int) với username (String)
        Map<Integer, String> userMap = new HashMap<>();
        for (User user : users) {
            userMap.put(user.getUserId(), user.getUsername());
        }

        List<Provider> providerList = sDao.getAllProviders();

        // Tạo map cho providers
        Map<Integer, String> providerMap = new HashMap<>();
        for (Provider provider : providerList) {
            providerMap.put(provider.getProviderID(), provider.getProviderName());
        }

        // Set the import list as an attribute in the request

        request.setAttribute("userMap", userMap);
        request.setAttribute("providerMap", providerMap);
        // Retrieve the Product ID (Pid) from the request parameter
        String pid = request.getParameter("Pid");

        // Check if the pid is not null or empty
        if (pid != null && !pid.isEmpty()) {
            // Get the list of imports for the specific Product ID from the DAO
            List<Import> importList = dao.getAllImportByPid(pid);

            // Set the import list as an attribute in the request
            request.setAttribute("importList", importList);

            // Forward the request to the importView.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("/importView.jsp");
            dispatcher.forward(request, response);
        } else {
            // Handle the case when Pid is missing or invalid
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID (Pid) is required.");
        }
    }

}
