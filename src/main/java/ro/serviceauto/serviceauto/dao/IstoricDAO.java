package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.model.IstoricAdmin;
import ro.serviceauto.serviceauto.model.IstoricClient;
import ro.serviceauto.serviceauto.util.DatabaseConnection;

import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class IstoricDAO {

    // Helper pentru data curenta (yyyy-MM-dd HH:mm:ss)
    private String getCurrentTimestamp() {
        return LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    }

    // ==========================================
    // 1. LOGGING ADMIN
    // ==========================================

    public void logAdminAction(int idAdmin, String numeAdmin, String actiune) {
        String sql = "INSERT INTO istoricadmin (IDAdmin, numeAdmin, actiune, dataOra) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idAdmin);
            stmt.setString(2, numeAdmin);
            stmt.setString(3, actiune);
            stmt.setString(4, getCurrentTimestamp());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            // Nu aruncam eroare aici ca sa nu blocam aplicatia daca pica logarea
        }
    }

    public List<IstoricAdmin> getAdminLogs() {
        List<IstoricAdmin> list = new ArrayList<>();
        // Le luam pe cele mai recente primele (DESC)
        String sql = "SELECT * FROM istoricadmin ORDER BY dataOra DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                IstoricAdmin log = new IstoricAdmin();
                log.setId(rs.getInt("ID"));
                log.setIdAdmin(rs.getInt("IDAdmin"));
                log.setNumeAdmin(rs.getString("numeAdmin"));
                log.setActiune(rs.getString("actiune"));
                log.setDataOra(rs.getString("dataOra"));
                list.add(log);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // ==========================================
    // 2. LOGGING CLIENT
    // ==========================================

    public void logClientAction(int idc, String numeClient, String actiune) {
        String sql = "INSERT INTO istoricclient (IDC, numeClient, actiune, dataOra) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idc);
            stmt.setString(2, numeClient);
            stmt.setString(3, actiune);
            stmt.setString(4, getCurrentTimestamp());

            stmt.executeUpdate();
        } catch (SQLException e) { e.printStackTrace(); }
    }

    public List<IstoricClient> getClientLogs() {
        List<IstoricClient> list = new ArrayList<>();
        String sql = "SELECT * FROM istoricclient ORDER BY dataOra DESC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                IstoricClient log = new IstoricClient();
                log.setId(rs.getInt("ID"));
                log.setIdc(rs.getInt("IDC"));
                log.setNumeClient(rs.getString("numeClient"));
                log.setActiune(rs.getString("actiune"));
                log.setDataOra(rs.getString("dataOra"));
                list.add(log);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }
}