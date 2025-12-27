package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.model.Atelier;
import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AtelierDAO {

    // 1. Listare cu Sortare
    public List<Atelier> getAllAteliereSorted(String coloana, String directie) {
        List<Atelier> list = new ArrayList<>();

        // Whitelist coloane
        String colSafe = "nume";
        if ("id".equals(coloana)) colSafe = "IDA";
        else if ("adresa".equals(coloana)) colSafe = "adresa";

        String dirSafe = "ASC";
        if ("DESC".equalsIgnoreCase(directie)) dirSafe = "DESC";

        String sql = "SELECT * FROM Atelier ORDER BY " + colSafe + " " + dirSafe;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 2. Cautare
    public List<Atelier> searchAteliere(String keyword) {
        List<Atelier> list = new ArrayList<>();
        String sql = "SELECT * FROM Atelier WHERE nume LIKE ? OR adresa LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 3. Adaugare
    public boolean addAtelier(Atelier a) {
        String sql = "INSERT INTO Atelier (nume, adresa) VALUES (?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, a.getNume());
            stmt.setString(2, a.getAdresa());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 4. Update
    public boolean updateAtelier(Atelier a) {
        String sql = "UPDATE Atelier SET nume=?, adresa=? WHERE IDA=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, a.getNume());
            stmt.setString(2, a.getAdresa());
            stmt.setInt(3, a.getIda());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 5. Delete
    public boolean deleteAtelier(int id) {
        String sql = "DELETE FROM Atelier WHERE IDA=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            // Probabil va da eroare daca exista angajati/servicii legate de acest atelier
            e.printStackTrace();
            return false;
        }
    }

    // 6. Get By ID
    public Atelier getAtelierById(int id) {
        String sql = "SELECT * FROM Atelier WHERE IDA=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    private Atelier mapRow(ResultSet rs) throws SQLException {
        Atelier a = new Atelier();
        a.setIda(rs.getInt("IDA"));
        a.setNume(rs.getString("nume"));
        a.setAdresa(rs.getString("adresa"));
        return a;
    }
}