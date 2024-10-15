/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductDAO;
import dal.stockDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Import;

/**
 *
 * @author Asus
 */
public class ViewImportsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Instance of your DAO class to interact with the database
    private stockDAO dao = new stockDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get the list of all imports from the DAO
        List<Import> importList = dao.getAllImport();

        // Set the import list as an attribute in the request
        request.setAttribute("importList", importList);

        // Forward the request to the importView.jsp
        RequestDispatcher dispatcher = request.getRequestDispatcher("/importView.jsp");
        dispatcher.forward(request, response);
    }
}
