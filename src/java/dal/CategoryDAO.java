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
    
    

}
