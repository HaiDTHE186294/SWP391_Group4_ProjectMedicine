package dal;

import model.Stock; // Ensure you have the Stock model class
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

public class stockDAO extends DBContext {

    public stockDAO() {
    }

    // Function to add stock to the database
    public boolean addStock(Stock stock) {
        String sql = "INSERT INTO Stock (Batch_no, Pid, Base_unit_ID, Quantity, Price_import, "
                + "Date_manufacture, Date_expired) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, stock.getBatchNo());
            ps.setString(2, stock.getProductId());
            ps.setString(3, stock.getBaseUnitId());
            ps.setInt(4, stock.getQuantity());
            ps.setFloat(5, stock.getPriceImport());
            ps.setDate(6, java.sql.Date.valueOf(stock.getDateManufacture())); // Assuming Date is in String format
            ps.setDate(7, java.sql.Date.valueOf(stock.getDateExpired())); // Assuming Date is in String format

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Function to retrieve all stock entries from the database
    public List<Stock> getAllStocks() {
        List<Stock> stocks = new ArrayList<>();
        String sql = "SELECT * FROM Stock"; // Adjust the SQL query if needed

        try (PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                // Retrieve all fields from the result set and create a new Stock object
                String batchNo = rs.getString("Batch_no");
                String productId = rs.getString("Pid");
                String baseUnitId = rs.getString("Base_unit_ID");
                int quantity = rs.getInt("Quantity");
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
    
}
