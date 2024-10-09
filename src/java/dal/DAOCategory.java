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
import java.util.List;
import model.Category;

/**
 *
 * @author kan3v
 */
public class DAOCategory extends DBContext {

    public void removeCategory(int CategoryID) {
        String sql = "DELETE FROM [dbo].[Category] WHERE [CategoryID] = ?";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, CategoryID);
            pre.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public boolean insertCategory(Category category) {
        String sql = "INSERT INTO [dbo].[Category]\n"
                + "           ([CategoryID], [Icon], [CategoryName], [ParentCategoryID])"
                + "     VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, category.getCategoryID());
            pre.setString(2, category.getIcon());
            pre.setString(3, category.getCategoryName());
            pre.setString(4, category.getParentCategoryID());
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

    public List<Category> getCategory(String sql) {
        List<Category> list = new ArrayList<>();
        try {
            Statement state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                String cateid = rs.getString(1);
                String icon = rs.getString(2);
                String catename = rs.getString(3);
                String pcateid = rs.getString(4);
                Category category = new Category(cateid, icon, catename, pcateid);
                list.add(category);
            }
        } catch (SQLException ex) {
            ex.printStackTrace(); // In lỗi ra màn hình
        }
        return list;
    }
    
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

    public void listAll() {
        String sql = "select * from Category";
        try {
            Statement state = connection.createStatement();
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                String categoryid = rs.getString(1);
                String icon = rs.getString(2);
                String categoryname = rs.getString(3);
                String pcategoryid = rs.getString(4);
                Category category = new Category(categoryid, icon, categoryname, pcategoryid);
                System.out.println(category);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
}
