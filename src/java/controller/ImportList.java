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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Import;
import model.Product;
import model.ProductPriceQuantity;
import model.ProductUnit;
import model.Provider;
import model.Unit;

/**
 *
 * @author Asus
 */
public class ImportList extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ImportList</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ImportList at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
        // Lấy danh sách các productID từ request
        String[] selectedProductIDs = request.getParameterValues("selectedProductIDs");
        ProductDAO pDao = new ProductDAO();
        stockDAO sDao = new stockDAO();

        // Lấy danh sách nhà cung cấp
        List<Provider> providerList = sDao.getAllProviders();
        request.setAttribute("providerList", providerList);

        // Tạo map để lưu unitID và unitName
        Map<String, String> unitMap = new HashMap<>();
        List<ProductUnit> units = pDao.getAllUnits(); // Thay đổi phương thức tùy theo cách bạn lưu trữ đơn vị
        for (ProductUnit unit : units) {
            unitMap.put(unit.getUnitID(), unit.getUnitName());
        }

        // Đưa map vào request
        request.setAttribute("unitMap", unitMap);

        // Kiểm tra xem có sản phẩm nào được chọn không
        if (selectedProductIDs != null && selectedProductIDs.length > 0) {
            List<ProductPriceQuantity> productPriceQuantityList = new ArrayList<>();
            List<Product> productList = new ArrayList<>(); // Danh sách sản phẩm tương ứng

            // Lặp qua từng productID và lấy ProductPriceQuantity
            for (String productID : selectedProductIDs) {
                ProductPriceQuantity ppq = pDao.getProductPriceQuantitiesByProductIDforImport(productID);
                if (ppq != null) {
                    productPriceQuantityList.add(ppq);
                    Product product = pDao.getProductByID(productID); // Lấy thông tin sản phẩm tương ứng
                    if (product != null) {
                        productList.add(product);
                    }
                }
            }

            // Lưu danh sách ProductPriceQuantity và Product vào request
            request.setAttribute("productPriceQuantityList", productPriceQuantityList);
            request.setAttribute("productList", productList);
        } else {
            System.out.println("No ProductID selected.");
            // Xử lý trường hợp không có sản phẩm nào được chọn, ví dụ chuyển hướng hoặc hiển thị thông báo lỗi
            response.sendRedirect("someErrorPage.jsp");
            return; // Dừng thực thi nếu không có sản phẩm nào
        }

        // Chuyển tiếp đến JSP
        RequestDispatcher dispatcher = request.getRequestDispatcher("/importList.jsp");
        dispatcher.forward(request, response);
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
        stockDAO sDAO = new stockDAO();
        // Lấy thông tin từ biểu mẫu
        String providerId = request.getParameter("providerId");
        int provider = Integer.parseInt(request.getParameter("providerId"));
        String[] productNames = request.getParameterValues("productName[]");
        String[] productIds = request.getParameterValues("productId[]");
        String[] baseUnitIds = request.getParameterValues("baseUnitId[]");
        String[] batchNos = request.getParameterValues("batchNo[]");
        String[] dateManufactures = request.getParameterValues("dateManufacture[]");
        String[] dateExpiers = request.getParameterValues("dateExpired[]");
        String[] dateImports = request.getParameterValues("dateImport[]");
        String[] priceSales = request.getParameterValues("priceSale[]");
        String[] priceImports = request.getParameterValues("priceImport[]");
        String[] quantities = request.getParameterValues("quantity[]");
        HttpSession session = request.getSession(true);
        int importer = (session.getAttribute("userId") != null) ? (Integer) session.getAttribute("userId") : -1;

        // Xử lý dữ liệu (ví dụ: lưu vào cơ sở dữ liệu)
        for (int i = 0; i < productIds.length; i++) {
            // Lấy thông tin từ từng sản phẩm

            String productName = productNames[i];
            String productId = productIds[i];
            String baseUnitId = baseUnitIds[i];
            String batchNo = batchNos[i];
            String dateManufacture = dateManufactures[i];
            String dateExpired = dateExpiers[i];
            String dateImport = dateImports[i];
            String priceSale = priceSales[i];
            float priceImport = Float.parseFloat(priceImports[i]);
            float quantity = Float.parseFloat(quantities[i]);
            String orderId = sDAO.generateOrderId(productIds[i]);

            Import importData = new Import(orderId, provider, productId, baseUnitId, batchNo, dateManufacture, dateExpired, dateImport ,priceImport, importer, quantity);

            sDAO.addImport(importData);
        }
        
        try {
            sDAO.updateProductStatus();
        } catch (SQLException ex) {
            Logger.getLogger(ImportList.class.getName()).log(Level.SEVERE, null, ex);
        }

        response.sendRedirect(request.getContextPath() + "/stockManagement");
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
