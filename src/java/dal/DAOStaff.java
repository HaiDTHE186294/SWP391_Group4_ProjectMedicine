/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Staff;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList; // Changed to ArrayList
import java.util.logging.Level;
import java.util.logging.Logger;

public class DAOStaff extends DBContext {
    
    public int insertStaff(Staff staff) {
        int n = 0;
        String sql = """
                     INSERT INTO [dbo].[staffs]
                                ([staff_id], [full_name], [phone], [email], [role_id], [status], [address], [image])     
                     VALUES (?, ?, ?, ?, ?, ?, ?, ?)""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, staff.getStaffId());
            pre.setString(2, staff.getFullName());
            pre.setString(3, staff.getPhone());
            pre.setString(4, staff.getEmail());
            pre.setInt(5, staff.getRoleId());
            pre.setInt(6, staff.getStatus());
            pre.setString(7, staff.getAddress());
            pre.setString(8, staff.getImage());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public int updateStaff(Staff staff) {
        int n = 0;
        String sql = """
                     UPDATE [dbo].[staffs]
                        SET [full_name] = ?,
                            [phone] = ?,
                            [email] = ?,
                            [role_id] = ?,
                            [status] = ?,
                            [address] = ?,
                            [image] = ?
                      WHERE [staff_id] = ?""";
        try {
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setString(1, staff.getFullName());
            pre.setString(2, staff.getPhone());
            pre.setString(3, staff.getEmail());
            pre.setInt(4, staff.getRoleId());
            pre.setInt(5, staff.getStatus());
            pre.setString(6, staff.getAddress());
            pre.setString(7, staff.getImage());
            pre.setInt(8, staff.getStaffId());
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }

    public ArrayList<Staff> getStaff(String sql) { // Changed to ArrayList
        ArrayList<Staff> staffList = new ArrayList<>();
        try {
            Statement state = connection.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int staffId = rs.getInt("staff_id"); // Use column names instead of indices for clarity
                String fullName = rs.getString("full_name");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                int roleId = rs.getInt("role_id");
                int status = rs.getInt("status");
                String address = rs.getString("address");
                String image = rs.getString("image");

                Staff staff = new Staff(staffId, fullName, email, roleId, status, phone, address, image);
                staffList.add(staff);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
        return staffList;
    }

    public void listAll() {
        String sql = "SELECT * FROM staffs";
        try {
            Statement state = connection.createStatement();
            ResultSet rs = state.executeQuery(sql);
            while (rs.next()) {
                int staffId = rs.getInt("staff_id");
                String fullName = rs.getString("full_name");
                String phone = rs.getString("phone");
                String email = rs.getString("email");
                int roleId = rs.getInt("role_id");
                int status = rs.getInt("status");
                String address = rs.getString("address");
                String image = rs.getString("image");

                Staff staff = new Staff(staffId, fullName, email, roleId, status, phone, address, image);
                System.out.println(staff);
            }
        } catch (SQLException ex) {
            Logger.getLogger(DAOStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public int removeStaff(int staffId) {
        int n = 0;
        try {
            String sql = """
                         DELETE FROM [dbo].[staffs]
                               WHERE staff_id = ?"""; // Use parameterized query
            PreparedStatement pre = connection.prepareStatement(sql);
            pre.setInt(1, staffId);
            n = pre.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(DAOStaff.class.getName()).log(Level.SEVERE, null, ex);
        }
        return n;
    }
}

