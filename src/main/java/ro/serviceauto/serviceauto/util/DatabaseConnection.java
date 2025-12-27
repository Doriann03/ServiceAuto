package ro.serviceauto.serviceauto.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Datele preluate din fisierul tau db.php [cite: 4243-4246]
    private static final String URL = "jdbc:mysql://localhost:3306/dn198"; // Verifică numele bazei
    private static final String USER = "root"; // Pune userul tau de MySQL (local e de obicei root)
    private static final String PASSWORD = ""; // Pune parola ta de MySQL

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }
}