package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import ro.serviceauto.serviceauto.model.dto.LucrareAdminDTO;
import java.util.ArrayList;
import java.util.List;

public class LucrareDAO {

    public boolean creazaLucrareDinProgramare(int idProgramare, int idAngajat, String descriere) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // TRANZACTIE

            // 1. Luam IDA (Atelierul) angajatului ca sa il punem in lucrare
            // Simplificare: Presupunem Atelier ID = 1 sau il luam din Angajat.
            // Corect ar fi un SELECT inainte, dar hardcodam 1 pt moment sau facem query.
            // Hai sa facem un query rapid sa luam Atelierul angajatului.
            int idAtelier = 1;
            String sqlGetAtelier = "SELECT IDA FROM Angajat WHERE IDAngajat = ?";
            try(PreparedStatement s = conn.prepareStatement(sqlGetAtelier)){
                s.setInt(1, idAngajat);
                ResultSet rs = s.executeQuery();
                if(rs.next()) idAtelier = rs.getInt(1);
            }

            // 2. Insert in Lucrare
            String sqlLucrare = "INSERT INTO Lucrare (IDP, IDA, dataInitiala, descriere) VALUES (?, ?, NOW(), ?)";
            try(PreparedStatement s = conn.prepareStatement(sqlLucrare, Statement.RETURN_GENERATED_KEYS)) {
                s.setInt(1, idProgramare);
                s.setInt(2, idAtelier);
                s.setString(3, descriere);
                s.executeUpdate();

                // Putem lua ID-ul lucrarii ca sa inseram si in Lucrare_Angajat daca ai tabela aia
                // Conform SQL tau ai tabela `Lucrare_Angajat`. E bine sa scriem si acolo.
                ResultSet rsKeys = s.getGeneratedKeys();
                if(rsKeys.next()) {
                    int idLucrare = rsKeys.getInt(1);
                    String sqlRel = "INSERT INTO Lucrare_Angajat (IDL, IDAngajat) VALUES (?, ?)";
                    try(PreparedStatement s2 = conn.prepareStatement(sqlRel)){
                        s2.setInt(1, idLucrare);
                        s2.setInt(2, idAngajat);
                        s2.executeUpdate();
                    }
                }
            }

            // 3. Update status Programare
            String sqlUpdate = "UPDATE Programare SET status = 'In lucru' WHERE IDP = ?";
            try(PreparedStatement s = conn.prepareStatement(sqlUpdate)){
                s.setInt(1, idProgramare);
                s.executeUpdate();
            }

            conn.commit(); // GATA
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try { if(conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return false;
        } finally {
            try { if(conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (SQLException e) {}
        }
    }

    //Lista tuturor lucrarilor (active si finalizate)
    public List<LucrareAdminDTO> getAllLucrari() {
        List<LucrareAdminDTO> lista = new ArrayList<>();

        // Query complex care leaga toate tabelele
        // Observatie: Folosim LEFT JOIN la Angajat/Lucrare_Angajat pentru ca e posibil (desi rar) sa nu aiba mecanic inca
        String sql = "SELECT l.IDL, l.dataInitiala, l.descriere, l.pret, p.status, " +
                "c.nume, c.prenume, v.marca, v.model, v.nrInmatriculare, " +
                "a.nume AS nume_mecanic, a.prenume AS prenume_mecanic " +
                "FROM Lucrare l " +
                "JOIN Programare p ON l.IDP = p.IDP " +
                "JOIN Client c ON p.IDC = c.IDC " +
                "JOIN Vehicul v ON p.IDV = v.IDV " +
                "LEFT JOIN Lucrare_Angajat la ON l.IDL = la.IDL " +
                "LEFT JOIN Angajat a ON la.IDAngajat = a.IDAngajat " +
                "ORDER BY l.dataInitiala DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while(rs.next()) {
                LucrareAdminDTO dto = new LucrareAdminDTO();
                dto.setIdLucrare(rs.getInt("IDL"));
                dto.setDataInitiala(rs.getString("dataInitiala"));
                dto.setDescriere(rs.getString("descriere"));
                dto.setPret(rs.getDouble("pret"));
                dto.setStatus(rs.getString("status"));

                dto.setNumeClient(rs.getString("nume") + " " + rs.getString("prenume"));
                dto.setMasina(rs.getString("marca") + " " + rs.getString("model") + " (" + rs.getString("nrInmatriculare") + ")");

                if (rs.getString("nume_mecanic") != null) {
                    dto.setNumeMecanic(rs.getString("nume_mecanic") + " " + rs.getString("prenume_mecanic"));
                } else {
                    dto.setNumeMecanic("Neselectat");
                }

                lista.add(dto);
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return lista;
    }

    // 2. Finalizare Lucrare (Tranzactie: Update Lucrare + Update Programare)
    public boolean finalizeazaLucrare(int idLucrare, double pretFinal) {
        Connection conn = null;
        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false);

            // A. Update pret si dataFinala in tabela Lucrare
            String sqlLucrare = "UPDATE Lucrare SET pret = ?, dataFinala = NOW() WHERE IDL = ?";
            try(PreparedStatement s = conn.prepareStatement(sqlLucrare)) {
                s.setDouble(1, pretFinal);
                s.setInt(2, idLucrare);
                s.executeUpdate();
            }

            // B. Trebuie sa aflam ID-ul programarii asociate acestei lucrari
            int idProgramare = 0;
            String sqlFindP = "SELECT IDP FROM Lucrare WHERE IDL = ?";
            try(PreparedStatement s = conn.prepareStatement(sqlFindP)) {
                s.setInt(1, idLucrare);
                ResultSet rs = s.executeQuery();
                if(rs.next()) idProgramare = rs.getInt(1);
            }

            // C. Update status in Programare -> 'Finalizat'
            if (idProgramare > 0) {
                String sqlProg = "UPDATE Programare SET status = 'Finalizat' WHERE IDP = ?";
                try(PreparedStatement s = conn.prepareStatement(sqlProg)) {
                    s.setInt(1, idProgramare);
                    s.executeUpdate();
                }
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