package dal;

import model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
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
        String sql = "INSERT INTO ProductPriceQuantity (ProductUnitID, PackagingDetails, ProductID, UnitID) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, p.getProductUnitID());
            ps.setString(2, p.getPackagingDetails());
            ps.setString(3, p.getProductID());
            ps.setString(4, p.getUnitID());

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

                // Tạo đối tượng ProductPriceQuantity và thêm vào danh sách
                ProductPriceQuantity productPriceQuantity = new ProductPriceQuantity(productUnitID, packagingDetails, productID, unitID);
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
                ProductPriceQuantity priceQuantity = new ProductPriceQuantity(productUnitID, packagingDetails, productID, unitID);
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


}
