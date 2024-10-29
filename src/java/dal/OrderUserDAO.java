/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.OrderUser;
/**
 *
 * @author M7510
 */
public class OrderUserDAO extends DBContext {

    public OrderUserDAO() {
    }
    
    public boolean userExists(String email) throws SQLException {
        String query = "SELECT 1 FROM OrderUser WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        }
    }

    public int createUser(OrderUser user) throws SQLException {
        String query = "INSERT INTO OrderUser (fullname, email, phone, address) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, user.getFullname());
            stmt.setString(2, user.getEmail());
            stmt.setString(3, user.getPhone());
            stmt.setString(4, user.getAddress());
            stmt.executeUpdate();

            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                return rs.getInt(1); // Return generated order_user_id
            } else {
                throw new SQLException("Failed to retrieve ID for the new user.");
            }
        }
    }

    public OrderUser getUserByEmail(String email) throws SQLException {
        String query = "SELECT * FROM OrderUser WHERE email = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new OrderUser(
                        rs.getInt("order_user_id"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address")
                );
            }
            return null; // User not found
        }
    }
    
    public OrderUser getUserById(int id) throws SQLException {
        String query = "SELECT * FROM OrderUser WHERE order_user_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return new OrderUser(
                        rs.getInt("order_user_id"),
                        rs.getString("fullname"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address")
                );
            }
            return null; // User not found
        }
    }
}
