import dal.ProductDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Product;


public class GetImportList extends HttpServlet {
    private ProductDAO productDAO = new ProductDAO();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Lấy danh sách sản phẩm từ database
        List<Product> productList = productDAO.getAllProducts();
        
        // Set productList vào request để truyền sang JSP
        req.setAttribute("productList", productList);
        
        // Forward sang JSP để hiển thị danh sách
        req.getRequestDispatcher("getImportList.jsp").forward(req, resp);
    }
}
