/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;



import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.ProductPriceQuantity;
import model.ProductUnit;



@WebServlet("/product/showProductPriceQuantity")
public class showProductPriceQuantity extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        
        // Lấy productID từ yêu cầu
        String productID = request.getParameter("productID");
        List<ProductUnit> units = productDAO.getAllUnits();
        
        // Lấy danh sách ProductPriceQuantity theo productID
        List<ProductPriceQuantity> priceQuantities = productDAO.getProductPriceQuantitiesByProductID(productID);
        
        // Gửi danh sách đến JSP
        request.setAttribute("priceQuantities", priceQuantities);
        request.setAttribute("units", units); 
        request.getRequestDispatcher("showProductPriceQuantity.jsp").forward(request, response);
    }
}
