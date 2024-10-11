
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
public class Update extends HttpServlet {

    private static final String UPLOAD_DIRECTORY = "images/products";  // Thư mục lưu ảnh

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();
        CategoryDAO categoryDAO = new CategoryDAO();

        // Lấy productID từ request
        String productID = request.getParameter("productID");

        // Kiểm tra nếu productID khác null và không rỗng
        if (productID != null && !productID.isEmpty()) {
            // Lấy sản phẩm có productID tương ứng
            Product product = productDAO.getProductByID(productID);
            if (product != null) {
                // Đưa sản phẩm vào request để hiển thị trong form
                request.setAttribute("product", product);
            } else {
                // Nếu không tìm thấy sản phẩm, gửi thông báo lỗi
                String error = "Product not found!";
                request.setAttribute("error", error);
            }
        }

        HttpSession session = request.getSession(true);
        List<ProductUnit> units = productDAO.getAllUnits(); // Lấy danh sách Unit
        List<Category> categories = categoryDAO.getAllCategories();
        List<Product> products = productDAO.getAllProducts();

        Gson gson = new Gson();
        String categoriesJSON = gson.toJson(categoryDAO.getAllCategories());
        session.setAttribute("categoriesJSON", categoriesJSON);

        // Đưa danh sách units, products và categories vào request
        session.setAttribute("units", units);
        session.setAttribute("products", products);
        session.setAttribute("categories", categories);

        List<ProductPriceQuantity> priceQuantities = productDAO.getProductPriceQuantitiesByProductID(productID);

        // Gửi danh sách đến JSP
        request.setAttribute("priceQuantities", priceQuantities);
        request.setAttribute("units", units);
        if (productID != null && !productID.isEmpty()) {
            ProductDAO ingredientDAO = new ProductDAO();
            List<Ingredient> ingredients = ingredientDAO.getIngredientsByProductID(productID);

            request.setAttribute("ingredients", ingredients);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID");
        }

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("changeProduct.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO productDAO = new ProductDAO();

        // Create the upload path for saving the image
        String originalPath = getServletContext().getRealPath("");
        String modifiedPath = originalPath.replace("\\build\\web\\", "\\web\\");
        String uploadPath = modifiedPath + File.separator + UPLOAD_DIRECTORY;
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();  // Create the directory if it doesn't exist
        }

        // Handle image upload
        
        Part filePart = request.getPart("imageUpload");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        fileName = fileName.replaceAll("[^a-zA-Z0-9.\\-_]", "_"); // Replace invalid characters
        String filePath = uploadPath + File.separator + fileName;

        // Save the file
        filePart.write(filePath);

        // Retrieve data from the form
        String productID = request.getParameter("productId");

        // Check if the product exists
        Product existingProduct = productDAO.getProductByID(productID);
        if (existingProduct == null) {
            String noti = "Product ID not found!";
            request.setAttribute("noti", noti);
            request.getRequestDispatcher("changeProduct.jsp").forward(request, response);
            return;
        }

        // Collect the rest of the form data
        String categoryID = request.getParameter("categoryId");
        String brand = request.getParameter("brand");
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
        int status = Integer.parseInt(request.getParameter("status"));
        String prescriptionRequired = request.getParameter("prescriptionRequired");
        String targetAudience = request.getParameter("targetAudience");

        // Update the existing product object
        existingProduct.setCategoryID(categoryID);
        existingProduct.setBrand(brand);
        existingProduct.setProductName(productName);
        existingProduct.setPharmaceuticalForm(pharmaceuticalForm);
        existingProduct.setBrandOrigin(brandOrigin);
        existingProduct.setManufacturer(manufacturer);
        existingProduct.setCountryOfProduction(countryOfProduction);
        existingProduct.setShortDescription(shortDescription);
        existingProduct.setRegistrationNumber(registrationNumber);
        existingProduct.setProductDescription(productDescription);
        existingProduct.setFaq(faq);
        existingProduct.setStatus(status);
        existingProduct.setPrescriptionRequired(prescriptionRequired);
        existingProduct.setTargetAudience(targetAudience);

        // Update the product in the database
        productDAO.updateProduct(existingProduct);

        // Save image path in the database if a new image was uploaded
        if (filePart.getSize() > 0) {
            productDAO.saveImagePath(productID, UPLOAD_DIRECTORY + "/" + fileName);
        }

        // Handle ingredients update
        String[] ingredientNames = request.getParameterValues("ingredientName[]");
        String[] InQuantities = request.getParameterValues("InQuantity[]");
        String[] InUnits = request.getParameterValues("InUnit[]");

        // Add updated ingredients
        if (ingredientNames != null) {
            List<Ingredient> ingredients = new ArrayList<>();
            for (int i = 0; i < ingredientNames.length; i++) {
                if (ingredientNames[i] != null && !ingredientNames[i].isEmpty()) {
                    Ingredient ingredient = new Ingredient(productID, i + 1, ingredientNames[i],
                            Float.parseFloat(InQuantities[i]), InUnits[i]);
                    ingredients.add(ingredient);
                }
            }
            // Clear existing ingredients
            productDAO.updateIngredients1(productID, ingredients);
        }

        // Handle ProductPriceQuantity update
        String[] units = request.getParameterValues("unit[]");
        String[] packagingDetails = request.getParameterValues("packagingDetails[]");
        String[] unitStatus = request.getParameterValues("unitStatus[]");

        if (units != null && packagingDetails != null && units.length == packagingDetails.length) {
            List<ProductPriceQuantity> priceQuantities = new ArrayList<>();
            for (int i = 0; i < units.length; i++) {
                String productUnitId = productID + "_U" + i;
                String packagingDetail = packagingDetails[i];
                String unit = units[i];
                int UStatus = Integer.parseInt(unitStatus[i]);

                // Create ProductPriceQuantity object
                ProductPriceQuantity p = new ProductPriceQuantity(productUnitId, packagingDetail, productID, unit, UStatus);
                priceQuantities.add(p);
            }
            // Add all price-quantity details to the database
            productDAO.updateProductPriceQuantity2(productID, priceQuantities); // Modify this method to accept a list
        }

        // Redirect to the product management view
        response.sendRedirect("http://localhost:8080/MedicineShop/showProductManageView");
    }

}
