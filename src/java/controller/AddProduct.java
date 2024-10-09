package controller;

import com.google.gson.Gson;
import dal.CategoryDAO;
import dal.ProductDAO;
import model.Product;
import model.Ingredient;
import model.ProductPriceQuantity;
import model.ProductUnit;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import model.Category;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class AddProduct extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "images/products";  // Thư mục lưu ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        HttpSession session = request.getSession(true);
        CategoryDAO categoryDAO = new CategoryDAO();
        List<ProductUnit> units = productDAO.getAllUnits(); // Lấy danh sách Unit
        List<Category> categories = categoryDAO.getAllCategories();
        List<Product> products = productDAO.getAllProducts();
        
        Gson gson = new Gson();
        String categoriesJSON = gson.toJson(categoryDAO.getAllCategories());
        session.setAttribute("categoriesJSON", categoriesJSON);
         // Đưa danh sách units vào request
        session.setAttribute("units", units);
        session.setAttribute("products", products);
        session.setAttribute("categories", categories);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("/product/addProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 ProductDAO productDAO = new ProductDAO();
        // Tạo đường dẫn để lưu ảnh
        String originalPath = getServletContext().getRealPath("");
        String modifiedPath = originalPath.replace("\\build\\web\\", "\\web\\");
        String uploadPath = modifiedPath + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();  // Tạo thư mục nếu chưa tồn tại
        }

        // Xử lý upload ảnh
        Part filePart = request.getPart("imageUpload");  // Lấy file từ request
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // Lấy tên file
        fileName = fileName.replaceAll("[^a-zA-Z0-9.\\-_]", "_"); // Thay thế ký tự không hợp lệ
        String filePath = uploadPath + File.separator + fileName;

        // Lưu file vào thư mục
        filePart.write(filePath);

        // Nhận dữ liệu từ form
        String categoryID = request.getParameter("categoryId");
        String brand = request.getParameter("brand");
        String productID = request.getParameter("productId");
        if(productDAO.getProductByID(productID) != null) {
            String noti = "Duplicate Product ID";
            request.setAttribute("noti", noti);
            request.getRequestDispatcher("addProduct.jsp").forward(request, response);
            return;
        } 
        String productName = request.getParameter("productName");
        String pharmaceuticalForm = request.getParameter("pharmaceuticalForm");
        String brandOrigin = request.getParameter("brandOrigin");
        String manufacturer = request.getParameter("manufacturer");
        String countryOfProduction = request.getParameter("countryOfProduction");
        String shortDescription = request.getParameter("shortDescription");
        String registrationNumber = request.getParameter("registrationNumber");
        String productDescription = request.getParameter("description");
        String contentReviewer = "none";
        String faq = request.getParameter("faq");
        String productReviews = "";  // Không có reviews khi tạo sản phẩm
        int status = Integer.parseInt(request.getParameter("status"));
        int sold = 0;  // Giá trị mặc định cho số lượng bán
        String dateCreated = java.time.LocalDate.now().toString();
        int productVersion = 1;  // Phiên bản sản phẩm mặc định
        String prescriptionRequired = request.getParameter("prescriptionRequired");
        String targetAudience = request.getParameter("targetAudience");

        // Tạo đối tượng Product từ dữ liệu nhận được
        Product product = new Product(categoryID, brand, productID, productName, pharmaceuticalForm, brandOrigin,
                manufacturer, countryOfProduction, shortDescription, registrationNumber,
                productDescription, contentReviewer, faq, productReviews, status, sold,
                dateCreated, productVersion, prescriptionRequired, targetAudience);

        // Thêm sản phẩm vào cơ sở dữ liệu
       
        productDAO.addProduct(product);

        // Lưu đường dẫn ảnh vào cơ sở dữ liệu
        productDAO.saveImagePath(productID, UPLOAD_DIRECTORY + "/" + fileName);

        // Lấy dữ liệu nguyên liệu từ form
        String[] ingredientNames = request.getParameterValues("ingredientName[]");
        String[] InQuantities = request.getParameterValues("InQuantity[]");
        String[] InUnits = request.getParameterValues("InUnit[]");

        // Tạo danh sách các nguyên liệu
        List<Ingredient> ingredients = new ArrayList<>();
        if (ingredientNames != null) {
            for (int i = 0; i < ingredientNames.length; i++) {
                if (ingredientNames[i] != null && !ingredientNames[i].isEmpty()) {
                    Ingredient ingredient = new Ingredient(productID, i + 1, ingredientNames[i],
                            Float.parseFloat(InQuantities[i]), InUnits[i]);
                    ingredients.add(ingredient);
                }
            }
        }

        // Thêm nguyên liệu vào cơ sở dữ liệu
        productDAO.addIngredients(productID, ingredients);

        // Lấy dữ liệu từ form cho ProductPriceQuantity
        String[] units = request.getParameterValues("unit[]");
        String[] packagingDetails = request.getParameterValues("packagingDetails[]");

        // Kiểm tra và thêm dữ liệu vào ProductPriceQuantity
        if (units != null && packagingDetails != null && units.length == packagingDetails.length) {
            for (int i = 0; i < units.length; i++) {
                String productUnitId = productID + "_U" + i;
                String packagingDetail = packagingDetails[i];
                String unit = units[i];

                // Tạo đối tượng ProductPriceQuantity
                ProductPriceQuantity p = new ProductPriceQuantity(productUnitId, packagingDetail, productID, unit);
                productDAO.addProductPriceQuantity(p);
            }
        }

        // Chuyển hướng đến trang hiển thị thông tin sản phẩm
        response.sendRedirect("http://localhost:8080/MedicineShop/showProductManageView");
    }
}
