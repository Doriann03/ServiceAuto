package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ClientDAO {

    // 1. AUTENTIFICARE (Login)
    public Client authenticate(String usernameOrEmail, String passwordHash) {
        Client client = null;
        // Verificam daca user-ul a introdus username SAU email, si daca hash-ul parolei corespunde
        String sql = "SELECT * FROM Client WHERE (username = ? OR email = ?) AND password = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, usernameOrEmail);
            stmt.setString(2, usernameOrEmail);
            stmt.setString(3, passwordHash); // Aici vine parola DEJA criptata din Servlet

            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                client = mapResultSetToClient(rs);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return client;
    }

    // 2. Modificam registerClient sa foloseasca getUsername()
    public boolean registerClient(Client c) {
        String sql = "INSERT INTO Client (nume, prenume, telefon, email, username, password, tipUtilizator) VALUES (?, ?, ?, ?, ?, ?, 'Client')";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, c.getNume());
            stmt.setString(2, c.getPrenume());
            stmt.setString(3, c.getTelefon());
            stmt.setString(4, c.getEmail());

            // --- MODIFICARE AICI: Folosim username-ul real, nu email-ul ---
            stmt.setString(5, c.getUsername());

            stmt.setString(6, c.getPassword()); // Parola deja criptata

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 3. ADAUGARE ADMIN (Din Dashboard Admin)
    public boolean addClient(Client c) {
        String sql = "INSERT INTO Client (nume, prenume, telefon, email, username, password, tipUtilizator) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getNume());
            stmt.setString(2, c.getPrenume());
            stmt.setString(3, c.getTelefon());
            stmt.setString(4, c.getEmail());
            // Daca username e null, punem email
            stmt.setString(5, c.getUsername() != null ? c.getUsername() : c.getEmail());
            stmt.setString(6, c.getPassword());
            stmt.setString(7, c.getTipUtilizator());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 4. LISTARE COMPLETA
    public List<Client> getAllClients() {
        List<Client> list = new ArrayList<>();
        String sql = "SELECT * FROM Client";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapResultSetToClient(rs));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 5. CAUTARE
    public List<Client> searchClients(String keyword) {
        List<Client> list = new ArrayList<>();
        String sql = "SELECT * FROM Client WHERE nume LIKE ? OR prenume LIKE ? OR telefon LIKE ? OR email LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String k = "%" + keyword + "%";
            stmt.setString(1, k); stmt.setString(2, k); stmt.setString(3, k); stmt.setString(4, k);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(mapResultSetToClient(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 6. GET BY ID
    public Client getClientById(int id) {
        String sql = "SELECT * FROM Client WHERE IDC = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapResultSetToClient(rs);
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // 7. UPDATE
    public boolean updateClient(Client c) {
        String sql = "UPDATE Client SET nume=?, prenume=?, telefon=?, email=?, username=?, tipUtilizator=? WHERE IDC=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, c.getNume());
            stmt.setString(2, c.getPrenume());
            stmt.setString(3, c.getTelefon());
            stmt.setString(4, c.getEmail());
            stmt.setString(5, c.getUsername());
            stmt.setString(6, c.getTipUtilizator());
            stmt.setInt(7, c.getIdc());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 8. DELETE
    public boolean deleteClient(int id) {
        String sql = "DELETE FROM Client WHERE IDC = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { return false; }
    }

    // 9. CHECK EMAIL EXISTS
    public boolean isEmailExists(String email) {
        String sql = "SELECT IDC FROM Client WHERE email = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // Helper Mapare
    private Client mapResultSetToClient(ResultSet rs) throws SQLException {
        Client c = new Client();
        c.setIdc(rs.getInt("IDC"));
        c.setNume(rs.getString("nume"));
        c.setPrenume(rs.getString("prenume"));
        c.setTelefon(rs.getString("telefon"));
        c.setEmail(rs.getString("email"));
        c.setUsername(rs.getString("username"));
        c.setPassword(rs.getString("password"));
        c.setTipUtilizator(rs.getString("tipUtilizator"));
        return c;
    }

    // Verificare daca username exista deja
    public boolean isUsernameExists(String username) {
        String sql = "SELECT IDC FROM Client WHERE username = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();
            return rs.next();
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }


}