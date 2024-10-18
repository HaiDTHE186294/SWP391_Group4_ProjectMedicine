package dal;

import model.Stock; // Ensure you have the Stock model class
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import model.*;

public class stockDAO extends DBContext {

    public stockDAO() {
    }

    public boolean addImport(Import importData) {
        String insertImportSQL = "INSERT INTO Import (O_id, NCC, Pid, Base_unit_ID, Batch_no, Date_manufacture, Date_expired, Price_import, Importer, Quantity) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        String checkStockSQL = "SELECT Quantity FROM Stock WHERE Pid = ? AND Batch_no = ?";
        String updateStockSQL = "UPDATE Stock SET Quantity = Quantity + ?, Price_import = ?, Date_manufacture = ?, Date_expired = ? "
                + "WHERE Pid = ? AND Batch_no = ?";
        String insertStockSQL = "INSERT INTO Stock (Batch_no, Pid, Base_unit_ID, Quantity, Price_import, Date_manufacture, Date_expired) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement importStmt = connection.prepareStatement(insertImportSQL); PreparedStatement checkStmt = connection.prepareStatement(checkStockSQL); PreparedStatement updateStmt = connection.prepareStatement(updateStockSQL); PreparedStatement insertStmt = connection.prepareStatement(insertStockSQL)) {

            // Thêm dữ liệu vào bảng Import
            importStmt.setString(1, importData.getOrderId());
            importStmt.setString(2, importData.getProvider());
            importStmt.setString(3, importData.getProductId());
            importStmt.setString(4, importData.getBaseUnitId());
            importStmt.setString(5, importData.getBatchNo());
            importStmt.setString(6, importData.getDateManufacture());
            importStmt.setString(7, importData.getDateExpired());
            importStmt.setDouble(8, importData.getPriceImport());
            importStmt.setInt(9, importData.getImporter());
            importStmt.setDouble(10, importData.getQuantity());

            // Thực hiện câu lệnh thêm vào bảng Import
            importStmt.executeUpdate();

            // Kiểm tra xem sản phẩm đã tồn tại trong kho chưa
            checkStmt.setString(1, importData.getProductId());
            checkStmt.setString(2, importData.getBatchNo());
            ResultSet rs = checkStmt.executeQuery();

            if (rs.next()) {
                double newprice = calculateFinalPrice(importData.getProductId(), importData.getBatchNo(), importData.getPriceImport(), importData.getQuantity());
                // Nếu đã tồn tại, cập nhật số lượng và thông tin khác
                updateStmt.setDouble(1, importData.getQuantity());
                updateStmt.setDouble(2, newprice);
                updateStmt.setString(3, importData.getDateManufacture());
                updateStmt.setString(4, importData.getDateExpired());
                updateStmt.setString(5, importData.getProductId());
                updateStmt.setString(6, importData.getBatchNo());
                updateStmt.executeUpdate();
            } else {
                // Nếu không tồn tại, thêm mới vào Stock
                insertStmt.setString(1, importData.getBatchNo());
                insertStmt.setString(2, importData.getProductId());
                insertStmt.setString(3, importData.getBaseUnitId());
                insertStmt.setDouble(4, importData.getQuantity());
                insertStmt.setDouble(5, importData.getPriceImport());
                insertStmt.setString(6, importData.getDateManufacture());
                insertStmt.setString(7, importData.getDateExpired());
                insertStmt.executeUpdate();
            }
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean addStock(Stock stock) {
        String sql = "INSERT INTO Stock (Batch_no, Pid, Base_unit_ID, Quantity, Price_import, Date_manufacture, Date_expired) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, stock.getBatchNo());
            ps.setString(2, stock.getProductId());
            ps.setString(3, stock.getBaseUnitId());
            ps.setFloat(4, stock.getQuantity());
            ps.setFloat(5, stock.getPriceImport());
            ps.setString(6, stock.getDateManufacture());
            ps.setString(7, stock.getDateExpired());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Function to add stock to the database
    // Function to retrieve all stock entries from the database
    public List<Stock> getAllStocks() {
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock"; // Adjust the SQL query if needed

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // Retrieve all fields from the result set and create a new Stock object
                String batchNo = rs.getString("Batch_no");
                String productId = rs.getString("Pid");
                String baseUnitId = rs.getString("Base_unit_ID");
                float quantity = rs.getInt("Quantity");
                float priceImport = rs.getFloat("Price_import");
                String dateManufacture = rs.getString("Date_manufacture"); // Adjust type if needed
                String dateExpired = rs.getString("Date_expired"); // Adjust type if needed

                // Initialize the Stock object and add it to the list
                Stock stock = new Stock();
                stock.setBatchNo(batchNo);
                stock.setProductId(productId);
                stock.setBaseUnitId(baseUnitId);
                stock.setQuantity(quantity);
                stock.setPriceImport(priceImport);
                stock.setDateManufacture(dateManufacture);
                stock.setDateExpired(dateExpired);

                stocks.add(stock);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stocks;
    }

    public String generateOrderId(String productId) {
        String orderId = productId + "_1"; // Mặc định là 1
        String query = "SELECT MAX(CAST(SUBSTRING(O_id, LEN(?) + 2, LEN(O_id)) AS INT)) AS MaxOrderNumber "
                + "FROM Import WHERE O_id LIKE ?";
        try (
                PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setString(1, productId);
            ps.setString(2, productId + "_%");
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int maxOrderNumber = rs.getInt("MaxOrderNumber");
                orderId = productId + "_" + (maxOrderNumber + 1); // Tăng số thứ tự lên 1
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public List<Stock> getAllStocksByPid(String pid) {
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock WHERE Pid = ?"; // Ensure SQL query is correct

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Set the Pid parameter in the PreparedStatement
            ps.setString(1, pid);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Retrieve all fields from the result set and create a new Stock object
                    String batchNo = rs.getString("Batch_no");
                    String productId = rs.getString("Pid");
                    String baseUnitId = rs.getString("Base_unit_ID");
                    int quantity = rs.getInt("Quantity");
                    float priceImport = rs.getFloat("Price_import");
                    String dateManufacture = rs.getString("Date_manufacture"); // Assuming nvarchar
                    String dateExpired = rs.getString("Date_expired"); // Assuming nvarchar

                    // Initialize the Stock object and add it to the list
                    Stock stock = new Stock();
                    stock.setBatchNo(batchNo);
                    stock.setProductId(productId);
                    stock.setBaseUnitId(baseUnitId);
                    stock.setQuantity(quantity);
                    stock.setPriceImport(priceImport);
                    stock.setDateManufacture(dateManufacture);
                    stock.setDateExpired(dateExpired);

                    stocks.add(stock);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return stocks;
    }

    public List<Stock> getAllStocksByPidAndBatch(String pid, String batchId) {
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock WHERE Pid = ? AND Batch_no = ?"; // Updated SQL query

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Set the Pid and BatchID parameters in the PreparedStatement
            ps.setString(1, pid);
            ps.setString(2, batchId); // Set the BatchID parameter

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Retrieve all fields from the result set and create a new Stock object
                    String batchNo = rs.getString("Batch_no");
                    String productId = rs.getString("Pid");
                    String baseUnitId = rs.getString("Base_unit_ID");
                    float quantity = rs.getFloat("Quantity");
                    float priceImport = rs.getFloat("Price_import");
                    String dateManufacture = rs.getString("Date_manufacture"); // Assuming nvarchar
                    String dateExpired = rs.getString("Date_expired"); // Assuming nvarchar

                    // Initialize the Stock object and add it to the list
                    Stock stock = new Stock();
                    stock.setBatchNo(batchNo);
                    stock.setProductId(productId);
                    stock.setBaseUnitId(baseUnitId);
                    stock.setQuantity(quantity);
                    stock.setPriceImport(priceImport);
                    stock.setDateManufacture(dateManufacture);
                    stock.setDateExpired(dateExpired);

                    stocks.add(stock);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return stocks;
        }

        return stocks;
    }

    public Stock getStockByPidAndBatch(String pid, String batchId) {
        Stock stock = new Stock();
        String sql = "SELECT * FROM Stock WHERE Pid = ? AND Batch_no = ?"; // Updated SQL query

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Set the Pid and BatchID parameters in the PreparedStatement
            ps.setString(1, pid);
            ps.setString(2, batchId); // Set the BatchID parameter

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    // Retrieve all fields from the result set and create a new Stock object
                    String batchNo = rs.getString("Batch_no");
                    String productId = rs.getString("Pid");
                    String baseUnitId = rs.getString("Base_unit_ID");
                    float quantity = rs.getFloat("Quantity");
                    float priceImport = rs.getFloat("Price_import");
                    String dateManufacture = rs.getString("Date_manufacture"); // Assuming nvarchar
                    String dateExpired = rs.getString("Date_expired"); // Assuming nvarchar

                    // Initialize the Stock object and add it to the list
                    stock.setBatchNo(batchNo);
                    stock.setProductId(productId);
                    stock.setBaseUnitId(baseUnitId);
                    stock.setQuantity(quantity);
                    stock.setPriceImport(priceImport);
                    stock.setDateManufacture(dateManufacture);
                    stock.setDateExpired(dateExpired);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

        return stock;
    }

    public boolean importProduct(Import importData) {
        String sql = "INSERT INTO [dbo].[Import] "
                + "([O_id], [NCC], [Pid], [Base_unit_ID], [Batch_no], [Date_manufacture], "
                + "[Date_expired], [Price_import], [Importer], [quantity]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = connection; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, importData.getOrderId());
            ps.setString(2, importData.getProvider());
            ps.setString(3, importData.getProductId());
            ps.setString(4, importData.getBaseUnitId());
            ps.setString(5, importData.getBatchNo());
            ps.setString(6, importData.getDateManufacture());
            ps.setString(7, importData.getDateExpired());
            ps.setFloat(8, importData.getPriceImport());
            ps.setInt(9, importData.getImporter());
            ps.setFloat(10, importData.getQuantity());

            ps.executeUpdate();
            return true;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateStock(Stock stock) {
        String sql = "UPDATE Stock SET Quantity = ?, Price_import = ? WHERE Batch_no = ? AND Pid = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setFloat(1, stock.getQuantity());
            ps.setFloat(2, stock.getPriceImport());
            ps.setString(3, stock.getBatchNo());
            ps.setString(4, stock.getProductId());

            ps.executeUpdate();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public double calculateFinalPrice(String pid, String batchNo, double newPrice, double newQuantity) {
        String sql = "SELECT Price_import, Quantity FROM Stock WHERE Pid = ? AND Batch_no = ?";
        double finalPrice = 0;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            // Set parameters for Pid and Batch_no
            ps.setString(1, pid);
            ps.setString(2, batchNo);

            // Execute the query
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    // Retrieve the existing stock details
                    double oldPrice = rs.getDouble("Price_import");
                    double oldQuantity = rs.getDouble("Quantity");

                    // Calculate the final price using the weighted average formula
                    finalPrice = (oldPrice * oldQuantity + newPrice * newQuantity) / (oldQuantity + newQuantity);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return finalPrice;
    }

    public List<Import> getAllImport() {
        String selectAllImportsSQL = "SELECT O_id, NCC, Pid, Base_unit_ID, Batch_no, Date_manufacture, Date_expired, Price_import, Importer, Quantity, Date_import FROM Import";
        List<Import> importList = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(selectAllImportsSQL); ResultSet rs = stmt.executeQuery()) {

            // Loop through the result set and add each import record to the list
            while (rs.next()) {
                Import importData = new Import();
                importData.setOrderId(rs.getString("O_id"));
                importData.setProvider(rs.getString("NCC"));
                importData.setProductId(rs.getString("Pid"));
                importData.setBaseUnitId(rs.getString("Base_unit_ID"));
                importData.setBatchNo(rs.getString("Batch_no"));
                importData.setDateManufacture(rs.getString("Date_manufacture"));
                importData.setDateExpired(rs.getString("Date_expired"));
                importData.setPriceImport(rs.getFloat("Price_import"));
                importData.setImporter(rs.getInt("Importer"));
                importData.setQuantity(rs.getFloat("Quantity"));
                importData.setDateImport(rs.getString("Date_import"));

                // Add the import record to the list
                importList.add(importData);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return importList;
    }

    public String getManufacturerByProductAndBatch(String productId, String batchNo) {
        String query = "SELECT TOP 1 NCC " // NCC là trường đại diện cho nhà cung cấp
                + "FROM Import "
                + "WHERE Pid = ? AND Batch_no = ? "
                + "ORDER BY date_import ASC ";  // Lấy bản ghi có thời gian sản xuất sớm nhất

        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            // Set giá trị cho prepared statement
            stmt.setString(1, productId);
            stmt.setString(2, batchNo);

            // Thực hiện truy vấn và lấy kết quả
            ResultSet rs = stmt.executeQuery();

            // Nếu có kết quả, trả về nhà sản xuất
            if (rs.next()) {
                return rs.getString("NCC");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        // Nếu không tìm thấy kết quả, trả về null hoặc giá trị mặc định
        return "NCC";
    }

    public Map<String, Object> getGroupedStock() {
        Map<String, Object> groupedStock = new HashMap<>();

        // Truy vấn kết hợp bảng Stock với bảng Product để lấy thông tin ProductName
        String query = "SELECT s.*, p.ProductName FROM Stock s "
                + "JOIN Product p ON s.Pid = p.ProductID";
        try (
                PreparedStatement stmt = connection.prepareStatement(query); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                String productId = rs.getString("Pid");
                String productName = rs.getString("ProductName");

                // Tạo đối tượng Stock từ dữ liệu truy vấn
                Stock stock = new Stock();
                stock.setBatchNo(rs.getString("Batch_no"));
                stock.setProductId(productId);
                stock.setBaseUnitId(rs.getString("Base_unit_ID"));
                stock.setQuantity(rs.getFloat("Quantity"));
                stock.setPriceImport(rs.getFloat("Price_import"));
                stock.setDateManufacture(rs.getString("Date_manufacture"));
                stock.setDateExpired(rs.getString("Date_expired"));

                // Kiểm tra và nhóm sản phẩm theo ProductID
                groupedStock.computeIfAbsent(productId, k -> new HashMap<>());
                Map<String, Object> productGroup = (Map<String, Object>) groupedStock.get(productId);

                // Đảm bảo có productName
                productGroup.putIfAbsent("productName", productName);

                // Nhóm tất cả các sản phẩm có cùng ProductID vào một danh sách
                List<Stock> stockList = (List<Stock>) productGroup.computeIfAbsent("stocks", k -> new ArrayList<>());
                stockList.add(stock);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return groupedStock;
    }

    public List<Import> getAllImportByPid(String Pid) {
        // Modified SQL query to filter imports by Product ID (Pid)
        String selectImportsByPidSQL = "SELECT O_id, NCC, Pid, Base_unit_ID, Batch_no, Date_manufacture, Date_expired, Price_import, Importer, Quantity, Date_import FROM Import WHERE Pid = ?";
        List<Import> importList = new ArrayList<>();

        try (PreparedStatement stmt = connection.prepareStatement(selectImportsByPidSQL)) {
            // Set the Product ID (Pid) parameter in the query
            stmt.setString(1, Pid);

            // Execute the query and retrieve the result set
            try (ResultSet rs = stmt.executeQuery()) {
                // Loop through the result set and add each import record to the list
                while (rs.next()) {
                    Import importData = new Import();
                    importData.setOrderId(rs.getString("O_id"));
                    importData.setProvider(rs.getString("NCC"));
                    importData.setProductId(rs.getString("Pid"));
                    importData.setBaseUnitId(rs.getString("Base_unit_ID"));
                    importData.setBatchNo(rs.getString("Batch_no"));
                    importData.setDateManufacture(rs.getString("Date_manufacture"));
                    importData.setDateExpired(rs.getString("Date_expired"));
                    importData.setPriceImport(rs.getFloat("Price_import"));
                    importData.setImporter(rs.getInt("Importer"));
                    importData.setQuantity(rs.getFloat("Quantity"));
                    importData.setDateImport(rs.getString("Date_import"));

                    // Add the import record to the list
                    importList.add(importData);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return importList;
    }

}
