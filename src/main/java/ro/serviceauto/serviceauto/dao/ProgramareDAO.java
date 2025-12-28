package ro.serviceauto.serviceauto.dao;

import ro.serviceauto.serviceauto.util.DatabaseConnection;
import java.sql.*;
import ro.serviceauto.serviceauto.model.dto.IstoricDTO;
import java.util.ArrayList;
import java.util.List;
import ro.serviceauto.serviceauto.model.dto.ProgramareAdminDTO;

public class ProgramareDAO {

    public boolean createProgramare(int idClient, int idVehicul, int idServiciu, String dataProg) {
        Connection conn = null;
        PreparedStatement stmtProg = null;
        PreparedStatement stmtLink = null;
        boolean success = false;

        String sqlProgramare = "INSERT INTO Programare (IDC, IDV, dataProg, status) VALUES (?, ?, ?, 'Programat')";
        String sqlLink = "INSERT INTO Prog_Serv (IDP, IDS) VALUES (?, ?)";

        try {
            conn = DatabaseConnection.getConnection();
            // 1. Oprim Auto-Commit pentru a gestiona tranzactia manual
            conn.setAutoCommit(false);

            // 2. Inseram Programarea
            stmtProg = conn.prepareStatement(sqlProgramare, Statement.RETURN_GENERATED_KEYS);
            stmtProg.setInt(1, idClient);
            stmtProg.setInt(2, idVehicul);
            stmtProg.setString(3, dataProg); // MySQL accepta String pt datetime daca e format corect

            int rows = stmtProg.executeUpdate();

            if (rows > 0) {
                // 3. Obtinem ID-ul generat (IDP)
                ResultSet rs = stmtProg.getGeneratedKeys();
                if (rs.next()) {
                    int idP = rs.getInt(1);

                    // 4. Inseram legatura in Prog_Serv
                    stmtLink = conn.prepareStatement(sqlLink);
                    stmtLink.setInt(1, idP);
                    stmtLink.setInt(2, idServiciu);
                    stmtLink.executeUpdate();

                    // Daca am ajuns aici fara erori, validam totul
                    conn.commit();
                    success = true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) conn.rollback(); // Anulam tot daca apare eroare
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        } finally {
            // Inchidem resursele si reactivam auto-commit
            try {
                if (stmtProg != null) stmtProg.close();
                if (stmtLink != null) stmtLink.close();
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return success;
    }

    public List<IstoricDTO> getIstoricClient(int idClient) {
        List<IstoricDTO> lista = new ArrayList<>();

        // JOIN ca sa luam datele masinii pe baza IDV din programare
        String sql = "SELECT p.IDP, p.dataProg, p.status, v.marca, v.model, v.nrInmatriculare " +
                "FROM Programare p " +
                "JOIN Vehicul v ON p.IDV = v.IDV " +
                "WHERE p.IDC = ? " +
                "ORDER BY p.dataProg DESC"; // Cele mai noi primele

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idClient); // Punem ID-ul clientului logat in SQL

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    IstoricDTO dto = new IstoricDTO();
                    dto.setIdProgramare(rs.getInt("IDP"));

                    // Mic truc: MySQL returneaza data cu T sau spatiu, o luam ca String simplu
                    String dataBruta = rs.getString("dataProg");
                    dto.setDataProgramare(dataBruta.substring(0, 16)); // Taiem secundele sa arate curat

                    dto.setStatus(rs.getString("status"));
                    dto.setMarcaModel(rs.getString("marca") + " " + rs.getString("model"));
                    dto.setNrInmatriculare(rs.getString("nrInmatriculare"));

                    lista.add(dto);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Metoda noua pentru verificarea disponibilitatii (AJAX)
    public String checkSlotStatus(int idServiciu, String dataOra) {
        String status = "Disponibil"; // Default

        String sql = "SELECT p.status FROM Programare p " +
                "JOIN Prog_Serv ps ON p.IDP = ps.IDP " +
                "WHERE ps.IDS = ? AND p.dataProg = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, idServiciu);
            stmt.setString(2, dataOra);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    // Daca exista o inregistrare, vedem statusul ei
                    String dbStatus = rs.getString("status");
                    if ("In lucru".equals(dbStatus)) {
                        status = "In lucru";
                    } else {
                        // Programat, Finalizat, etc. le consideram Ocupate pentru acea ora
                        status = "Ocupat";
                    }
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }

        return status;
    }

    public List<ProgramareAdminDTO> getAllProgramariAdmin() {
        List<ProgramareAdminDTO> lista = new ArrayList<>();

        // JOIN TRIPLU: Programare -> Client -> Vehicul
        String sql = "SELECT p.IDP, p.dataProg, p.status, " +
                "c.nume, c.prenume, c.telefon, " +
                "v.marca, v.model, v.nrInmatriculare " +
                "FROM Programare p " +
                "JOIN Client c ON p.IDC = c.IDC " +
                "JOIN Vehicul v ON p.IDV = v.IDV " +
                "ORDER BY p.dataProg DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while(rs.next()) {
                ProgramareAdminDTO dto = new ProgramareAdminDTO();
                dto.setIdProgramare(rs.getInt("IDP"));

                // Concatenam Numele cu Prenumele
                dto.setNumeClient(rs.getString("nume") + " " + rs.getString("prenume"));
                dto.setTelefonClient(rs.getString("telefon"));

                dto.setMarcaModel(rs.getString("marca") + " " + rs.getString("model"));
                dto.setNrInmatriculare(rs.getString("nrInmatriculare"));

                // Data fara secunde
                String dataFull = rs.getString("dataProg");
                dto.setDataProgramare(dataFull.substring(0, 16));

                dto.setStatus(rs.getString("status"));

                lista.add(dto);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return lista;
    }

    // Metoda DELETE cu tranzactie (Sterge Lucrare -> apoi Programare)
    public boolean deleteProgramare(int idp) {
        Connection conn = null;
        PreparedStatement stmtDelLucrare = null;
        PreparedStatement stmtDelProg = null;

        try {
            conn = DatabaseConnection.getConnection();
            conn.setAutoCommit(false); // 1. Oprim auto-commit (Start Tranzactie)

            // PASUL A: Stergem Lucrarea asociata (daca exista)
            // Aceasta este "copilul" care bloca stergerea
            String sqlLucrare = "DELETE FROM Lucrare WHERE IDP = ?";
            stmtDelLucrare = conn.prepareStatement(sqlLucrare);
            stmtDelLucrare.setInt(1, idp);
            stmtDelLucrare.executeUpdate();

            // PASUL B: Stergem Programarea
            String sqlProg = "DELETE FROM Programare WHERE IDP = ?";
            stmtDelProg = conn.prepareStatement(sqlProg);
            stmtDelProg.setInt(1, idp);
            int rows = stmtDelProg.executeUpdate();

            // 2. Salvam modificarile
            conn.commit();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            // In caz de eroare, dam rollback (anulam tot)
            try { if (conn != null) conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
            return false;
        } finally {
            // 3. Inchidem resursele manual
            try { if (stmtDelLucrare != null) stmtDelLucrare.close(); } catch (SQLException e) {}
            try { if (stmtDelProg != null) stmtDelProg.close(); } catch (SQLException e) {}
            try { if (conn != null) { conn.setAutoCommit(true); conn.close(); } } catch (SQLException e) {}
        }
    }


}