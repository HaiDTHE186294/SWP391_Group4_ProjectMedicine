package ControllerCustomer;

import model.Product;
import model.Ingredient;
import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.ProductPriceQuantity;
import model.ProductUnit;


public class productDetailCusController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
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

    // Xử lý các yêu cầu POST bằng cách chuyển hướng về phương thức GET
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }

    // Phương thức mặc định (không thay đổi gì)
    @Override
    public String getServletInfo() {
        return "Product detail servlet for customers";
    }
}
