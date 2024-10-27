/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.Unit;
import java.sql.PreparedStatement;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
/**
 *
 * @author M7510
 */
public class UnitDAO extends DBContext{
    public Unit getById(String UnitID){
    String sql = "SELECT * FROM Unit WHERE UnitID = ?";
        Unit unit = null; // Initialize the unit object

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, UnitID); // Set the parameter for the prepared statement

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    unit = new Unit();
                    unit.setUnitID(rs.getString(1));
                    unit.setUnitName(rs.getString(2));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return unit; // Return the unit object, or null if not found
    }
}
