/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Order;
import model.OrderDetail;
import model.Product;
import model.ProductPriceQuantity;
import model.Stock;
import model.Unit;
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
        String query = "  SELECT TOP 1 * FROM [Order]\n"
                + "                WHERE user_id = ?  AND [status] = 'Cart' \n"
                + "                ORDER BY order_date DESC";

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

//    public void createNewOrder(int userId) {
//        // Define the SQL query for inserting a new order
//        String insertOrderQuery = "INSERT INTO [Order] (order_date, status, order_total, user_id) "
//                + "VALUES (?, ?, ?, ?)";
//
//        try (PreparedStatement ps = connection.prepareStatement(insertOrderQuery)) {
//            // Set parameters for the query
//            ps.setTimestamp(1, new Timestamp(System.currentTimeMillis())); // current timestamp for order_date
//            ps.setString(2, "pending"); // status
//            ps.setDouble(3, 0.0); // initial order total
//            ps.setInt(4, userId); // user_id
//
//            // Execute the update query
//            int rowsAffected = ps.executeUpdate();
//
//            if (rowsAffected > 0) {
//                System.out.println("New order created successfully.");
//            } else {
//                System.out.println("Failed to create a new order.");
//            }
//        } catch (SQLException ex) {
//            ex.printStackTrace();
//        }
//    }
    public void createNewOrder(int userId, String status, double orderTotal, String phoneNumber, String address) {
        String sql = "INSERT INTO [dbo].[Order] ([order_date], [status], [order_total], [user_id], [phone_number_order], [address]) "
                + "VALUES (?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setDate(1, new java.sql.Date(System.currentTimeMillis()));
            st.setString(2, status);
            st.setDouble(3, orderTotal);
            st.setInt(4, userId);
            st.setString(5, phoneNumber);
            st.setString(6, address);

            int rowsInserted = st.executeUpdate();
            if (rowsInserted > 0) {
                System.out.println("A new order was created successfully!");
            }
        } catch (SQLException e) {
            System.out.println("Error while creating new order: " + e);
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

                CartDAO cartDao = new CartDAO();
                Map<String, Object> productData = cartDao.getProductById(productId);

                OrderDetail orderDetail = new OrderDetail(orderDetailId, null, productData, quantity, price); // Notice the 'null' placeholder for Order

                orderDetails.add(orderDetail);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return orderDetails;
    }

    public Order getOrderWhereStatus(int userId, String status) {
        String sql = "SELECT TOP 1 [order_id], [order_date], [status], [order_total], "
                + "[user_id], [phone_number_order], [address] "
                + "FROM [dbo].[Order] "
                + "WHERE user_id = ? AND [status] = ? "
                + "ORDER BY order_date DESC";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            st.setString(2, status);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                UserDAO udao = new UserDAO();
                User user = udao.getUserByUserId(userId);

                int orderId = rs.getInt("order_id");
                Date orderDate = rs.getDate("order_date"); // Có thể là null
                String orderStatus = rs.getString("status");
                Double orderTotal = rs.getObject("order_total") != null ? rs.getDouble("order_total") : null; // Có thể là null
                String phoneNumber = rs.getString("phone_number_order"); // Có thể là null
                String address = rs.getString("address"); // Có thể là null

                CartDAO cdao = new CartDAO();
                List<OrderDetail> cartDetail = cdao.getListCartDetailByOrderId(orderId);

                Order order = new Order(
                        orderId,
                        orderDate,
                        orderStatus,
                        orderTotal,
                        user,
                        cartDetail,
                        phoneNumber,
                        address
                );
                return order;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
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
                        //       Map<String, Object> productData = cartDao.getProductById(productId);

                        //        if(productData.getQuantityInStock() < (existingQuantity +quantity)){
                        //            return false;
                        //       }
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
                    try (PreparedStatement insertPs = connection.prepareStatement(insertOrderDetailQuery)) {
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

    public List<OrderDetail> getListCartDetailByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT \n"
                + "    od.order_detail_id, \n"
                + "    od.order_id, \n"
                + "    od.ProductID, \n"
                + "    od.quantity, \n"
                + "    od.UnitID, \n"
                + "    p.ProductName, \n"
                + "    p.Brand, \n"
                + "    p.ProductDescription, \n"
                + "    ppq.SalePrice, \n"
                + "    ppq.PackagingDetails, \n"
                + "    ppq.UnitStatus, \n"
                + "    s.Batch_no, \n"
                + "    od.price,\n"
                + "    s.Quantity AS StockQuantity, \n"
                + "    s.Date_expired\n"
                + "FROM \n"
                + "    [dbo].[OrderDetails] od\n"
                + "JOIN \n"
                + "    [dbo].[Product] p ON od.ProductID = p.ProductID\n"
                + "JOIN (\n"
                + "    SELECT \n"
                + "        ProductID, \n"
                + "        UnitID,\n"
                + "        SalePrice, \n"
                + "        PackagingDetails, \n"
                + "        UnitStatus\n"
                + "    FROM \n"
                + "        [dbo].[ProductPriceQuantity]\n"
                + ") ppq ON od.ProductID = ppq.ProductID AND od.UnitID = ppq.UnitID\n"
                + "JOIN (\n"
                + "    SELECT \n"
                + "        Pid, \n"
                + "        MIN(Batch_no) AS Batch_no, \n"
                + "        MIN(Quantity) AS Quantity, \n"
                + "        MIN(Date_expired) AS Date_expired\n"
                + "    FROM \n"
                + "        [dbo].[Stock]\n"
                + "    GROUP BY \n"
                + "        Pid\n"
                + ") s ON od.ProductID = s.Pid\n"
                + "WHERE \n"
                + "    od.order_id = ?;";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, orderId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ProductDAO pdao = new ProductDAO();
                Product product = pdao.getProductByID(rs.getString("ProductID"));
                List<ProductPriceQuantity> productPriceQuantities = pdao.getProductPriceQuantitiesByProductID(rs.getString("ProductID"));

                OrderDetail orderDetail = new OrderDetail(
                        rs.getInt("order_detail_id"),
                        rs.getInt("quantity"),
                        rs.getDouble("SalePrice"),
                        product,
                        productPriceQuantities,
                        rs.getInt("order_id"),
                        rs.getString("UnitID")
                );

                orderDetails.add(orderDetail);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }

        return orderDetails;
    }

    public double updateCartByOrderDetailId(String orderDetailId, String idOrder, String productId, int quantity, double price, String productUnit) {

        double updatedPrice = 0.0;
        String updateQuery = "UPDATE OrderDetails SET quantity = ?, price = ?, UnitID = ? WHERE order_detail_id = ? AND order_id = ? AND ProductID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(updateQuery)) {

            stmt.setInt(1, quantity);
            stmt.setDouble(2, price);
            stmt.setString(3, productUnit);
            stmt.setString(4, orderDetailId);
            stmt.setString(5, idOrder);
            stmt.setString(6, productId);

            int rowsAffected = stmt.executeUpdate();

            if (rowsAffected > 0) {
                updatedPrice = quantity * price;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return updatedPrice;
    }

    public boolean removeCartDetailById(String orderDetailId) {
        String sql = "DELETE FROM OrderDetails WHERE order_detail_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, orderDetailId);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

//    public boolean addCart(int orderId, String productId, double price) {
//        String sql = "INSERT INTO OrderDetails ( order_id, ProductID, quantity, price) VALUES ( ?, ?, ?, ?)";
//        try (
//                PreparedStatement ps = connection.prepareStatement(sql)) {
//
//            ps.setInt(1, orderId);
//            ps.setString(2, productId);
//            ps.setInt(3, 1); // Default quantity as 1; adjust as needed
//            ps.setDouble(4, price);
//
//            int rowsAffected = ps.executeUpdate();
//            return rowsAffected > 0;
//
//        } catch (SQLException e) {
//            e.printStackTrace(); // Replace with logging in production
//            return false;
//        }
//    }
    public boolean addCart(int orderId, String productId, double price, int quantity) {
    String checkSql = "SELECT quantity FROM OrderDetails WHERE order_id = ? AND ProductID = ?";
    String updateSql = "UPDATE OrderDetails SET quantity = quantity + ? WHERE order_id = ? AND ProductID = ?";
    String insertSql = "INSERT INTO OrderDetails (order_id, ProductID, quantity, price, UnitID) VALUES (?,?, ?, ?, ?)";
    String getUnitIdSql = "SELECT TOP 1 UnitID FROM ProductPriceQuantity WHERE ProductID = ? ORDER BY UnitID ASC";

    try (
            PreparedStatement checkPs = connection.prepareStatement(checkSql); 
            PreparedStatement updatePs = connection.prepareStatement(updateSql); 
            PreparedStatement insertPs = connection.prepareStatement(insertSql); 
            PreparedStatement getUnitIdPs = connection.prepareStatement(getUnitIdSql)) {

        // Kiểm tra xem sản phẩm đã có trong OrderDetails chưa
        checkPs.setInt(1, orderId);
        checkPs.setString(2, productId);
        ResultSet rs = checkPs.executeQuery();

        if (rs.next()) {
            // Nếu đã có, cập nhật số lượng bằng cách cộng thêm `quantity`
            updatePs.setInt(1, quantity);
            updatePs.setInt(2, orderId);
            updatePs.setString(3, productId);
            int rowsUpdated = updatePs.executeUpdate();
            return rowsUpdated > 0;
        } else {
            getUnitIdPs.setString(1, productId);
            ResultSet unitIdRs = getUnitIdPs.executeQuery();
            
            if (unitIdRs.next()) {
                String unitId = unitIdRs.getString("UnitID");

                // Nếu chưa có, chèn mới vào OrderDetails với số lượng `quantity`
                insertPs.setInt(1, orderId);
                insertPs.setString(2, productId);
                insertPs.setInt(3, quantity);
                insertPs.setDouble(4, price);
                insertPs.setString(5, unitId);
                int rowsInserted = insertPs.executeUpdate();
                return rowsInserted > 0;
            } else {
                // Return false if no UnitID is found
                return false;
            }
        }

    } catch (SQLException e) {
        e.printStackTrace();
        return false;
    }
}

    public boolean updateStatusByOrderId(String orderId, String status, String totalPrice, String phone, String address) {
        String sql = "UPDATE [Order] SET status = ?, order_date = GETDATE(), order_total = ?, phone_number_order = ?, address = ? WHERE order_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, status);
            ps.setDouble(2, Double.parseDouble(totalPrice));
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setString(5, orderId);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateQuantiyByListCartDetail(List<OrderDetail> listOrderDetail) {

        ProductDAO pdao = new ProductDAO();
        CartDAO cdao = new CartDAO();
        stockDAO sdao = new stockDAO();

        for (OrderDetail orderDetail : listOrderDetail) {
            String productId = orderDetail.getProduct().getProductID();

            Stock stock = sdao.getStockByProductId(productId);
            if (stock == null) {
                System.out.println("Không tìm thấy thông tin tồn kho cho sản phẩm ID: " + productId);
                return false;
            }

            float quantityStock = stock.getQuantity();
            String unitIdOrderDetail = orderDetail.getUnitId();
            List<ProductPriceQuantity> listProductPrice = pdao.getProductPriceQuantitiesByProductID(productId);
            int quantityOrderDetail = orderDetail.getQuantity();

            // Kiểm tra cập nhật tồn kho
            boolean isUpdated = cdao.updateQuantity(quantityStock, quantityOrderDetail, unitIdOrderDetail, listProductPrice, productId, stock);

            if (!isUpdated) {
                System.out.println("Không thể cập nhật tồn kho cho sản phẩm ID: " + productId + " do tồn kho không đủ.");
                return false;
            }
        }
        return true;
    }

    private boolean updateQuantity(float quantityStock, int quantityOrderDetail, String unitIdOrderDetail, List<ProductPriceQuantity> listProductPrice, String productId, Stock stock) {
        float x = 1; // 
        int maxPackagingDetails = 1;
        String maxUnitId = unitIdOrderDetail;

        int packagingDetail = 0;

        CartDAO cdao = new CartDAO();
        packagingDetail = cdao.getMaxPakingDetail(productId);

        System.out.println("packagingDetail" + packagingDetail);
        if (packagingDetail == 0) {
            System.out.println("Không tìm thấy đơn vị nhỏ nhất trong danh sách ProductPriceQuantity.");
            return false;
        }

        // sau đấy lấy được số lượng của unit có đơn vị nhỏ nhất 
        for (ProductPriceQuantity productPriceQuantity : listProductPrice) {
            if (productPriceQuantity.getUnitID().equals(unitIdOrderDetail)) {
                System.out.println("productPriceQuantity.getPackaging()" + productPriceQuantity.getPackaging());
                System.out.println("packagingDetail" + packagingDetail);
                x = (float) 1 / packagingDetail;
                break;
            }
        }

        System.out.println(x);
        System.out.println(packagingDetail);
        System.out.println("quantityOrderDetail" + quantityOrderDetail);

        // Tính số lượng cần trừ khỏi tồn kho
        float normalizedOrderQuantity = quantityOrderDetail * x;
        float updatedQuantityStock = quantityStock - normalizedOrderQuantity;
        System.out.println("updatedQuantityStock" + updatedQuantityStock);

        // Kiểm tra tồn kho có đủ hay không
        if (updatedQuantityStock >= 0) {
            System.out.println("Tồn kho sau khi trừ: " + updatedQuantityStock);
            stockDAO sdao = new stockDAO();
            boolean updateStock = sdao.updateQuantityStock(updatedQuantityStock, stock.getBatchNo(), stock.getProductId());
            if (updateStock) {
                System.out.println("sucess");
            } else {
                System.out.println("false");
            }

            boolean updateSold = sdao.updateSold(normalizedOrderQuantity, productId);
            return true;
        } else {
            System.out.println("Tồn kho không đủ để đáp ứng yêu cầu.");
            return false;
        }
    }

    private int getMaxPakingDetail(String productId) {
        int maxPackagingDetails = 0; // Giá trị ban đầu lớn để tìm đơn vị nhỏ nhất

        String sql = "SELECT UnitID, PackagingDetails FROM ProductPriceQuantity WHERE ProductID = ?";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, productId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                String unitId = rs.getString("UnitID");
                int packagingDetails = rs.getInt("PackagingDetails");

                // Tìm UnitID có PackagingDetails lớn nhất 
                if (maxPackagingDetails < packagingDetails) {
                    maxPackagingDetails = packagingDetails;
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (maxPackagingDetails == 0) {
            System.out.println("Không tìm thấy đơn vị nhỏ nhất cho sản phẩm ID: " + productId);
        } else {
            System.out.println("UnitID nhỏ nhất cho sản phẩm ID " + productId + " là: " + maxPackagingDetails);
        }

        return maxPackagingDetails;
    }

    public List<Order> getListCartByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT order_id, order_date, status, order_total, user_id, phone_number_order, address "
                + "FROM [Order] "
                + "WHERE user_id = ? AND status != 'Cart'";

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                Date orderDate = rs.getDate("order_date");
                String status = rs.getString("status");
                double orderTotal = rs.getDouble("order_total");
                String phoneNumber = rs.getString("phone_number_order");
                String address = rs.getString("address");

                UserDAO udao = new UserDAO();
                User user = udao.getUserByUserId(userId);

                Order order = new Order(orderId, orderDate, status, orderTotal, user, phoneNumber, address);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public static void main(String[] args) {
        CartDAO cdao = new CartDAO();
        List<OrderDetail> getListCartDetailByOrderId = cdao.getListCartDetailByOrderId(20);
        for (OrderDetail orderDetail : getListCartDetailByOrderId) {
            System.out.println(orderDetail.getPrice());
        }

    }

}
