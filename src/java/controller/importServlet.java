package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

public class importServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // This method can remain empty if only doPost is used
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Get the product ID from the request
        String productID = request.getParameter("productID");
        
        // Store the product ID in the request attribute
        request.setAttribute("productID", productID);
        
        // Forward the request to the import JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("importProduct.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // You can redirect to a specific page or handle GET requests if needed
        response.sendRedirect("someOtherPage.jsp");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
