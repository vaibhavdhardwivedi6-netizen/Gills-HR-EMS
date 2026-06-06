package db;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
           
            String dbUrl = System.getenv("DB_URL");
            String dbUser = System.getenv("DB_USERNAME");
            String dbPass =System.getenv("DB_PASSWORD");
            
            
            conn = DriverManager.getConnection(dbUrl, dbUser, dbPass);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }
}
