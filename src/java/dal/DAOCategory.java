/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Statement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Category;

/**
 *
 * @author kan3v
 */
public class DAOCategory extends DBContext {

    public int removeCategory(String CategoryID) {
        int n = 0;
        try {
            String sql = """
                         UPDATE Category
                         SET Status = '0'
                         WHERE CategoryID = 
                         """ + CategoryID;

            Statement state = connection.createStatement();
            n = state.executeUpdate(sql);
        } catch (SQLException ex) {
            Logger.getLogger(DAOCategory.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public boolean insertCategory(Category category) {
        String sql = "INSERT INTO [dbo].[Category]\n"
                + "           ([CategoryID], [Icon], [CategoryName], [ParentCategoryID],[Status])"
                + "     VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, category.getCategoryID());
            pre.setString(2, category.getIcon());
            pre.setString(3, category.getCategoryName());
            pre.setString(4, category.getParentCategoryID());
            pre.setInt(4, 1);
            int rowsAffected = pre.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public boolean updateCategory(Category category) {
        String sql = "UPDATE [dbo].[Category]\n"
                + "   SET [CategoryName] = ?,\n"
                + "       [Icon] = ?,\n"
                + "       [ParentCategoryID] = ?,\n"
                + " WHERE [CategoryID] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, category.getCategoryName());
            pre.setString(2, category.getIcon());
            pre.setString(3, category.getParentCategoryID());
            pre.setString(4, category.getCategoryID());
            int update = pre.executeUpdate();
            return update > 0;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public ArrayList<Category> getCategory(String sql) {
        ArrayList<Category> list = new ArrayList<>();
        try {
            Statement state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                String cateid = rs.getString(1);
                String icon = rs.getString(2);
                String catename = rs.getString(3);
                String pcateid = rs.getString(4);
                int status = rs.getInt(5);
                Category category = new Category(cateid, icon, catename, pcateid,status);
                list.add(category);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // In lỗi ra màn hình
        }
        return list;
    }

    public ArrayList<Category> getAllCategories() {
        ArrayList<Category> categories = new ArrayList<>();
        String sql = "SELECT CategoryID, icon, CategoryName, ParentCategoryID ,Status FROM Category";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                String categoryID = rs.getString("CategoryID");
                String icon = rs.getString("icon");
                String categoryName = rs.getString("CategoryName");
                String parentCategoryID = rs.getString("ParentCategoryID");
                int status = rs.getInt("Status");
                // Tạo đối tượng Category và thêm vào danh sách
                categories.add(new Category(categoryID, icon, categoryName, parentCategoryID,status));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return categories;
    }

}
