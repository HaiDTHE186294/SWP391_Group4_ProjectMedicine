package ControllerCustomer;

import dal.ProductDAO;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class DisplayTop8ProductServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Khởi tạo DAO
        ProductDAO productDao = new ProductDAO();
        
        // Gọi hàm để lấy danh sách 8 sản phẩm bán chạy
        List<Map<String, Object>> listTop8SoldProducts = productDao.getTop8SoldProducts();
        
        // Đặt danh sách sản phẩm vào thuộc tính request
        request.setAttribute("listTop8SoldProducts", listTop8SoldProducts);
        
        // Chuyển hướng đến trang JSP để hiển thị sản phẩm
        request.getRequestDispatcher("productDetailCustomer.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Nếu bạn cần xử lý POST, bạn có thể gọi doGet ở đây hoặc xử lý riêng
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Displays top 8 sold products";
    }
}
