package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.model.Angajat;
import ro.serviceauto.serviceauto.model.Atelier;
import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AngajatDAO {

    // Luam doar mecanicii sau toti angajatii tehnici
    public List<Angajat> getMecanici() {
        List<Angajat> lista = new ArrayList<>();
        String sql = "SELECT * FROM Angajat WHERE functie IN ('Mecanic', 'Electrician', 'Tinichigiu')";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while(rs.next()) {
                Angajat a = new Angajat();
                a.setIdAngajat(rs.getInt("IDAngajat"));
                a.setNume(rs.getString("nume"));
                a.setPrenume(rs.getString("prenume"));
                a.setFunctie(rs.getString("functie"));
                // Putem seta si IDA (Atelier) daca e nevoie
                lista.add(a);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // 1. Listare Angajati (cu JOIN pentru nume Atelier)
    public List<Angajat> getAllAngajati() {
        List<Angajat> list = new ArrayList<>();
        String sql = "SELECT A.*, AT.nume AS nume_atelier FROM Angajat A " +
                "LEFT JOIN Atelier AT ON A.IDA = AT.IDA"; // LEFT JOIN ca sa apara si daca nu au atelier setat
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Angajat a = mapRow(rs);
                list.add(a);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 2. Adaugare
    public boolean addAngajat(Angajat a) {
        String sql = "INSERT INTO Angajat (nume, prenume, functie, IDA) VALUES (?, ?, ?, ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, a.getNume());
            stmt.setString(2, a.getPrenume());
            stmt.setString(3, a.getFunctie());
            stmt.setInt(4, a.getIda());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 3. Update
    public boolean updateAngajat(Angajat a) {
        String sql = "UPDATE Angajat SET nume=?, prenume=?, functie=?, IDA=? WHERE IDAngajat=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, a.getNume());
            stmt.setString(2, a.getPrenume());
            stmt.setString(3, a.getFunctie());
            stmt.setInt(4, a.getIda());
            stmt.setInt(5, a.getIdAngajat());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 4. Delete
    public boolean deleteAngajat(int id) {
        String sql = "DELETE FROM Angajat WHERE IDAngajat=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    // 5. Get By ID (pt Editare)
    public Angajat getAngajatById(int id) {
        String sql = "SELECT * FROM Angajat WHERE IDAngajat=?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                // Aici nu avem JOIN, luam datele brute pt formular
                Angajat a = new Angajat();
                a.setIdAngajat(rs.getInt("IDAngajat"));
                a.setNume(rs.getString("nume"));
                a.setPrenume(rs.getString("prenume"));
                a.setFunctie(rs.getString("functie"));
                a.setIda(rs.getInt("IDA"));
                return a;
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return null;
    }

    // 6. Cautare
    public List<Angajat> searchAngajati(String keyword) {
        List<Angajat> list = new ArrayList<>();
        String sql = "SELECT A.*, AT.nume AS nume_atelier FROM Angajat A " +
                "LEFT JOIN Atelier AT ON A.IDA = AT.IDA " +
                "WHERE A.nume LIKE ? OR A.prenume LIKE ? OR A.functie LIKE ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            String k = "%" + keyword + "%";
            stmt.setString(1, k); stmt.setString(2, k); stmt.setString(3, k);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) list.add(mapRow(rs));
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    // 7. Listare Ateliere (Pt Dropdown)
    public List<Atelier> getAllAteliere() {
        List<Atelier> list = new ArrayList<>();
        String sql = "SELECT * FROM Atelier";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while(rs.next()){
                Atelier at = new Atelier();
                at.setIda(rs.getInt("IDA"));
                at.setNume(rs.getString("nume"));
                list.add(at);
            }
        } catch(SQLException e){e.printStackTrace();}
        return list;
    }

    // Helper pt mapare cu JOIN
    private Angajat mapRow(ResultSet rs) throws SQLException {
        Angajat a = new Angajat();
        a.setIdAngajat(rs.getInt("IDAngajat"));
        a.setNume(rs.getString("nume"));
        a.setPrenume(rs.getString("prenume"));
        a.setFunctie(rs.getString("functie"));
        a.setIda(rs.getInt("IDA"));
        a.setNumeAtelier(rs.getString("nume_atelier"));
        return a;
    }


}