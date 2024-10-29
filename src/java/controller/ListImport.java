import dal.*;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import model.*;

public class ListImport extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO(); // DAO instance
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy danh sách sản phẩm từ database
        List<Product> productList = productDAO.getAllProducts();
        
        // Set productList vào request để truyền sang JSP
        req.setAttribute("productList", productList);
        
        // Forward sang JSP để hiển thị danh sách
        req.getRequestDispatcher("listImport.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String[] productIDs = request.getParameterValues("productID");

        if (productIDs != null && productIDs.length > 0) {
            ProductDAO dao = new ProductDAO();
            stockDAO sdao = new stockDAO();

            // Create lists to store information for all selected products
            List<ProductPriceQuantity> ppqList = new ArrayList<>();
            List<List<Stock>> allStocksList = new ArrayList<>();
            List<String> baseUnitNames = new ArrayList<>();

            // Get all units once (assuming units are shared across products)
            List<ProductUnit> units = dao.getAllUnits();
            HttpSession session = request.getSession(true);
            request.setAttribute("units", units);
            session.setAttribute("units", units);

            // Loop through each product ID and gather the necessary information
            for (String productID : productIDs) {
                // Get product price and quantity information
                ProductPriceQuantity ppq = dao.getProductPriceQuantitiesByProductIDforImport(productID);
                ppqList.add(ppq); // Add to list for later use

                // Get stock information for this product
                List<Stock> stocks = sdao.getAllStocksByPid(productID);
                allStocksList.add(stocks); // Add to list for later use

                // Determine the base unit name for this product
                String baseUnitID = ppq != null ? ppq.getUnitID() : null;
                String baseUnitName = "";
                if (baseUnitID != null && !baseUnitID.isEmpty()) {
                    for (ProductUnit unit : units) {
                        if (baseUnitID.equals(unit.getUnitID())) {
                            baseUnitName = unit.getUnitName();
                            break; // Found the unit name, no need to continue looping
                        }
                    }
                }
                baseUnitNames.add(baseUnitName); // Add base unit name to list
            }

            // Store the gathered information in request attributes for the JSP
            request.setAttribute("ppqList", ppqList);
            request.setAttribute("allStocksList", allStocksList);
            request.setAttribute("baseUnitNames", baseUnitNames);

            // Forward the request to the JSP page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/imp[ỏ.jsp");
            dispatcher.forward(request, response);
        } else {
            // Handle the case where no products were selected
            request.setAttribute("message", "No products selected.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/listImport.jsp");
            dispatcher.forward(request, response);
        }

    }
}
