package dal;

import java.util.logging.Logger;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Category;
import dal.DBContext;

public class CategoryDAO2 extends DBContext {

    private static final Logger logger = Logger.getLogger(CategoryDAO.class.getName());

    public CategoryDAO2() {
    }

    // Retrieve all categories
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM Category";
        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Category(
                        rs.getString("CategoryID"),
                        rs.getString("icon"),
                        rs.getString("CategoryName"),
                        rs.getString("ParentCategoryID"),
                        rs.getString("description"),
                        rs.getInt("Status")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Insert new category
    public void insertCategory(Category category) {
        String sql = "INSERT INTO Category (CategoryID, icon, CategoryName, ParentCategoryID, Status, description) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, category.getCategoryID());
            ps.setString(2, category.getIcon());
            ps.setString(3, category.getCategoryName());
            ps.setString(4, category.getParentCategoryID());
            ps.setInt(5, category.getStatus());
            ps.setString(6, category.getDescription());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        setEmptyParentCategoryIDToNull();
    }

    // Update existing category
    public void updateCategory(Category category) {
        String sql = "UPDATE Category SET icon = ?, CategoryName = ?, ParentCategoryID = ?, Status = ?, description = ? WHERE CategoryID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, category.getIcon());
            ps.setString(2, category.getCategoryName());
            ps.setString(3, category.getParentCategoryID());
            ps.setInt(4, category.getStatus());
            ps.setString(5, category.getDescription());
            ps.setString(6, category.getCategoryID());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        setEmptyParentCategoryIDToNull();
    }

    // Lấy danh mục theo ID
    public Category getCategoryById(String id) {
        String sql = "SELECT * FROM Category WHERE CategoryID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                String categoryID = rs.getString("CategoryID");
                String icon = rs.getString("icon");
                String categoryName = rs.getString("CategoryName");
                String parentCategoryID = rs.getString("ParentCategoryID");
                int status = rs.getInt("Status");
                String description = rs.getString("description");
                return new Category(categoryID, icon, categoryName, parentCategoryID, description, status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Trả về null nếu không tìm thấy
    }

    public List<Category> getCategoriesByParentId(String parentId) {
        List<Category> categories = new ArrayList<>();
        String query = "SELECT * FROM Category WHERE parentCategoryID = ?"; // Update with your actual table name
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {

            preparedStatement.setString(1, parentId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                String categoryID = resultSet.getString("categoryID");
                String icon = resultSet.getString("icon");
                String categoryName = resultSet.getString("categoryName");
                String description = resultSet.getString("description");
                int status = resultSet.getInt("status");

                Category category = new Category(categoryID, icon, categoryName, parentId, description, status);
                categories.add(category);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle exceptions
        }
        return categories;
    }

    public String generateCategoryID(String parentCategoryID) {
        String newCategoryID = "";

        try (
                PreparedStatement stmt = connection.prepareStatement(
                        "SELECT TOP 1 CategoryID FROM Category WHERE ParentCategoryID = ? ORDER BY CategoryID DESC"
                )) {

                    stmt.setString(1, parentCategoryID);
                    ResultSet rs = stmt.executeQuery();

                    if (rs.next()) {
                        String lastCategoryID = rs.getString("CategoryID");

                        if (parentCategoryID == null) {
                            int currentNumber = Integer.parseInt(lastCategoryID.substring(1)) + 1;
                            newCategoryID = "R" + currentNumber;
                        } else if (parentCategoryID.length() == 2) {
                            char currentChar = lastCategoryID.charAt(2);
                            newCategoryID = parentCategoryID + (char) (currentChar + 1);
                        } else if (parentCategoryID.length() == 3) {
                            int currentNumber = Integer.parseInt(lastCategoryID.substring(3)) + 1;
                            newCategoryID = parentCategoryID + currentNumber;
                        }

                        logger.info("Generated new CategoryID: " + newCategoryID);

                    } else {
                        if (parentCategoryID == null) {
                            newCategoryID = "R1";
                        } else if (parentCategoryID.length() == 2) {
                            newCategoryID = parentCategoryID + "A";
                        } else if (parentCategoryID.length() == 3) {
                            newCategoryID = parentCategoryID + "1";
                        }

                        logger.info("No child categories found. Setting new CategoryID to: " + newCategoryID);
                    }

                } catch (SQLException e) {
                    logger.severe("SQL Exception occurred: " + e.getMessage());
                    e.printStackTrace();
                }

                return newCategoryID;
    }

    public void setEmptyParentCategoryIDToNull() {
        String sql = "UPDATE Category SET ParentCategoryID = NULL WHERE ParentCategoryID = ''";

        try (
                PreparedStatement stmt = connection.prepareStatement(sql)) {

            stmt.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public static void main(String[] args) {
        CategoryDAO2 categoryDAO = new CategoryDAO2();
        
        // Test với parentCategoryID khác nhau
        System.out.println("Generated ID for null parentCategoryID: " + categoryDAO.generateCategoryID(null));
        System.out.println("Generated ID for parentCategoryID 'R1': " + categoryDAO.generateCategoryID("R1"));
        System.out.println("Generated ID for parentCategoryID 'R1A': " + categoryDAO.generateCategoryID("R1A"));
        System.out.println("Generated ID for parentCategoryID 'R1A1': " + categoryDAO.generateCategoryID("R1A1"));
    }

}
