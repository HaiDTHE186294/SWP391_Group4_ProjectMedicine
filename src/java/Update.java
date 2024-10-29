
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
import java.sql.SQLException;
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

        try {
            // Lấy danh sách quốc gia và nhóm đối tượng
            List<String> countries = productDAO.getAllCountries();
            List<String> audiences = productDAO.getAllAudiences();

            // Đưa danh sách quốc gia và đối tượng vào session
            session.setAttribute("countries", countries);
            session.setAttribute("audiences", audiences);

        } catch (SQLException e) {
            e.printStackTrace();
        }

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
        Product existingProduct = productDAO.getProductByID(productID);


        if (existingProduct == null) {
            String noti = "Product ID not found!";
            request.setAttribute("noti", noti);
            request.getRequestDispatcher("changeProduct.jsp").forward(request, response);
            return;
        }
        
//Kiểm tra nếu đổi name thì đổi cả
        if (existingProduct.getSold() != 0 && !existingProduct.getProductName().equals(request.getParameter("productName"))) {
            // Prepare to add a new product (modify productID and productVersion as needed)

            int newVersion = existingProduct.getProductVersion() + 1; // Increment the version for the new product
            String newProductID;
            if (productID.contains("_")) {
                // If the ID has underscores, reset to the base ID (part before the first underscore)
                newProductID = productID.split("_")[0] + "_" + newVersion; // Keep the base ID and add new version
            } else {
                // If the ID is just a number, append the new version
                newProductID = productID + "_" + newVersion;
            }

            // Check for uniqueness of newProductID
            int counter = 1;
            while (productDAO.getProductByID(newProductID) != null) {
                // If the ID already exists, append the counter
                newProductID = newProductID.split("_")[0] + "_" + newVersion + "_" + counter;
                counter++;
            }

            existingProduct.setProductID(newProductID);
            existingProduct.setProductVersion(newVersion); // Assuming there's a setVersion() method in the Product class

            // Add new product details
            addProduct(request, existingProduct, filePart, productDAO, fileName);

            // Add ingredients for the new product
            addIngredients(request, newProductID, productDAO);

            // Add product price quantity for the new product
            addProductPriceQuantity(request, newProductID, productDAO);
        } else {
            // Update product details
            updateProduct(request, existingProduct, filePart, productDAO, fileName);

            // Update ingredients
            updateIngredients(request, productID, productDAO);

            // Update ProductPriceQuantity
            updateProductPriceQuantity(request, productID, productDAO);
        } 

        // Redirect to the product management view
        response.sendRedirect("http://localhost:8080/MedicineShop/showProductManageView");
    }

    private void updateProduct(HttpServletRequest request, Product existingProduct, Part filePart, ProductDAO productDAO, String fileName) {
        // Collect the rest of the form data
        existingProduct.setCategoryID(request.getParameter("categoryId"));
        existingProduct.setBrand(request.getParameter("brand"));
        existingProduct.setProductName(request.getParameter("productName"));
        existingProduct.setPharmaceuticalForm(request.getParameter("pharmaceuticalForm"));
        existingProduct.setBrandOrigin(request.getParameter("brandOrigin"));
        existingProduct.setManufacturer(request.getParameter("manufacturer"));
        existingProduct.setCountryOfProduction(request.getParameter("countryOfProduction"));
        existingProduct.setShortDescription(request.getParameter("shortDescription"));
        existingProduct.setRegistrationNumber(request.getParameter("registrationNumber"));
        existingProduct.setProductDescription(request.getParameter("description"));
        existingProduct.setFaq(request.getParameter("faq"));
        existingProduct.setStatus(Integer.parseInt(request.getParameter("status")));
        existingProduct.setPrescriptionRequired(request.getParameter("prescriptionRequired"));
        existingProduct.setTargetAudience(request.getParameter("targetAudience"));
        existingProduct.setIng(request.getParameter("ing"));

        // Update the product in the database
        productDAO.updateProduct(existingProduct);
        productDAO.addIng(existingProduct.getProductID(), existingProduct.getIng());

        // Save image path in the database if a new image was uploaded
        if (filePart.getSize() > 0) {
            productDAO.saveImagePath(existingProduct.getProductID(), UPLOAD_DIRECTORY + "/" + fileName);
        }
    }

    private void addProduct(HttpServletRequest request, Product existingProduct, Part filePart, ProductDAO productDAO, String fileName) {
        // Collect the rest of the form data
        existingProduct.setCategoryID(request.getParameter("categoryId"));
        existingProduct.setBrand(request.getParameter("brand"));
        existingProduct.setProductName(request.getParameter("productName"));
        existingProduct.setPharmaceuticalForm(request.getParameter("pharmaceuticalForm"));
        existingProduct.setBrandOrigin(request.getParameter("brandOrigin"));
        existingProduct.setManufacturer(request.getParameter("manufacturer"));
        existingProduct.setCountryOfProduction(request.getParameter("countryOfProduction"));
        existingProduct.setShortDescription(request.getParameter("shortDescription"));
        existingProduct.setRegistrationNumber(request.getParameter("registrationNumber"));
        existingProduct.setProductDescription(request.getParameter("description"));
        existingProduct.setFaq(request.getParameter("faq"));
        existingProduct.setStatus(Integer.parseInt(request.getParameter("status")));
        existingProduct.setPrescriptionRequired(request.getParameter("prescriptionRequired"));
        existingProduct.setTargetAudience(request.getParameter("targetAudience"));
        existingProduct.setIng(request.getParameter("ing"));
        existingProduct.setSold(0);

        // Update the product in the database
        productDAO.addProduct(existingProduct);
        productDAO.addIng(existingProduct.getProductID(), existingProduct.getIng());

        // Save image path in the database if a new image was uploaded
        if (filePart.getSize() > 0) {
            productDAO.saveImagePath(existingProduct.getProductID(), UPLOAD_DIRECTORY + "/" + fileName);
        }
    }

    private void updateIngredients(HttpServletRequest request, String productID, ProductDAO productDAO) {
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
    }

    private void addIngredients(HttpServletRequest request, String productID, ProductDAO productDAO) {
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
            productDAO.addIngredients(productID, ingredients);
        }
    }

    private void updateProductPriceQuantity(HttpServletRequest request, String productID, ProductDAO productDAO) {
        // Handle ProductPriceQuantity update
        String[] units = request.getParameterValues("unit[]");
        String[] packagingDetails = request.getParameterValues("packagingDetails[]");
        String[] unitStatus = request.getParameterValues("unitStatus[]");
        String[] salePrices = request.getParameterValues("salePrice[]");

        if (units != null && packagingDetails != null && units.length == packagingDetails.length) {
            List<ProductPriceQuantity> priceQuantities = new ArrayList<>();
            for (int i = 0; i < units.length; i++) {
                String productUnitId = productID + "_U" + i;
                String packagingDetail = packagingDetails[i];
                String unit = units[i];
                int UStatus = Integer.parseInt(unitStatus[i]);
                float sPrice = Float.parseFloat(salePrices[i]);

                // Create ProductPriceQuantity object
                ProductPriceQuantity p = new ProductPriceQuantity(productUnitId, productID, unit, packagingDetail, sPrice, UStatus);
                priceQuantities.add(p);
            }
            // Add all price-quantity details to the database
            productDAO.updateProductPriceQuantity2(productID, priceQuantities); // Modify this method to accept a list
        }
    }

    private void addProductPriceQuantity(HttpServletRequest request, String productID, ProductDAO productDAO) {
        // Handle ProductPriceQuantity update
        String[] units = request.getParameterValues("unit[]");
        String[] packagingDetails = request.getParameterValues("packagingDetails[]");
        String[] unitStatus = request.getParameterValues("unitStatus[]");
        String[] salePrices = request.getParameterValues("salePrice[]");

        if (units != null && packagingDetails != null && units.length == packagingDetails.length) {
            List<ProductPriceQuantity> priceQuantities = new ArrayList<>();
            for (int i = 0; i < units.length; i++) {
                String productUnitId = productID + "_U" + i;
                String packagingDetail = packagingDetails[i];
                String unit = units[i];
                int UStatus = Integer.parseInt(unitStatus[i]);
                float sPrice = Float.parseFloat(salePrices[i]);

                // Create ProductPriceQuantity object
                ProductPriceQuantity p = new ProductPriceQuantity(productUnitId, productID, unit,packagingDetail, sPrice, UStatus);
                productDAO.addProductPriceQuantity(p);
            }

        }
    }

}
