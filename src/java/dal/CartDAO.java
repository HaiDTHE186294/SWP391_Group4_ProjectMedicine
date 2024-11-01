/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Timestamp;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Order;
import model.OrderDetail;
import model.User;

/**
 *
 * @author trant
 */
public class CartDAO extends DBContext {

    public Map<String, Object> getProductById(String productId) {
        Map<String, Object> productDetails = new HashMap<>();
        String sql = "SELECT p.ProductID, p.ProductName, p.ImagePath, pp.SalePrice, u.UnitName "
                + "FROM Product p "
                + "JOIN ProductPriceQuantity pp ON p.ProductID = pp.ProductID "
                + "JOIN Unit u ON pp.UnitID = u.UnitID "
                + "WHERE pp.UnitStatus = 1 AND p.ProductID = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {

            pstmt.setString(1, productId);  // Use setString since productId is now a String
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                productDetails.put("ProductID", rs.getString("ProductID"));
                productDetails.put("ProductName", rs.getString("ProductName"));
                productDetails.put("ImagePath", rs.getString("ImagePath"));
                productDetails.put("SalePrice", rs.getDouble("SalePrice"));
                productDetails.put("UnitName", rs.getString("UnitName"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return productDetails;
    }

    public Order getOrderNew(int userId) {
        Order order = null;
        String query = "SELECT TOP 1 * "
                + "FROM Order "
                + "WHERE user_id = ? AND [status] = 'pending' "
                + "ORDER BY order_date DESC";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int orderId = rs.getInt("order_id");

                UserDAO userDao = new UserDAO();
                User user = userDao.getUserByUserId(userId);

                java.sql.Date orderDate = rs.getDate("order_date");
                double orderTotal = rs.getDouble("order_total");
                String status = rs.getString("status");

                List<OrderDetail> listOrderDetail = getListOrderDetailByOrderId(orderId);

                order = new Order(orderId, orderDate, status, orderTotal, user, listOrderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return order;
    }

    public void createNewOrder(int userId) {
        // Define the SQL query for inserting a new order
        String insertOrderQuery = "INSERT INTO [Order] (order_date, status, order_total, user_id) "
                + "VALUES (?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(insertOrderQuery)) {
            // Set parameters for the query
            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // current timestamp for order_date
            ps.setString(2, "pending"); // status
            ps.setDouble(3, 0.0); // initial order total
            ps.setInt(4, userId); // user_id

            // Execute the update query
            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("New order created successfully.");
            } else {
                System.out.println("Failed to create a new order.");
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
    
    public List<OrderDetail> getListOrderDetailByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String query = "SELECT * FROM OrderDetails WHERE order_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, orderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int orderDetailId = rs.getInt("order_detail_id");
                String productId = rs.getString("ProductID");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");
                String address = rs.getString("address");

                CartDAO cartDao = new CartDAO();
                Map<String, Object> productData = cartDao.getProductById(productId);

                OrderDetail orderDetail = new OrderDetail(orderDetailId, null, productData, quantity, price, address); // Notice the 'null' placeholder for Order

                orderDetails.add(orderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orderDetails;
    }
    
    
    public boolean addOrUpdateOrderDetail(int orderId, int bookId, int quantity, double price) {
        String checkOrderDetailQuery = "SELECT quantity FROM OrderDetails WHERE order_id = ? AND ProductID = ?";
        String updateOrderDetailQuery = "UPDATE OrderDetails SET quantity = ?, price = ? WHERE order_id = ? AND book_id = ?";
        String insertOrderDetailQuery = "INSERT INTO OrderDetails (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";

        try {
            // Check if the order detail exists
            try (PreparedStatement checkPs = connection.prepareStatement(checkOrderDetailQuery)) {
                checkPs.setInt(1, orderId);
                checkPs.setInt(2, bookId);
                ResultSet rs = checkPs.executeQuery();

                if (rs.next()) {
                    // If it exists, update the quantity and price
                    int existingQuantity = rs.getInt("quantity");
                    try (PreparedStatement updatePs = connection.prepareStatement(updateOrderDetailQuery)) {
                        updatePs.setInt(1, existingQuantity + quantity); // Add to the existing quantity
                        updatePs.setDouble(2, price * (existingQuantity + quantity)); // Update the price for the new quantity
                        updatePs.setInt(3, orderId);
                        updatePs.setInt(4, bookId);
                        // tính quá giới hạn trong kho 
                        CartDAO cartDao = new CartDAO();
                        Map<String, Object> productData = cartDao.getProductById(productId);
                        
                        if(productData.getQuantityInStock() < (existingQuantity +quantity)){
                            return false;
                        }
                        int rowsUpdated = updatePs.executeUpdate();
                        if (rowsUpdated > 0) {
                            System.out.println("Order detail updated successfully.");
                            return true;
                        } else {
                            System.out.println("Failed to update order detail.");
                        }
                    }
                } else {
                    // If it doesn't exist, insert a new order detail
                    try (PreparedStatement insertPs = conn.prepareStatement(insertOrderDetailQuery)) {
                        insertPs.setInt(1, orderId);
                        insertPs.setInt(2, bookId);
                        insertPs.setInt(3, quantity);
                        insertPs.setDouble(4, price * quantity); // Set price based on quantity

                        int rowsInserted = insertPs.executeUpdate();
                        if (rowsInserted > 0) {
                            System.out.println("Order detail added successfully.");
                            return true;
                        } else {
                            System.out.println("Failed to add order detail.");
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }
}
