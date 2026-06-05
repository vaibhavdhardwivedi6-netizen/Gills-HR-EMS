package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Get database details from environment variables (for Render)
            // Default to local dev values if not found
            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USER");
            String dbPass = System.getenv("DB_PASS");
            
            if (dbUrl == null) dbUrl = "jdbc:mysql://localhost:3306/employee_db";
            if (dbUser == null) dbUser = "root";
            if (dbPass == null) dbPass = "2004";
            
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
