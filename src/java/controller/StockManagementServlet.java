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
import java.util.Map;
import model.Product;
import model.ProductUnit;
import model.Stock;

public class StockManagementServlet extends HttpServlet {

    private stockDAO stockDAO = new stockDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get grouped stock
        Map<String, Object> groupedStock = stockDAO.getGroupedStock();
        ProductDAO pDAO = new ProductDAO();
        List<Stock> stockList = stockDAO.getAllStocks(); // Get the list of stocks
        List<Product> productList = pDAO.getAllProducts();
        List<ProductUnit> pUnits = pDAO.getAllUnits();

        // Set the stock list as a request attribute
        request.setAttribute("stockList", stockList);
        request.setAttribute("productList", productList);
        request.setAttribute("pUnits", pUnits);

        // Pass grouped stock to JSP
        request.setAttribute("groupedStock", groupedStock);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/stockManager.jsp");
        dispatcher.forward(request, response);
    }
}
