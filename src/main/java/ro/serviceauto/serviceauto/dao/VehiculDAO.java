package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.model.Vehicul;
import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class VehiculDAO {

    // ==========================================
    // ZONA CLIENT (Folosite la Programare Online)
    // ==========================================

    // 1. Aduce vehiculele din istoricul programarilor clientului
    public List<Vehicul> getVehiclesByClient(int idClient) {
        List<Vehicul> lista = new ArrayList<>();
        String sql = "SELECT DISTINCT v.* FROM Vehicul v " +
                "JOIN Programare p ON v.IDV = p.IDV " +
                "WHERE p.IDC = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idClient);
            ResultSet rs = stmt.executeQuery();

            while(rs.next()) {
                lista.add(mapRow(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // 2. Insereaza un vehicul nou (Client Flow) si returneaza ID-ul
    public int insertVehicle(Vehicul v) {
        String sql = "INSERT INTO Vehicul (serieSasiu, marca, model, tip, motor, nrInmatriculare) VALUES (?, ?, ?, ?, ?, ?)";
        int generatedId = -1;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            stmt.setString(1, v.getSerieSasiu());
            stmt.setString(2, v.getMarca());
            stmt.setString(3, v.getModel());
            stmt.setString(4, v.getTip());
            stmt.setString(5, v.getMotor());
            stmt.setString(6, v.getNrInmatriculare());

            int rows = stmt.executeUpdate();
            if (rows > 0) {
                ResultSet rs = stmt.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return generatedId;
    }

    // ==========================================
    // ZONA ADMIN (Gestiune Parcul Auto)
    // ==========================================

    // 3. Listare Sortata
    public List<Vehicul> getAllVehiculeSorted(String coloana, String directie) {
        List<Vehicul> list = new ArrayList<>();

        String colSafe = "marca";
        if ("model".equals(coloana)) colSafe = "model";
        else if ("nr".equals(coloana)) colSafe = "nrInmatriculare";
        else if ("serie".equals(coloana)) colSafe = "serieSasiu";

        String dirSafe = "ASC";
        if ("DESC".equalsIgnoreCase(directie)) dirSafe = "DESC";

        String sql = "SELECT * FROM Vehicul ORDER BY " + colSafe + " " + dirSafe;

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 4. Cautare
    public List<Vehicul> searchVehicule(String keyword) {
        List<Vehicul> list = new ArrayList<>();
        String sql = "SELECT * FROM Vehicul WHERE marca LIKE ? OR model LIKE ? OR nrInmatriculare LIKE ? OR serieSasiu LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String k = "%" + keyword + "%";
            stmt.setString(1, k); stmt.setString(2, k); stmt.setString(3, k); stmt.setString(4, k);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 5. ADAUGARE SIMPLA (FARA Legatura cu Client momentan)
    public boolean addVehicul(Vehicul v) {
        String sql = "INSERT INTO Vehicul (serieSasiu, marca, model, tip, motor, nrInmatriculare) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, v.getSerieSasiu());
            stmt.setString(2, v.getMarca());
            stmt.setString(3, v.getModel());
            stmt.setString(4, v.getTip());
            stmt.setString(5, v.getMotor());
            stmt.setString(6, v.getNrInmatriculare());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 6. UPDATE
    public boolean updateVehicul(Vehicul v) {
        String sql = "UPDATE Vehicul SET serieSasiu=?, marca=?, model=?, tip=?, motor=?, nrInmatriculare=? WHERE IDV=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, v.getSerieSasiu());
            stmt.setString(2, v.getMarca());
            stmt.setString(3, v.getModel());
            stmt.setString(4, v.getTip());
            stmt.setString(5, v.getMotor());
            stmt.setString(6, v.getNrInmatriculare());
            stmt.setInt(7, v.getIdv());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 7. DELETE (Simplu - esueaza daca are istoric, pentru siguranta)
    public boolean deleteVehicul(int id) {
        String sql = "DELETE FROM Vehicul WHERE IDV=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Eroare la stergere (posibil Foreign Key): " + e.getMessage());
            return false;
        }
    }



    // 8. Get By ID
    public Vehicul getVehiculById(int id) {
        String sql = "SELECT * FROM Vehicul WHERE IDV=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapRow(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // 9. Lista completa (folosita de Export)
    public List<Vehicul> getAllVehiculeAdmin() {
        return getAllVehiculeSorted("marca", "ASC");
    }

    // Helper intern pentru mapare
    private Vehicul mapRow(ResultSet rs) throws SQLException {
        Vehicul v = new Vehicul();
        v.setIdv(rs.getInt("IDV"));
        v.setSerieSasiu(rs.getString("serieSasiu"));
        v.setMarca(rs.getString("marca"));
        v.setModel(rs.getString("model"));
        v.setTip(rs.getString("tip"));
        v.setMotor(rs.getString("motor"));
        v.setNrInmatriculare(rs.getString("nrInmatriculare"));
        return v;
    }

    // 1. Verificam daca exista programari legate de acest vehicul
    public boolean hasDependencies(int idv) {
        String sql = "SELECT COUNT(*) FROM Programare WHERE IDV = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idv);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // Returneaza true daca count > 0
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // 2. Stergere in cascada (Lucrare -> Programare -> Vehicul)
    public boolean deleteVehiculCascade(int idv) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // Start Tranzactie

            // A. Stergem Lucrarile aferente Programarilor acestui Vehicul
            // (Stergem nepotii intai)
            String sqlLucrari = "DELETE FROM Lucrare WHERE IDP IN (SELECT IDP FROM Programare WHERE IDV = ?)";
            try(PreparedStatement ps = conn.prepareStatement(sqlLucrari)) {
                ps.setInt(1, idv);
                ps.executeUpdate();
            }

            // B. Stergem Programarile (Stergem copiii)
            String sqlProg = "DELETE FROM Programare WHERE IDV = ?";
            try(PreparedStatement ps = conn.prepareStatement(sqlProg)) {
                ps.setInt(1, idv);
                ps.executeUpdate();
            }

            // C. Stergem Vehiculul (Stergem parintele)
            String sqlVeh = "DELETE FROM Vehicul WHERE IDV = ?";
            try(PreparedStatement ps = conn.prepareStatement(sqlVeh)) {
                ps.setInt(1, idv);
                ps.executeUpdate();
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try { if(conn!=null) conn.rollback(); } catch(SQLException ex){}
            return false;
        } finally {
            try { if(conn!=null) { conn.setAutoCommit(true); conn.close(); } } catch(SQLException e){}
        }
    }
}