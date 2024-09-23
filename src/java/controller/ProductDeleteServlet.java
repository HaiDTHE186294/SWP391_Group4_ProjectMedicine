package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import dal.ProductDAO;

public class ProductDeleteServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy danh sách các productID cần xóa
        String productIDs = request.getParameter("productID");
        if (productIDs != null && !productIDs.isEmpty()) {
            String[] ids = productIDs.split(",");
            ProductDAO productDAO = new ProductDAO();
            for (String id : ids) {
                try {
                    
                    productDAO.deleteProduct(id); // Cập nhật trạng thái thành 0
                } catch (NumberFormatException e) {
                    System.out.println("Invalid product ID: " + id); // Ghi log nếu ID không hợp lệ
                    // Bạn có thể bỏ qua ID này hoặc gửi thông báo lỗi
                }
            }
        }

        // Chuyển hướng quay lại trang quản lý sản phẩm
        response.sendRedirect(request.getContextPath() + "/showProductManageView");
    }
}
