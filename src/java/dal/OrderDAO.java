/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Order;

/**
 *
 * @author M7510
 */
public class OrderDAO extends DBContext {

    public OrderDAO() {
    }

    public int addOrder(Order o) {
        String sql = "INSERT INTO [Order] (order_date, status, order_total, order_user_id) VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setObject(1, o.getOrder_date());
            ps.setInt(2, o.getStatus());
            ps.setFloat(3, o.getOrder_total());
            ps.setInt(4, o.getUser_id());

            ps.executeUpdate();
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated primary key of the newly-created order
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Order> getOrdersByUserIdWithPaginationAndStatus(int userId, int limit, int offset, String sortColumn, String sortOrder, int status) {
        List<Order> orders = new ArrayList<>();

        // Updated SQL query to include status filtering
        String sql = "SELECT * FROM [Order] WHERE order_user_id = ? AND (? = -1 OR status = ?) "
                + "ORDER BY " + sortColumn + " " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, status); // Pass the status for filtering
            ps.setInt(3, status); // Pass the status for filtering
            ps.setInt(4, offset);
            ps.setInt(5, limit);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrder_id(rs.getString("order_id"));
                    order.setOrder_date(rs.getDate("order_date"));
                    order.setStatus(rs.getInt("status"));
                    order.setOrder_total(rs.getFloat("order_total"));
                    order.setUser_id(rs.getInt("order_user_id"));
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getTotalOrderCountByUserIdAndStatus(int userId, int status) {
        String sql = "SELECT COUNT(*) FROM [Order] WHERE order_user_id = ? AND (? = -1 OR status = ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, status); // Pass the status for filtering
            ps.setInt(3, status); // Pass the status for filtering

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Order> getOrdersWithSearchAndSort(int limit, int offset, String sortColumn, String sortOrder, int status, String searchTerm, String fromDate, String toDate) {
        List<Order> orders = new ArrayList<>();
        
        String sql = "SELECT * FROM [Order] WHERE"
                + " (? = -1 OR status = ?) "
                + (searchTerm != null && !searchTerm.isEmpty() ? "AND (order_id LIKE ?) " : "")
                + (fromDate != null && !fromDate.isEmpty() ? "AND order_date >= ? " : "")
                + (toDate != null && !toDate.isEmpty() ? "AND order_date <= ? " : "")
                + "ORDER BY " + sortColumn + " " + sortOrder + " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
    
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, status);
            ps.setInt(paramIndex++, status);
    
            if (searchTerm != null && !searchTerm.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchTerm + "%");
            }
            
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
    
            ps.setInt(paramIndex++, offset);
            ps.setInt(paramIndex, limit);
    
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setOrder_id(rs.getString("order_id"));
                order.setOrder_date(rs.getDate("order_date"));
                order.setStatus(rs.getInt("status"));
                order.setOrder_total(rs.getFloat("order_total"));
                order.setUser_id(rs.getInt("order_user_id"));
                order.setSales_id(rs.getInt("sales_id"));
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public int getTotalOrderCountWithSearchAndStatus(int status, String searchTerm, String fromDate, String toDate) {
        String sql = "SELECT COUNT(*) FROM [Order] WHERE"
                + " (? = -1 OR status = ?) "
                + (searchTerm != null && !searchTerm.isEmpty() ? "AND (order_id LIKE ?) " : "")
                + (fromDate != null && !fromDate.isEmpty() ? "AND order_date >= ? " : "")
                + (toDate != null && !toDate.isEmpty() ? "AND order_date <= ? " : "");
    
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int paramIndex = 1;
            ps.setInt(paramIndex++, status);
            ps.setInt(paramIndex++, status);
    
            if (searchTerm != null && !searchTerm.isEmpty()) {
                ps.setString(paramIndex++, "%" + searchTerm + "%");
            }
            
            if (fromDate != null && !fromDate.isEmpty()) {
                ps.setString(paramIndex++, fromDate);
            }
            
            if (toDate != null && !toDate.isEmpty()) {
                ps.setString(paramIndex++, toDate);
            }
    
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }    

    public Order getOrderById(String orderId) {
        String sql = "SELECT * FROM [Order] WHERE order_id = ?";
        Order order = null; // Initialize the order object

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, orderId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setOrder_id(rs.getString("order_id"));
                    order.setOrder_date(rs.getDate("order_date"));
                    order.setStatus(rs.getInt("status"));
                    order.setOrder_total(rs.getFloat("order_total"));
                    order.setUser_id(rs.getInt("order_user_id"));
                    order.setSales_id(rs.getInt("sales_id"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return order; // Return the order object, or null if not found
    }
}
