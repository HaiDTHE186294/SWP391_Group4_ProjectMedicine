package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Category;

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

}
