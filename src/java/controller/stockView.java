package controller;

import dal.stockDAO;
import model.Stock;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class stockView extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Create an instance of StockDAO to retrieve stock data
        stockDAO stockDAO = new stockDAO();
        List<Stock> stockList = stockDAO.getAllStocks(); // Get the list of stocks

        // Set the stock list as a request attribute
        request.setAttribute("stockList", stockList);
        
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