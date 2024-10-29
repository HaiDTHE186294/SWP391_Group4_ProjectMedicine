/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.User;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;
import util.PasswordUtil;

/**
 *
 * @author trant
 */
public class UserDAO extends DBContext {

    public User check(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String storedHashedPassword = rs.getString("password"); // Lấy mật khẩu đã mã hóa từ DB
                // Kiểm tra mật khẩu bằng BCrypt
                if (BCrypt.checkpw(password, storedHashedPassword)) {
                    User u = new User(rs.getInt("user_id"), rs.getString("full_name"), rs.getString("username"),
                            storedHashedPassword, rs.getString("email"), rs.getInt("role_id"), rs.getInt("status"),
                            rs.getString("phone"), rs.getString("address"), rs.getString("image"));
                    return u;
                }
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void createUser(String fullname, String username, String password, String email, String phone, String address, String image) {

        String hashedPassword = PasswordUtil.hashPasswordBCrypt(password);
        String sql = "INSERT INTO Users (full_name, username, password, email, role_id, status, phone, address, image) VALUES (?, ?, ?, ?, 2, 1, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, fullname);
            st.setString(2, username);
            st.setString(3, hashedPassword);
            st.setString(4, email);
            st.setString(5, phone);
            st.setString(6, address);
            st.setString(7, image);

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void createStaff(String fullname, String username, String password, String email, String phone, String address, String image) {

        String hashedPassword = PasswordUtil.hashPasswordBCrypt(password);
        String sql = "INSERT INTO Users (full_name, username, password, email, role_id, status, phone, address, image) VALUES (?, ?, ?, ?, 3, 1, ?, ?, ?)";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, fullname);
            st.setString(2, username);
            st.setString(3, hashedPassword);
            st.setString(4, email);
            st.setString(5, phone);
            st.setString(6, address);
            st.setString(7, image);

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean checkUserExists(String username, String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ? OR email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean checkStaffExists(String username, String email, String phone) {
        String sql = "SELECT COUNT(*) FROM Users WHERE username = ? OR email = ? OR phone = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, email);
            ps.setString(3, phone);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public String checkEmailExist(String email) {
        try {
            String sql = "SELECT * FROM Users WHERE email = ?";
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return email;
            }
        } catch (SQLException e) {
        }
        return null;
    }

    public String getUserNameByEmail(String email) {
        String sql = "SELECT Top 1 username FROM [dbo].[Users] WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            //set ?
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String name = rs.getString(1);
                return name;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public User getUserByUserName(String userName) {
        String sql = "SELECT * FROM [dbo].[Users] where username=? and [status] = 1";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            //set ?
            st.setString(1, userName);
            ResultSet rs = st.executeQuery();
            //1
            if (rs.next()) {
                User u = new User(rs.getInt("user_id"), rs.getString("full_name"), rs.getString("username"),
                        rs.getString("password"), rs.getString("email"), rs.getInt("role_id"), rs.getInt("status"), rs.getString("phone"), rs.getString("address"), rs.getString("image"));
                return u;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public void updatePassByUserName(String password, String username) {
        String sql = "update Users set password = ? where username= ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, password);
            st.setString(2, username);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean updateUser(User user) {
        String sql = "UPDATE users SET full_name = ?, email = ?,phone = ?, address = ?,image=? WHERE user_id = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            {
                ps.setString(1, user.getFullName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPhone());
                ps.setString(4, user.getAddress());
                ps.setString(5, user.getImage());
                ps.setInt(6, user.getUserId());

                int rowsUpdated = ps.executeUpdate();

                return rowsUpdated > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean changePassword(String username, String hashedPassword) {
        String sql = "UPDATE users SET password = ? WHERE username = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, hashedPassword); // Mật khẩu đã mã hóa
            ps.setString(2, username);

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByEmail(String email) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(rs.getInt("user_id"), rs.getString("full_name"), rs.getString("username"), rs.getString("password"), rs.getString("email"), rs.getInt("role_id"), rs.getInt("status"), rs.getString("phone"), rs.getString("address"), rs.getString("image"));
                //return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    public List<User> getAllUsersWithRoleId(int roleId) {
        List<User> userList = new ArrayList<>();
        String sql = "SELECT * FROM users WHERE role_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User user = new User(
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("email"),
                        rs.getInt("role_id"),
                        rs.getInt("status"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("image")
                );
                userList.add(user);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return userList;
    }

    public void deleteUserById(String user_id) {
        String sql = "DELETE FROM Users WHERE user_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, user_id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<User> getTop5Staff() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT TOP 5 * FROM Users WHERE role_id = 3 ORDER BY user_id DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setImage(rs.getString("image"));
                user.setRoleId(rs.getInt("role_id"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
 
    
    public User getUserByID(int id) {
        User user = null;
        String sql = "SELECT TOP 1 * FROM users WHERE user_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(rs.getInt("user_id"), rs.getString("full_name"), rs.getString("username"), rs.getString("password"), rs.getString("email"), rs.getInt("role_id"), rs.getInt("status"), rs.getString("phone"), rs.getString("address"), rs.getString("image"));
                //return u;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }
}
