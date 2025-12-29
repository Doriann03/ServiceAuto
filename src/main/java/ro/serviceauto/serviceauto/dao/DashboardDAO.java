package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.LinkedHashMap;

public class DashboardDAO {

    // 1. Numara intrarile totale pentru cardurile de sus
    public int getCount(String tableName) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM " + tableName;
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return count;
    }

    // 2. Pentru Graficul Placinta: Cate programari sunt pe fiecare status?
    public Map<String, Integer> getProgramariPeStatus() {
        Map<String, Integer> stats = new HashMap<>();
        // Initializam cu 0 ca sa avem cheile
        stats.put("Programat", 0);
        stats.put("In lucru", 0);
        stats.put("Finalizat", 0);

        String sql = "SELECT status, COUNT(*) FROM programare GROUP BY status";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                stats.put(rs.getString(1), rs.getInt(2));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return stats;
    }

    // 3. Pentru Graficul Liniar: Programari pe ultimele 7 zile
    public Map<String, Integer> getProgramariUltimele7Zile() {
        Map<String, Integer> stats = new LinkedHashMap<>();

        String sql = "SELECT DATE_FORMAT(dataProg, '%d-%m') as zi, COUNT(*) " +
                "FROM programare " +
                "WHERE dataProg >= DATE_SUB(CURDATE(), INTERVAL 7 DAY) " +
                "GROUP BY zi ORDER BY dataProg ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                stats.put(rs.getString(1), rs.getInt(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return stats;
    }
}