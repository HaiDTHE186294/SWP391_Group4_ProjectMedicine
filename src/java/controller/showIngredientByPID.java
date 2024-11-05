package controller;


import dal.ProductDAO;
import model.Ingredient;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/product/ShowIngredients")
public class showIngredientByPID extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String productID = request.getParameter("productID");

        if (productID != null && !productID.isEmpty()) {
            ProductDAO ingredientDAO = new ProductDAO();
            List<Ingredient> ingredients = ingredientDAO.getIngredientsByProductID(productID);

            request.setAttribute("ingredients", ingredients);
            request.getRequestDispatcher("/product/ingredientList.jsp").forward(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID");
        }
    }
}
