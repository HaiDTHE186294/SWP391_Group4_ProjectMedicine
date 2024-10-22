package ControllerCustomer;

import model.Product;
import dal.ProductDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;

public class productDetailCusController extends HttpServlet {

    // Xử lý các yêu cầu GET
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        // Lấy productid từ tham số yêu cầu
        String id = request.getParameter("productid");

        // Tạo một instance của ProductDAO
        ProductDAO productDAO = new ProductDAO();

        // Kiểm tra nếu ID hợp lệ (không null hoặc rỗng)
        if (id != null && !id.trim().isEmpty()) {
            // Lấy thông tin sản phẩm bằng ID
            Product product = productDAO.getProductByID1(id);
            
            // Kiểm tra nếu sản phẩm tồn tại
            if (product != null) {
                // Đặt sản phẩm vào thuộc tính request
                request.setAttribute("productId", product);
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
            // Đặt danh sách vào thuộc tính request
            request.setAttribute("listTop8SoldProducts", listTop8SoldProducts);
        } else {
            // Nếu không có sản phẩm nào, thêm thông báo
            request.setAttribute("errorMessage", "No top sold products found.");
        }

        // Chuyển tiếp đến trang JSP để hiển thị thông tin sản phẩm
        request.getRequestDispatcher("productDetailCustomer.jsp").forward(request, response);
    }

    // Xử lý các yêu cầu POST (không thay đổi gì)
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
