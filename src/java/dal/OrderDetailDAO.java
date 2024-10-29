/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.OrderDetail;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author M7510
 */
public class OrderDetailDAO extends DBContext {
    public OrderDetailDAO(){}
    
    public int addOrderDetail(OrderDetail orderDetail) {
        String sql = "INSERT INTO OrderDetails (order_id, quantity, price, ProductID, UnitID) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, orderDetail.getOrder_id());
            ps.setInt(2, orderDetail.getQuantity());
            ps.setFloat(3, orderDetail.getPrice());
            ps.setString(4, orderDetail.getProductID());
            ps.setString(5, orderDetail.getUnitID());

            ps.executeUpdate();

            // Retrieve the generated key
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated primary key of the newly-created order detail
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // Return -1 if there was an error or no key was generated
    }
    
    public List<OrderDetail> getOrderDetailsByOrderId(String orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM OrderDetails WHERE order_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, orderId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    OrderDetail orderDetail = new OrderDetail();
                    orderDetail.setOrder_detail_id(rs.getInt("order_detail_id"));
                    orderDetail.setOrder_id(rs.getInt("order_id"));
                    orderDetail.setQuantity(rs.getInt("quantity"));
                    orderDetail.setPrice(rs.getFloat("price"));
                    orderDetail.setProductID(rs.getString("ProductID"));
                    orderDetail.setUnitID(rs.getString("UnitID"));

                    orderDetails.add(orderDetail);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orderDetails;
    }
}
