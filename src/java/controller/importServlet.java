package controller;

import dal.*;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;
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

        // Forward the request to the import JSP page
        RequestDispatcher dispatcher = request.getRequestDispatcher("importProduct.jsp");
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
        stockDAO importDAO = new stockDAO();

        // Generate a new Order ID (O_id)
        String orderId = importDAO.generateOrderId(productId);

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
        
        

        boolean success1 = importDAO.addImport(importData);


        // Call the importProduct method from ImportDAO
        stockDAO stockDao = new stockDAO();
        boolean success = stockDao.importProduct(importData);

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
