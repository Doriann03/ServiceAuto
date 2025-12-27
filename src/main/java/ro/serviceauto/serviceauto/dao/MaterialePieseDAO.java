package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.model.MaterialePiese;
import ro.serviceauto.serviceauto.model.Serviciu;
import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MaterialePieseDAO {

    // 1. Listare Sortata
    public List<MaterialePiese> getAllMaterialeSorted(String coloana, String directie) {
        List<MaterialePiese> list = new ArrayList<>();

        String colSafe = "denumire";
        // MODIFICARE AICI: mapam sortarea pe coloana "pret" din baza de date
        if ("cantitate".equals(coloana)) colSafe = "cantitate";
        else if ("pret".equals(coloana)) colSafe = "pret";
        else if ("serviciu".equals(coloana)) colSafe = "nume_serviciu";

        String dirSafe = "ASC";
        if ("DESC".equalsIgnoreCase(directie)) dirSafe = "DESC";

        String sql = "SELECT m.*, s.nume AS nume_serviciu FROM MaterialePiese m " +
                "LEFT JOIN Serviciu s ON m.IDS = s.IDS " +
                "ORDER BY " + colSafe + " " + dirSafe;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 2. Cautare
    public List<MaterialePiese> searchMateriale(String keyword) {
        List<MaterialePiese> list = new ArrayList<>();
        String sql = "SELECT m.*, s.nume AS nume_serviciu FROM MaterialePiese m " +
                "LEFT JOIN Serviciu s ON m.IDS = s.IDS " +
                "WHERE m.denumire LIKE ? OR s.nume LIKE ?";
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
    public boolean addMaterial(MaterialePiese m) {
        // MODIFICARE AICI: folosim coloana "pret" in SQL
        String sql = "INSERT INTO MaterialePiese (denumire, cantitate, pret, IDS) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, m.getDenumire());
            stmt.setInt(2, m.getCantitate());
            stmt.setDouble(3, m.getPretUnitar()); // In Java ramane getPretUnitar
            stmt.setInt(4, m.getIds());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 4. Update
    public boolean updateMaterial(MaterialePiese m) {
        // MODIFICARE AICI: folosim coloana "pret" in SQL
        String sql = "UPDATE MaterialePiese SET denumire=?, cantitate=?, pret=?, IDS=? WHERE IDMat=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, m.getDenumire());
            stmt.setInt(2, m.getCantitate());
            stmt.setDouble(3, m.getPretUnitar());
            stmt.setInt(4, m.getIds());
            stmt.setInt(5, m.getIdMat());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 5. Delete
    public boolean deleteMaterial(int id) {
        String sql = "DELETE FROM MaterialePiese WHERE IDMat=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }

    // 6. Get By ID
    public MaterialePiese getMaterialById(int id) {
        String sql = "SELECT * FROM MaterialePiese WHERE IDMat=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Nu folosim mapRow aici pentru ca nu avem JOIN cu Serviciu in acest SELECT simplu
                MaterialePiese m = new MaterialePiese();
                m.setIdMat(rs.getInt("IDMat"));
                m.setDenumire(rs.getString("denumire"));
                m.setCantitate(rs.getInt("cantitate"));
                m.setPretUnitar(rs.getDouble("pret")); // MODIFICARE AICI: citim coloana "pret"
                m.setIds(rs.getInt("IDS"));
                return m;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // 7. Lista completa (pt Export)
    public List<MaterialePiese> getAllMaterialeAdmin() {
        return getAllMaterialeSorted("denumire", "ASC");
    }

    // 8. Helper: Luam lista de Servicii pt Dropdown
    public List<Serviciu> getAllServiciiSimple() {
        List<Serviciu> list = new ArrayList<>();
        String sql = "SELECT IDS, nume FROM Serviciu ORDER BY nume ASC";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while(rs.next()){
                Serviciu s = new Serviciu();
                s.setIds(rs.getInt("IDS"));
                s.setNume(rs.getString("nume"));
                list.add(s);
            }
        } catch(SQLException e){e.printStackTrace();}
        return list;
    }

    // Helper mapare
    private MaterialePiese mapRow(ResultSet rs) throws SQLException {
        MaterialePiese m = new MaterialePiese();
        m.setIdMat(rs.getInt("IDMat"));
        m.setDenumire(rs.getString("denumire"));
        m.setCantitate(rs.getInt("cantitate"));

        // --- MODIFICARE AICI ---
        // Citim din coloana "pret" a bazei de date, dar punem in variabila Java "pretUnitar"
        m.setPretUnitar(rs.getDouble("pret"));

        m.setIds(rs.getInt("IDS"));
        m.setNumeServiciu(rs.getString("nume_serviciu"));
        return m;
    }
}