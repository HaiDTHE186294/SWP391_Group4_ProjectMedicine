package controller;

import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.*;

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
        ProductDAO dao = new ProductDAO();
        stockDAO sdao = new stockDAO();
        ProductPriceQuantity ppq = (ProductPriceQuantity) dao.getProductPriceQuantitiesByProductIDforImport(productID);
        request.setAttribute("ppq", ppq);
        List<Stock> stocks = sdao.getAllStocksByPid(productID);
        request.setAttribute("stocks", stocks);
        List<ProductUnit> units = dao.getAllUnits();

        String baseUnitID = ppq != null ? ppq.getUnitID() : null;
        String baseUnitName = "";
        if (baseUnitID != null && !baseUnitID.isEmpty()) {
            // Loop through the units to find the corresponding unit name
            for (ProductUnit unit : units) {
                if (baseUnitID.equals(unit.getUnitID())) {
                    baseUnitName = unit.getUnitName();
                    break; // Once found, no need to continue looping
                }
            }
        }

        HttpSession session = request.getSession(true);
        request.setAttribute("baseUnitName", baseUnitName);
        request.setAttribute("units", units);
        session.setAttribute("units", units);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/importProduct.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set request character encoding to handle special characters
        request.setCharacterEncoding("UTF-8");

        // Get the form parameters
        String productId = request.getParameter("productID");
        String baseUnitId = request.getParameter("baseUnitId");
        String batchNo = request.getParameter("batchNo");
        String provider = request.getParameter("provider");
        String dateManufacture = request.getParameter("dateManufacture");
        String dateExpired = request.getParameter("dateExpired");
        float priceImport = Float.parseFloat(request.getParameter("priceImport"));
        String importer = request.getParameter("importer"); // assuming it's the User ID from the session
        float quantity = Float.parseFloat(request.getParameter("quantity"));
        stockDAO stockDAO = new stockDAO();
        Stock oldStock = stockDAO.getStockByPidAndBatch(productId, batchNo);
        String NCC =  stockDAO.getManufacturerByProductAndBatch(productId, batchNo);
        // If old stock exists, use its manufacture and expiry dates
        if (oldStock.getDateExpired() != null && !oldStock.getDateExpired().isEmpty()) {
            dateManufacture = oldStock.getDateManufacture();
            dateExpired = oldStock.getDateExpired();
            provider = stockDAO.getManufacturerByProductAndBatch(productId, batchNo);
        }

        System.out.println(NCC);

        // Generate a new Order ID (O_id)
        String orderId = stockDAO.generateOrderId(productId);

        // Create an Import object
        Import importData = new Import(
                orderId,
                provider,
                productId,
                baseUnitId,
                batchNo,
                dateManufacture,
                dateExpired,
                priceImport,
                Integer.parseInt(importer), // Assuming the importer is an integer User ID
                quantity
        );

//        boolean success1 = stockDAO.addImport(importData);
        // Call the importProduct method from ImportDAO
        boolean success = stockDAO.addImport(importData);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/stockView");
        dispatcher.forward(request, response);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
