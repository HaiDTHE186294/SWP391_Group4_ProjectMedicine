package controller;

import dal.CategoryDAO;
import dal.ProductDAO;
import dal.stockDAO;
import model.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import model.Category;

public class ProductManageServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        String message = (String) session.getAttribute("message");
        if (message != null) {
            session.removeAttribute("message");
        }
        request.setAttribute("message", message);

        ProductDAO productDAO = new ProductDAO();

        CategoryDAO categoryDAO = new CategoryDAO();
        List<Product> products = productDAO.getAllProducts();
        List<Category> categories = categoryDAO.getAllCategories();
        List<Category> categories1 = categoryDAO.getAllCategories();
        request.setAttribute("productList", products);
        request.setAttribute("categories", categories);
        session.setAttribute("categories", categories);

        stockDAO sDAO = new stockDAO(); // Assuming this is where getTotalQuantityByProduct() is located
        Map<String, Float> totalQuantities = sDAO.getTotalQuantityByProduct();
        request.setAttribute("totalQuantities", totalQuantities);

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("/product/productManageView.jsp").forward(request, response);
    }
}
