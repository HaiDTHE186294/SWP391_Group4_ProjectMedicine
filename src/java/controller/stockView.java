package controller;

import dal.*;
import model.*;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

public class stockView extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Create an instance of StockDAO to retrieve stock data
        stockDAO stockDAO = new stockDAO();
        ProductDAO pDAO = new ProductDAO();
        List<Stock> stockList = stockDAO.getAllStocks(); // Get the list of stocks
        List<Product> productList = pDAO.getAllProducts();
        List<ProductUnit> pUnits = pDAO.getAllUnits();

        // Set the stock list as a request attribute
        request.setAttribute("stockList", stockList);
        request.setAttribute("productList", productList);
        request.setAttribute("pUnits", pUnits);
        
        
        // Get the list of all imports from the DAO
        List<User> users = stockDAO.getAllUser();

        // Tạo map để ánh xạ userId (int) với username (String)
        Map<Integer, String> userMap = new HashMap<>();
        for (User user : users) {
            userMap.put(user.getUserId(), user.getUsername());
        }

        List<Provider> providerList = stockDAO.getAllProviders();

        // Tạo map cho providers
        Map<Integer, String> providerMap = new HashMap<>();
        for (Provider provider : providerList) {
            providerMap.put(provider.getProviderID(), provider.getProviderName());
        }

        // Set the import list as an attribute in the request
        request.setAttribute("userMap", userMap);
        request.setAttribute("providerMap", providerMap);
        
        // Forward the request to the JSP page for displaying the stocks
        request.getRequestDispatcher("stock.jsp").forward(request, response);
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
        return "Servlet for viewing stock";
    }
}
