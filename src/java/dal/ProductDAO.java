package dal;

import model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import model.Ingredient;
import model.ProductPriceQuantity;
import model.ProductUnit;

public class ProductDAO extends DBContext {

    public ProductDAO() {
    }

    // Function to add a product to the database
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO Product (CategoryID, Brand, ProductID, ProductName, PharmaceuticalForm, "
                + "BrandOrigin, Manufacturer, CountryOfProduction, ShortDescription, RegistrationNumber, "
                + "ProductDescription, ContentReviewer, FAQ, ProductReviews, Status, Sold, DateCreated, "
                + "ProductVersion, PrescriptionRequired, TargetAudience) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, product.getCategoryID());
            ps.setString(2, product.getBrand());
            ps.setString(3, product.getProductID());
            ps.setString(4, product.getProductName());
            ps.setString(5, product.getPharmaceuticalForm());
            ps.setString(6, product.getBrandOrigin());
            ps.setString(7, product.getManufacturer());
            ps.setString(8, product.getCountryOfProduction());
            ps.setString(9, product.getShortDescription());
            ps.setString(10, product.getRegistrationNumber());
            ps.setString(11, product.getProductDescription());
            ps.setString(12, product.getContentReviewer());
            ps.setString(13, product.getFaq());
            ps.setString(14, product.getProductReviews());
            ps.setInt(15, product.getStatus());
            ps.setInt(16, product.getSold());
            ps.setDate(17, java.sql.Date.valueOf(product.getDateCreated()));
            ps.setInt(18, product.getProductVersion());
            ps.setString(19, product.getPrescriptionRequired());
            ps.setString(20, product.getTargetAudience());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Hàm để thêm danh sách các nguyên liệu vào bảng Ingredient
    public boolean addIngredients(String productID, List<Ingredient> ingredients) {
        String sql = "INSERT INTO Ingredient (ProductIngredientID, ProductID, IngredientName, Quantity, Unit) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Bắt đầu giao dịch
            connection.setAutoCommit(false);

            for (int i = 0; i < ingredients.size(); i++) {
                Ingredient ingredient = ingredients.get(i);

                // Thiết lập ProductIngredientID bằng cách kết hợp ProductID và số thứ tự của thành phần
                String productIngredientID = productID + "_I" + (i + 1);  // VD: P001_1, P001_2, ...

                ps.setString(1, productIngredientID); // ProductIngredientID
                ps.setString(2, productID);            // ProductID
                ps.setString(3, ingredient.getIngredientName()); // Tên nguyên liệu
                ps.setFloat(4, ingredient.getQuantity());        // Số lượng
                ps.setString(5, ingredient.getUnit());           // Đơn vị

                // Thêm vào batch
                ps.addBatch();
            }

            // Thực thi batch
            ps.executeBatch();

            // Commit giao dịch
            connection.commit();

            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                // Nếu có lỗi, rollback giao dịch
                connection.rollback();
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            try {
                // Đảm bảo reset lại auto-commit về true sau khi giao dịch kết thúc
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public List<ProductUnit> getAllUnits() {
        List<ProductUnit> units = new ArrayList<>();
        String sql = "SELECT UnitID, UnitName FROM Unit";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String unitID = rs.getString("UnitID");
                String unitName = rs.getString("UnitName");
                units.add(new ProductUnit(unitID, unitName)); // Tạo đối tượng Unit và thêm vào danh sách
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return units;
    }

    public boolean addProductPriceQuantity(ProductPriceQuantity p) {
        String sql = "INSERT INTO ProductPriceQuantity (ProductUnitID, PackagingDetails, ProductID, UnitID, UnitStatus) VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, p.getProductUnitID());
            ps.setString(2, p.getPackagingDetails());
            ps.setString(3, p.getProductID());
            ps.setString(4, p.getUnitID());
            ps.setInt(5, p.getUnitStatus());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Product";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // Retrieve all fields from the result set and create a new Product object
                String categoryID = rs.getString("CategoryID");
                String brand = rs.getString("Brand");
                String productID = rs.getString("ProductID");
                String productName = rs.getString("ProductName");
                String pharmaceuticalForm = rs.getString("PharmaceuticalForm");
                String brandOrigin = rs.getString("BrandOrigin");
                String manufacturer = rs.getString("Manufacturer");
                String countryOfProduction = rs.getString("CountryOfProduction");
                String shortDescription = rs.getString("ShortDescription");
                String registrationNumber = rs.getString("RegistrationNumber");
                String productDescription = rs.getString("ProductDescription");
                String contentReviewer = rs.getString("ContentReviewer");
                String faq = rs.getString("FAQ");
                String productReviews = rs.getString("ProductReviews");
                int status = rs.getInt("Status");
                int sold = rs.getInt("Sold");
                String dateCreated = rs.getString("DateCreated");
                int productVersion = rs.getInt("ProductVersion");
                String prescriptionRequired = rs.getString("PrescriptionRequired");
                String targetAudience = rs.getString("TargetAudience");
                String imagePath = rs.getString("ImagePath");

                // Initialize the Product object and add it to the list
                Product product = new Product(categoryID, brand, productID, productName, pharmaceuticalForm, brandOrigin,
                        manufacturer, countryOfProduction, shortDescription, registrationNumber,
                        productDescription, contentReviewer, faq, productReviews, status, sold,
                        dateCreated, productVersion, prescriptionRequired, targetAudience, imagePath);
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }

    public Product getProductByID(String id) {

        String sql = "SELECT * FROM Product Where productID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Retrieve all fields from the result set and create a new Product object
                String categoryID = rs.getString("CategoryID");
                String brand = rs.getString("Brand");
                String productID = rs.getString("ProductID");
                String productName = rs.getString("ProductName");
                String pharmaceuticalForm = rs.getString("PharmaceuticalForm");
                String brandOrigin = rs.getString("BrandOrigin");
                String manufacturer = rs.getString("Manufacturer");
                String countryOfProduction = rs.getString("CountryOfProduction");
                String shortDescription = rs.getString("ShortDescription");
                String registrationNumber = rs.getString("RegistrationNumber");
                String productDescription = rs.getString("ProductDescription");
                String contentReviewer = rs.getString("ContentReviewer");
                String faq = rs.getString("FAQ");
                String productReviews = rs.getString("ProductReviews");
                int status = rs.getInt("Status");
                int sold = rs.getInt("Sold");
                String dateCreated = rs.getString("DateCreated");
                int productVersion = rs.getInt("ProductVersion");
                String prescriptionRequired = rs.getString("PrescriptionRequired");
                String targetAudience = rs.getString("TargetAudience");
                String imagePath = rs.getString("ImagePath");

                // Initialize the Product object and add it to the list
                Product product = new Product(categoryID, brand, productID, productName, pharmaceuticalForm, brandOrigin,
                        manufacturer, countryOfProduction, shortDescription, registrationNumber,
                        productDescription, contentReviewer, faq, productReviews, status, sold,
                        dateCreated, productVersion, prescriptionRequired, targetAudience, imagePath);
                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public List<Ingredient> getIngredientsByProductID(String productID) {
        List<Ingredient> ingredients = new ArrayList<>();
        String sql = "SELECT ProductIngredientID, ProductID, IngredientName, Quantity, Unit FROM Ingredient WHERE ProductID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String productIngredientID = rs.getString("ProductIngredientID");
                String ingredientName = rs.getString("IngredientName");
                float quantity = rs.getFloat("Quantity");
                String unit = rs.getString("Unit");

                // Tạo đối tượng Ingredient và thêm vào danh sách
                Ingredient ingredient = new Ingredient(productID, 0, ingredientName, quantity, unit);
                ingredient.setProductIngredientID(productIngredientID); // Thiết lập ProductIngredientID
                ingredients.add(ingredient);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return ingredients;
    }

    public List<ProductPriceQuantity> getAllProductPriceQuantities() {
        List<ProductPriceQuantity> priceQuantities = new ArrayList<>();
        String sql = "SELECT * FROM ProductPriceQuantity";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String productUnitID = rs.getString("ProductUnitID");
                String packagingDetails = rs.getString("PackagingDetails");
                String productID = rs.getString("ProductID");
                String unitID = rs.getString("UnitID");
                int unitStatus = rs.getInt("UnitStatus");

                // Tạo đối tượng ProductPriceQuantity và thêm vào danh sách
                ProductPriceQuantity productPriceQuantity = new ProductPriceQuantity(productUnitID, packagingDetails, productID, unitID, unitStatus);
                priceQuantities.add(productPriceQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return priceQuantities;
    }

    public List<ProductPriceQuantity> getProductPriceQuantitiesByProductID(String productID) {
        List<ProductPriceQuantity> priceQuantities = new ArrayList<>();
        String sql = "SELECT * FROM ProductPriceQuantity WHERE ProductID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Tạo đối tượng ProductPriceQuantity và thêm vào danh sách
                String productUnitID = rs.getString("ProductUnitID");
                String packagingDetails = rs.getString("PackagingDetails");
                String unitID = rs.getString("UnitID");
                int unitStatus = rs.getInt("UnitStatus");
                ProductPriceQuantity priceQuantity = new ProductPriceQuantity(productUnitID, packagingDetails, productID, unitID, unitStatus);
                priceQuantities.add(priceQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return priceQuantities;
    }

    public void saveImagePath(String productID, String imagePath) {
        String sql = "UPDATE product SET imagepath = ? WHERE productid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, imagePath);
            ps.setString(2, productID);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(String productID) {
        String sql = "UPDATE Product SET status = 0 WHERE productID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productID);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public boolean updateProduct(Product product) {
        String sql = "UPDATE Product SET CategoryID = ?, Brand = ?, ProductName = ?, PharmaceuticalForm = ?, "
                + "BrandOrigin = ?, Manufacturer = ?, CountryOfProduction = ?, ShortDescription = ?, "
                + "RegistrationNumber = ?, ProductDescription = ?, ContentReviewer = ?, FAQ = ?, "
                + "ProductReviews = ?, Status = ?, Sold = ?, DateCreated = ?, ProductVersion = ?, "
                + "PrescriptionRequired = ?, TargetAudience = ? WHERE ProductID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, product.getCategoryID());
            ps.setString(2, product.getBrand());
            ps.setString(3, product.getProductName());
            ps.setString(4, product.getPharmaceuticalForm());
            ps.setString(5, product.getBrandOrigin());
            ps.setString(6, product.getManufacturer());
            ps.setString(7, product.getCountryOfProduction());
            ps.setString(8, product.getShortDescription());
            ps.setString(9, product.getRegistrationNumber());
            ps.setString(10, product.getProductDescription());
            ps.setString(11, product.getContentReviewer());
            ps.setString(12, product.getFaq());
            ps.setString(13, product.getProductReviews());
            ps.setInt(14, product.getStatus());
            ps.setInt(15, product.getSold());
            ps.setDate(16, java.sql.Date.valueOf(product.getDateCreated()));
            ps.setInt(17, product.getProductVersion());
            ps.setString(18, product.getPrescriptionRequired());
            ps.setString(19, product.getTargetAudience());
            ps.setString(20, product.getProductID());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean beginTransaction() {
        try {
            connection.setAutoCommit(false);
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void commitTransaction() {
        try {
            connection.commit();
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void rollbackTransaction() {
        try {
            connection.rollback();
            connection.setAutoCommit(true);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

// Hàm xóa một Ingredient theo ProductIngredientID
    public boolean deleteIngredientByID(String productIngredientID) {
        String sql = "DELETE FROM Ingredient WHERE ProductIngredientID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productIngredientID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một dòng bị xóa
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// Hàm xóa một ProductPriceQuantity theo ProductUnitID
    public boolean deleteProductPriceQuantityByID(String productUnitID) {
        String sql = "DELETE FROM ProductPriceQuantity WHERE ProductUnitID = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productUnitID);

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Trả về true nếu có ít nhất một dòng bị xóa
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateIngredients1(String productId, List<Ingredient> ingredients) {
        String updateSql = "UPDATE Ingredient SET IngredientName = ?, Quantity = ?, Unit = ? WHERE ProductIngredientID = ? AND ProductID = ?";
        String insertSql = "INSERT INTO Ingredient (ProductIngredientID, ProductID, IngredientName, Quantity, Unit) VALUES (?, ?, ?, ?, ?)";

        Set<String> updatedIngredientIDs = new HashSet<>(); // Set để theo dõi các ID đã cập nhật

        try {
            connection.setAutoCommit(false);

            // Thực hiện cập nhật
            try (PreparedStatement updatePs = connection.prepareStatement(updateSql)) {
                for (Ingredient ingredient : ingredients) {
                    updatePs.setString(1, ingredient.getIngredientName());
                    updatePs.setFloat(2, ingredient.getQuantity());
                    updatePs.setString(3, ingredient.getUnit());
                    updatePs.setString(4, ingredient.getProductIngredientID());
                    updatePs.setString(5, productId);

                    int rowsUpdated = updatePs.executeUpdate();
                    if (rowsUpdated > 0) {
                        updatedIngredientIDs.add(ingredient.getProductIngredientID()); // Thêm ID vào set nếu đã cập nhật
                    }
                }
            }

            // Thực hiện thêm mới
            try (PreparedStatement insertPs = connection.prepareStatement(insertSql)) {
                for (Ingredient ingredient : ingredients) {
                    // Chỉ thêm mới nếu ID chưa có trong danh sách đã cập nhật
                    if (!updatedIngredientIDs.contains(ingredient.getProductIngredientID())) {
                        insertPs.setString(1, ingredient.getProductIngredientID());
                        insertPs.setString(2, productId);
                        insertPs.setString(3, ingredient.getIngredientName());
                        insertPs.setFloat(4, ingredient.getQuantity());
                        insertPs.setString(5, ingredient.getUnit());
                        insertPs.executeUpdate();
                    }
                }
            }

            connection.commit(); // Cam kết giao dịch
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback(); // Quay lại nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            try {
                connection.setAutoCommit(true); // Đặt lại auto-commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    public boolean updateProductPriceQuantity2(String productId, List<ProductPriceQuantity> priceQuantities) {
        String updateSql = "UPDATE ProductPriceQuantity SET PackagingDetails = ?, UnitID = ?, UnitStatus = ? WHERE ProductUnitID = ? AND ProductID = ?";
        String insertSql = "INSERT INTO ProductPriceQuantity (ProductUnitID, ProductID, PackagingDetails, UnitID, UnitStatus) VALUES (?, ?, ?, ?, ?)";

        Set<String> updatedProductUnitIDs = new HashSet<>(); // Set để theo dõi các ID đã cập nhật

        try {
            connection.setAutoCommit(false);

            // Thực hiện cập nhật
            try (PreparedStatement updatePs = connection.prepareStatement(updateSql)) {
                for (ProductPriceQuantity p : priceQuantities) {
                    updatePs.setString(1, p.getPackagingDetails());
                    updatePs.setString(2, p.getUnitID());
                    updatePs.setInt(3, p.getUnitStatus()); // Thêm unitStatus cho câu lệnh update
                    updatePs.setString(4, p.getProductUnitID());
                    updatePs.setString(5, productId);

                    int rowsUpdated = updatePs.executeUpdate();
                    if (rowsUpdated > 0) {
                        updatedProductUnitIDs.add(p.getProductUnitID()); // Thêm ID vào set nếu đã cập nhật
                    }
                }
            }

            // Thực hiện thêm mới
            try (PreparedStatement insertPs = connection.prepareStatement(insertSql)) {
                for (ProductPriceQuantity p : priceQuantities) {
                    // Chỉ thêm mới nếu ID chưa có trong danh sách đã cập nhật
                    if (!updatedProductUnitIDs.contains(p.getProductUnitID())) {
                        insertPs.setString(1, p.getProductUnitID());
                        insertPs.setString(2, productId);
                        insertPs.setString(3, p.getPackagingDetails());
                        insertPs.setString(4, p.getUnitID());
                        insertPs.setInt(5, p.getUnitStatus()); // Thêm unitStatus cho câu lệnh insert
                        insertPs.executeUpdate();
                    }
                }
            }

            connection.commit(); // Cam kết giao dịch
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback(); // Quay lại nếu có lỗi
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            return false;
        } finally {
            try {
                connection.setAutoCommit(true); // Đặt lại auto-commit
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

}
