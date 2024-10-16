package dal;

import model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import java.util.logging.Level;
import java.util.logging.Logger;

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
        String sql = "INSERT INTO ProductPriceQuantity (ProductUnitID, PackagingDetails, ProductID, UnitID, UnitStatus, SalePrice) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, p.getProductUnitID());
            ps.setString(2, p.getPackagingDetails());
            ps.setString(3, p.getProductID());
            ps.setString(4, p.getUnitID());
            ps.setInt(5, p.getUnitStatus());
            ps.setFloat(6, p.getSalePrice());

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
                String ing = rs.getString("Ing");

                // Initialize the Product object and add it to the list
                Product product = new Product(categoryID, brand, productID, productName, pharmaceuticalForm, brandOrigin,
                        manufacturer, countryOfProduction, shortDescription, registrationNumber,
                        productDescription, contentReviewer, faq, productReviews, status, sold,
                        dateCreated, productVersion, prescriptionRequired, targetAudience, imagePath, ing);
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
                String ing = rs.getString("Ing");

                // Initialize the Product object and add it to the list
                Product product = new Product(categoryID, brand, productID, productName, pharmaceuticalForm, brandOrigin,
                        manufacturer, countryOfProduction, shortDescription, registrationNumber,
                        productDescription, contentReviewer, faq, productReviews, status, sold,
                        dateCreated, productVersion, prescriptionRequired, targetAudience, imagePath, ing);
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
                float salePrice = rs.getFloat("SalePrice");

                // Tạo đối tượng ProductPriceQuantity và thêm vào danh sách
                ProductPriceQuantity productPriceQuantity = new ProductPriceQuantity(productUnitID, packagingDetails, productID, unitID, unitStatus, salePrice);
                priceQuantities.add(productPriceQuantity);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return priceQuantities;
    }
    
     public ProductPriceQuantity getProductPriceQuantitiesByProductIDforImport(String productID) {
        String sql = "SELECT * FROM ProductPriceQuantity WHERE ProductID = ? and PackagingDetails = 1";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, productID);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                // Tạo đối tượng ProductPriceQuantity và thêm vào danh sách
                String productUnitID = rs.getString("ProductUnitID");
                String packagingDetails = rs.getString("PackagingDetails");
                String unitID = rs.getString("UnitID");
                int unitStatus = rs.getInt("UnitStatus");
                float salePrice = rs.getFloat("SalePrice");
                ProductPriceQuantity priceQuantity = new ProductPriceQuantity(productUnitID, packagingDetails, productID, unitID, unitStatus, salePrice);
                return priceQuantity;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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
                float salePrice = rs.getFloat("SalePrice");
                ProductPriceQuantity priceQuantity = new ProductPriceQuantity(productUnitID, packagingDetails, productID, unitID, unitStatus, salePrice);
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
    
    public void addIng(String productID, String ing) {
        String sql = "UPDATE product SET ing = ? WHERE productid = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, ing);
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

    // Method to get the top 8 sold products
    public List<Map<String, Object>> getTop8SoldProducts() {
        List<Map<String, Object>> productList = new ArrayList<>();
        String sql = "SELECT TOP 8 p.ProductID, p.ProductName, p.ImagePath, pp.SalePrice, u.UnitName "
                + "FROM Product p "
                + "JOIN ProductPriceQuantity pp ON p.ProductID = pp.ProductID "
                + "JOIN Unit u ON pp.UnitID = u.UnitID "
                + "WHERE pp.PackagingDetails = 1 "
                + "ORDER BY p.Sold DESC";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> productDetails = new HashMap<>();
                productDetails.put("ProductID", rs.getString("ProductID"));
                productDetails.put("productName", rs.getString("ProductName"));
                productDetails.put("imagePath", rs.getString("ImagePath"));
                productDetails.put("salePrice", rs.getFloat("SalePrice"));
                productDetails.put("unitName", rs.getString("UnitName"));

                productList.add(productDetails);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return productList;
    }

    // Method to get the top 8 latest products
    public List<Map<String, Object>> getLatest8Products() {
        List<Map<String, Object>> productList = new ArrayList<>();
        String sql = "SELECT TOP 8 p.ProductID, p.ProductName, p.ImagePath, pp.SalePrice, u.UnitName "
                + "FROM Product p "
                + "JOIN ProductPriceQuantity pp ON p.ProductID = pp.ProductID "
                + "JOIN Unit u ON pp.UnitID = u.UnitID "
                + "WHERE pp.PackagingDetails = 1 "
                + "ORDER BY p.DateCreated DESC";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Map<String, Object> productData = new HashMap<>();
                productData.put("ProductID", rs.getString("ProductID"));
                productData.put("ProductName", rs.getString("ProductName"));
                productData.put("ImagePath", rs.getString("ImagePath"));
                productData.put("SalePrice", rs.getFloat("salePrice"));
                productData.put("UnitName", rs.getString("UnitName"));

                productList.add(productData);  // Add to the list
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return productList;
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
    // Câu SQL để xóa tất cả các nguyên liệu của sản phẩm
    String deleteSql = "DELETE FROM Ingredient WHERE ProductID = ?";
    // Câu SQL để thêm các nguyên liệu mới
    String insertSql = "INSERT INTO Ingredient (ProductIngredientID, ProductID, IngredientName, Quantity, Unit) VALUES (?, ?, ?, ?, ?)";

    try {
        // Bắt đầu một giao dịch
        connection.setAutoCommit(false);

        // Xóa các nguyên liệu hiện tại
        try (PreparedStatement deletePs = connection.prepareStatement(deleteSql)) {
            deletePs.setString(1, productId);
            deletePs.executeUpdate();
        }

        // Thêm các nguyên liệu mới
        try (PreparedStatement insertPs = connection.prepareStatement(insertSql)) {
            for (Ingredient ingredient : ingredients) {
                insertPs.setString(1, ingredient.getProductIngredientID());
                insertPs.setString(2, productId);
                insertPs.setString(3, ingredient.getIngredientName());
                insertPs.setFloat(4, ingredient.getQuantity());
                insertPs.setString(5, ingredient.getUnit());
                insertPs.executeUpdate();
            }
        }

        // Commit giao dịch sau khi tất cả các hoạt động thành công
        connection.commit();
        return true;

    } catch (SQLException e) {
        e.printStackTrace();
        try {
            connection.rollback(); // Rollback nếu có lỗi xảy ra
        } catch (SQLException rollbackEx) {
            rollbackEx.printStackTrace();
        }
        return false;
    } finally {
        try {
            connection.setAutoCommit(true); // Đặt lại chế độ auto-commit
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}


    public boolean updateProductPriceQuantity2(String productId, List<ProductPriceQuantity> priceQuantities) {
        String updateSql = "UPDATE ProductPriceQuantity SET PackagingDetails = ?, UnitID = ?, UnitStatus = ?, SalePrice = ? WHERE ProductUnitID = ? AND ProductID = ?";
        String insertSql = "INSERT INTO ProductPriceQuantity (ProductUnitID, ProductID, PackagingDetails, UnitID, UnitStatus, SalePrice) VALUES (?, ?, ?, ?, ?, ?)";

        Set<String> updatedProductUnitIDs = new HashSet<>(); // Set để theo dõi các ID đã cập nhật

        try {
            connection.setAutoCommit(false);

            // Thực hiện cập nhật
            try (PreparedStatement updatePs = connection.prepareStatement(updateSql)) {
                for (ProductPriceQuantity p : priceQuantities) {
                    updatePs.setString(1, p.getPackagingDetails());
                    updatePs.setString(2, p.getUnitID());
                    updatePs.setInt(3, p.getUnitStatus()); // Thêm unitStatus cho câu lệnh update
                    updatePs.setFloat(4,p.getSalePrice());
                    updatePs.setString(5, p.getProductUnitID());
                    updatePs.setString(6, productId);

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
                        insertPs.setFloat(6, p.getSalePrice());
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
    
    // Lấy danh sách quốc gia
    public List<String> getAllCountries() throws SQLException {
        List<String> countries = new ArrayList<>();
        String sql = "SELECT CountryName FROM Country";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String country = rs.getString("CountryName");
                countries.add(country);
            }
        }
        return countries;
    }

    // Lấy danh sách nhóm đối tượng
    public List<String> getAllAudiences() throws SQLException {
        List<String> audiences = new ArrayList<>();
        String sql = "SELECT TargetAudience FROM Audience";

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                String audience = rs.getString("TargetAudience");
                audiences.add(audience);
            }
        }
        return audiences;
    }

}
