package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.model.Atelier;
import ro.serviceauto.serviceauto.model.Serviciu;
import ro.serviceauto.serviceauto.model.dto.ServiciuAfisare;
import ro.serviceauto.serviceauto.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ServiciuDAO {

    // ==========================================
    // ZONA CLIENT (Metode vechi, necesare)
    // ==========================================

    // 1. Folosita la dropdown-ul de Programare (returneaza Serviciu simplu)
    public List<Serviciu> getAllServices() {
        List<Serviciu> lista = new ArrayList<>();
        String sql = "SELECT * FROM Serviciu";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while(rs.next()) {
                Serviciu s = new Serviciu();
                s.setIds(rs.getInt("IDS"));
                s.setNume(rs.getString("nume"));
                s.setDescriere(rs.getString("descriere"));
                s.setDurataEstimata(rs.getInt("durata_estimata"));
                s.setIda(rs.getInt("IDA"));
                lista.add(s);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // 2. Folosita la tabelul de Servicii Disponibile Client (returneaza DTO complex)
    public List<ServiciuAfisare> getServiciiCuDetaliiAtelier() {
        List<ServiciuAfisare> lista = new ArrayList<>();
        String sql = "SELECT s.nume, s.descriere, s.durata_estimata, a.nume AS nume_atelier, a.adresa " +
                "FROM Serviciu s JOIN Atelier a ON s.IDA = a.IDA";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while(rs.next()) {
                ServiciuAfisare dto = new ServiciuAfisare();
                dto.setNumeServiciu(rs.getString("nume"));
                dto.setDescriere(rs.getString("descriere"));
                dto.setDurata(rs.getInt("durata_estimata"));
                dto.setNumeAtelier(rs.getString("nume_atelier"));
                dto.setAdresaAtelier(rs.getString("adresa"));
                lista.add(dto);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // ==========================================
    // ZONA ADMIN (Metode noi)
    // ==========================================

    // 3. Listare Sortată (Logica principală pentru Admin Table)
    public List<Serviciu> getAllServiciiSorted(String coloana, String directie) {
        List<Serviciu> list = new ArrayList<>();

        // Whitelist pentru securitate (sa nu permitem SQL Injection in ORDER BY)
        String colSafe = "nume";
        if ("descriere".equals(coloana)) colSafe = "descriere";
        else if ("durata".equals(coloana)) colSafe = "durata_estimata";
        else if ("atelier".equals(coloana)) colSafe = "nume_atelier";

        String dirSafe = "ASC";
        if ("DESC".equalsIgnoreCase(directie)) dirSafe = "DESC";

        String sql = "SELECT S.*, A.nume AS nume_atelier FROM Serviciu S " +
                "LEFT JOIN Atelier A ON S.IDA = A.IDA " +
                "ORDER BY " + colSafe + " " + dirSafe;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 4. Listare Simpla Admin (Folosita de EXPORT PDF/Excel)
    // Aceasta metoda rezolva eroarea ta! Ea apeleaza metoda de mai sus cu valori default.
    public List<Serviciu> getAllServiciiAdmin() {
        return getAllServiciiSorted("nume", "ASC");
    }

    // 5. Cautare
    public List<Serviciu> searchServicii(String keyword) {
        List<Serviciu> list = new ArrayList<>();
        String sql = "SELECT S.*, A.nume AS nume_atelier FROM Serviciu S " +
                "LEFT JOIN Atelier A ON S.IDA = A.IDA " +
                "WHERE S.nume LIKE ? OR S.descriere LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 6. Adaugare
    public boolean addServiciu(Serviciu s) {
        String sql = "INSERT INTO Serviciu (nume, descriere, durata_estimata, IDA) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, s.getNume());
            stmt.setString(2, s.getDescriere());
            stmt.setInt(3, s.getDurataEstimata());
            stmt.setInt(4, s.getIda());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 7. Update
    public boolean updateServiciu(Serviciu s) {
        String sql = "UPDATE Serviciu SET nume=?, descriere=?, durata_estimata=?, IDA=? WHERE IDS=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, s.getNume());
            stmt.setString(2, s.getDescriere());
            stmt.setInt(3, s.getDurataEstimata());
            stmt.setInt(4, s.getIda());
            stmt.setInt(5, s.getIds());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 8. Delete
    public boolean deleteServiciu(int id) {
        String sql = "DELETE FROM Serviciu WHERE IDS=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }

    // 9. Get By ID (pt Formular Editare)
    public Serviciu getServiciuById(int id) {
        String sql = "SELECT * FROM Serviciu WHERE IDS=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Serviciu s = new Serviciu();
                s.setIds(rs.getInt("IDS"));
                s.setNume(rs.getString("nume"));
                s.setDescriere(rs.getString("descriere"));
                s.setDurataEstimata(rs.getInt("durata_estimata"));
                s.setIda(rs.getInt("IDA"));
                return s;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // 10. Lista Ateliere (Pt Dropdown in Formular)
    public List<Atelier> getAllAteliere() {
        List<Atelier> list = new ArrayList<>();
        String sql = "SELECT * FROM Atelier";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while(rs.next()){
                Atelier a = new Atelier();
                a.setIda(rs.getInt("IDA"));
                a.setNume(rs.getString("nume"));
                list.add(a);
            }
        } catch(SQLException e){ e.printStackTrace(); }
        return list;
    }

    // Helper intern pentru mapare (evita duplicarea codului)
    private Serviciu mapRow(ResultSet rs) throws SQLException {
        Serviciu s = new Serviciu();
        s.setIds(rs.getInt("IDS"));
        s.setNume(rs.getString("nume"));
        s.setDescriere(rs.getString("descriere"));
        s.setDurataEstimata(rs.getInt("durata_estimata"));
        s.setIda(rs.getInt("IDA"));
        s.setNumeAtelier(rs.getString("nume_atelier"));
        return s;
    }
}