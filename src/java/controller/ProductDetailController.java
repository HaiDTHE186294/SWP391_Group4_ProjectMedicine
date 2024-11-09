/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import dal.ProductDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Ingredient;
import model.Product;
import model.ProductPriceQuantity;
import model.ProductUnit;

/**
 *
 * @author trant
 */
public class ProductDetailController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ProductDetailController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ProductDetailController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
        // Lấy productId từ tham số yêu cầu
        String id = request.getParameter("productid");

        // Tạo một instance của ProductDAO để truy xuất dữ liệu từ cơ sở dữ liệu
        ProductDAO productDAO = new ProductDAO();

        // Kiểm tra nếu ID hợp lệ (không null hoặc rỗng)
        if (id != null && !id.trim().isEmpty()) {
            // Lấy thông tin sản phẩm theo productId
            Product product = productDAO.getProductByID1(id);

            // Lấy danh sách nguyên liệu cho sản phẩm
            List<Ingredient> ingredients = productDAO.getIngredientsByProductID1(id);

            // Lấy tất cả đơn vị (units) và giá tương ứng (priceQuantities)
            List<ProductUnit> units = productDAO.getAllUnits();
            List<ProductPriceQuantity> priceQuantities = productDAO.getProductPriceQuantitiesByProductID(id);

            // Tạo danh sách để lưu các unit thuộc sản phẩm này và một map để lưu giá của từng unit
            List<ProductUnit> ownUnit = new ArrayList<>();
            Map<String, Float> unitPrices = new HashMap<>();

            // Tạo danh sách các đơn vị và lưu giá của từng đơn vị vào map
            for (ProductPriceQuantity pp : priceQuantities) {
                unitPrices.put(pp.getUnitID(), pp.getSalePrice()); // lưu salePrice ứng với từng unitID
                for (ProductUnit u : units) {
                    if (pp.getUnitID().equals(u.getUnitID())) {
                        ownUnit.add(u);
                        break;
                    }
                }
            }

            // Kiểm tra nếu sản phẩm tồn tại
            if (product != null) {
                // Đặt thông tin sản phẩm, đơn vị, giá, và thành phần vào request để chuyển đến JSP
                request.setAttribute("productId", product);
                request.setAttribute("ownUnit", ownUnit);
                request.setAttribute("unitPrices", unitPrices); // Map đơn vị -> giá
                request.setAttribute("ingredients", ingredients); // Danh sách nguyên liệu
            } else {
                // Nếu không tìm thấy sản phẩm, chuyển hướng đến trang lỗi
                request.setAttribute("errorMessage", "Product not found.");
                request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                return;
            }
        } else {
            // Nếu ID không hợp lệ, chuyển hướng đến trang lỗi
            request.setAttribute("errorMessage", "Invalid product ID.");
            request.getRequestDispatcher("errorPage.jsp").forward(request, response);
            return;
        }

        // Lấy danh sách 8 sản phẩm bán chạy
        List<Map<String, Object>> listTop8SoldProducts = productDAO.getTop8SoldProducts();

        // Kiểm tra nếu danh sách không rỗng
        if (listTop8SoldProducts != null && !listTop8SoldProducts.isEmpty()) {
            // Đặt danh sách sản phẩm bán chạy vào request
            request.setAttribute("listTop8SoldProducts", listTop8SoldProducts);
        } else {
            // Nếu không có sản phẩm bán chạy, thêm thông báo lỗi
            request.setAttribute("errorMessage", "No top sold products found.");
        }

        // Chuyển tiếp đến trang JSP để hiển thị thông tin sản phẩm
        request.getRequestDispatcher("productDetailCustomer.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        //processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
