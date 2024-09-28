
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dal;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {
    protected Connection connection;
    public DBContext()
    {
        try {


            String user = "sa";

            String pass = "123456";

            String url = "jdbc:sqlserver://localhost\\MSSQLSERVER:1433;databaseName=SWP";


            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, user, pass);
        } catch (ClassNotFoundException | SQLException ex) {
           ex.printStackTrace();
            System.out.println(ex);
        }
    }
     public static void main(String[] args) {
        try {
            DBContext dbContext = new DBContext();
            
            if (dbContext.connection != null) {
                System.out.println("Connected to the database successfully!");
            } else {
                System.out.println("Connection failed.");
            }

            dbContext.connection.close();
            System.out.println("Connection closed.");
        } catch (SQLException ex) {
            System.out.println("Error closing connection: " + ex);
        }
    }
}

