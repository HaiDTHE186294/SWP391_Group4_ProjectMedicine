/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dal.CategoryDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Product;
import dal.ProductDAO;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.Category;
import model.Ingredient;
import model.ProductPriceQuantity;
import model.ProductUnit;

/**
 *
 * @author Asus
 */
public class ProductDetail extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID = request.getParameter("productId");
        ProductDAO p = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();
        Product product = p.getProductByID(productID); // Lấy sản phẩm dựa vào ID
        request.setAttribute("product", product); // Gửi sản phẩm duy nhất qua request
        List<ProductUnit> units = p.getAllUnits(); // Lấy danh sách Unit
        List<Category> categories = categoryDAO.getAllCategories();
        HttpSession session = request.getSession(true);
        
        Gson gson = new Gson();
        String categoriesJSON = gson.toJson(categoryDAO.getAllCategories());
        session.setAttribute("units", units);
        session.setAttribute("categories", categories);
        
        // Lấy productID từ yêu cầu

        // Lấy danh sách ProductPriceQuantity theo productID
        List<ProductPriceQuantity> priceQuantities = p.getProductPriceQuantitiesByProductID(productID);
        List<ProductUnit> ownUnit = new ArrayList<>();
        for (ProductPriceQuantity pp : priceQuantities){
            for (ProductUnit u : units) {
                if (pp.getProductID().equals(u.getUnitID())){
                    ownUnit.add(u);
                    break;
                }
            }
        }
        // Gửi danh sách đến JSP
        request.setAttribute("priceQuantities", priceQuantities);
        request.setAttribute("ownUnit", ownUnit); 
        request.setAttribute("units", units); 
        if (productID != null && !productID.isEmpty()) {
            ProductDAO ingredientDAO = new ProductDAO();
            List<Ingredient> ingredients = ingredientDAO.getIngredientsByProductID(productID);

            request.setAttribute("ingredients", ingredients);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID");
        }
        request.getRequestDispatcher("productDetail.jsp").include(request, response); // Điều hướng tới JSP hiển thị chi tiết sản phẩm
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
