package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import model.Product;

public class CategoryDAO extends DBContext {

    // Phương thức để lấy tất cả danh mục từ cơ sở dữ liệu
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, icon, CategoryName, ParentCategoryID FROM Category";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String categoryID = rs.getString("CategoryID");
                String icon = rs.getString("icon");
                String categoryName = rs.getString("CategoryName");
                String parentCategoryID = rs.getString("ParentCategoryID");

                // Tạo đối tượng Category và thêm vào danh sách
                categories.add(new Category(categoryID, icon, categoryName, parentCategoryID));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<Category> getAllCategoriesR1() {
        List<Category> categories = new ArrayList<>();
        String query = "select * from Category where ParentCategoryID = 'R1'";

        try (PreparedStatement statement = connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Category category = new Category();
                category.setCategoryID(resultSet.getString("CategoryID"));
                category.setCategoryName(resultSet.getString("CategoryName"));
                category.setParentCategoryID(resultSet.getString("ParentCategoryID"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<Category> getAllCategoriesR2() {
        List<Category> categories = new ArrayList<>();
        String query = "select * from Category where ParentCategoryID = 'R2'";

        try (PreparedStatement statement = connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Category category = new Category();
                category.setCategoryID(resultSet.getString("CategoryID"));
                category.setCategoryName(resultSet.getString("CategoryName"));
                category.setParentCategoryID(resultSet.getString("ParentCategoryID"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<Category> getAllCategoriesR3() {
        List<Category> categories = new ArrayList<>();
        String query = "select * from Category where ParentCategoryID = 'R3'";

        try (PreparedStatement statement = connection.prepareStatement(query); ResultSet resultSet = statement.executeQuery()) {

            while (resultSet.next()) {
                Category category = new Category();
                category.setCategoryID(resultSet.getString("CategoryID"));
                category.setCategoryName(resultSet.getString("CategoryName"));
                category.setParentCategoryID(resultSet.getString("ParentCategoryID"));
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

    public List<Category> getSubcategoriesByParent(String parentCategoryID) {
        List<Category> subcategories = new ArrayList<>();
        String query = "SELECT * FROM Category WHERE ParentCategoryID = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, parentCategoryID);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Category category = new Category();
                category.setCategoryID(resultSet.getString("CategoryID"));
                category.setCategoryName(resultSet.getString("CategoryName"));
                category.setParentCategoryID(resultSet.getString("ParentCategoryID"));
                subcategories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return subcategories;
    }

    public List<Map<String, Object>> getProductsByCategory(String categoryID) {
        List<Map<String, Object>> productList = new ArrayList<>();

        String sql = "SELECT p.CountryOfProduction, p.TargetAudience, p.ProductID, p.ProductName, p.ImagePath, pp.SalePrice, u.UnitName "
            + "FROM Product p "
            + "JOIN Category c ON p.CategoryID = c.CategoryID "
            + "JOIN ProductPriceQuantity pp ON p.ProductID = pp.ProductID "
            + "JOIN Unit u ON pp.UnitID = u.UnitID "
            + "JOIN Stock s ON p.ProductID = s.Pid "
            + "WHERE pp.PackagingDetails = 1 "
            + "AND (p.CategoryID = ? OR c.ParentCategoryID = ?) "
            + "AND c.Status = 1 "
            + "GROUP BY p.CountryOfProduction, p.TargetAudience, p.ProductID, p.ProductName, p.ImagePath, pp.SalePrice, u.UnitName "
            + "HAVING MIN(s.quantity) > 0;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            // Set giá trị của categoryID
            ps.setString(1, categoryID);
            ps.setString(2, categoryID); // Set giá trị cho ParentCategoryID

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> productDetails = new HashMap<>();
                    productDetails.put("ProductID", rs.getString("ProductID"));
                    productDetails.put("productName", rs.getString("ProductName"));
                    productDetails.put("imagePath", rs.getString("ImagePath"));
                    productDetails.put("salePrice", rs.getFloat("SalePrice"));
                    productDetails.put("unitName", rs.getString("UnitName"));
                    productDetails.put("countryofproduction", rs.getString("CountryOfProduction"));
                    productDetails.put("audience", rs.getString("TargetAudience"));

                    productList.add(productDetails);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public List<Map<String, Object>> getProductsByCategoryR1() {
        return getProductsByParentCategory("R1");
    }

    public List<Map<String, Object>> getProductsByCategoryR2() {
        return getProductsByParentCategory("R2");
    }

    public List<Map<String, Object>> getProductsByCategoryR3() {
        return getProductsByParentCategory("R3");
    }

    public List<Map<String, Object>> getProductsByParentCategory(String parentCategoryID) {
        List<Map<String, Object>> productList = new ArrayList<>();

        String sql = "SELECT p.CountryOfProduction, p.TargetAudience, p.ProductID, p.ProductName, p.ImagePath, pp.SalePrice, u.UnitName "
            + "FROM Product p "
            + "JOIN Category c on p.CategoryID = c.CategoryID "
            + "JOIN ProductPriceQuantity pp ON p.ProductID = pp.ProductID "
            + "JOIN Unit u ON pp.UnitID = u.UnitID "
            + "JOIN Stock s ON p.ProductID = s.Pid "
            + "WHERE pp.PackagingDetails = 1 "
            + "AND c.ParentCategoryID LIKE ? "
            + "AND c.Status = 1 "
            + "GROUP BY p.CountryOfProduction, p.TargetAudience, p.ProductID, p.ProductName, p.ImagePath, pp.SalePrice, u.UnitName "
            + "HAVING MIN(s.quantity) > 0;";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            // Set giá trị của categoryID
            ps.setString(1, parentCategoryID + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> productDetails = new HashMap<>();
                    productDetails.put("ProductID", rs.getString("ProductID"));
                    productDetails.put("productName", rs.getString("ProductName"));
                    productDetails.put("imagePath", rs.getString("ImagePath"));
                    productDetails.put("salePrice", rs.getFloat("SalePrice"));
                    productDetails.put("unitName", rs.getString("UnitName"));
                    productDetails.put("countryofproduction", rs.getString("CountryOfProduction"));
                    productDetails.put("audience", rs.getString("TargetAudience"));

                    productList.add(productDetails);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productList;
    }

    public List<String> getAllAudiences() {
        List<String> audienceList = new ArrayList<>();
        String sql = "SELECT TargetAudience FROM Audience";

        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                audienceList.add(rs.getString("TargetAudience"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }

        return audienceList;
    }

    public List<String> getAllCountries() {
        List<String> audienceList = new ArrayList<>();
        String sql = "SELECT CountryName FROM Country";

        try (PreparedStatement pstmt = connection.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                audienceList.add(rs.getString("CountryName"));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Xử lý ngoại lệ
        }

        return audienceList;
    }

}
