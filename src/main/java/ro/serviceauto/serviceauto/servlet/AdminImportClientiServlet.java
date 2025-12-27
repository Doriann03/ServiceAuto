package ro.serviceauto.serviceauto.servlet;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin-import-clienti")
@MultipartConfig
public class AdminImportClientiServlet extends HttpServlet {

    private ClientDAO clientDAO;

    public void init() {
        clientDAO = new ClientDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String step = request.getParameter("step");

        if ("preview".equals(step)) {
            handlePreview(request, response, session);
        } else if ("save".equals(step)) {
            handleSave(request, response, session);
        } else if ("cancel".equals(step)) {
            session.removeAttribute("listaImportPreview"); // Stergem datele temporare
            response.sendRedirect("import_clienti.jsp");
        }
    }

    // --- FAZA 1: CITIRE EXCEL SI AFISARE PREVIEW ---
    private void handlePreview(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException, ServletException {

        Part filePart = request.getPart("fisierExcel");
        List<Client> listaPreview = new ArrayList<>();
        DataFormatter formatter = new DataFormatter();

        try (InputStream fileContent = filePart.getInputStream();
             Workbook workbook = new XSSFWorkbook(fileContent)) {

            Sheet sheet = workbook.getSheetAt(0);

            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // Sarim Header-ul

                try {
                    Client c = new Client();
                    // Citim datele exact cum am stabilit (fara ID pe prima coloana!)
                    // A: Nume, B: Prenume, C: Telefon, D: Email, E: Username, F: Pass, G: Rol
                    c.setNume(formatter.formatCellValue(row.getCell(0)));
                    c.setPrenume(formatter.formatCellValue(row.getCell(1)));
                    c.setTelefon(formatter.formatCellValue(row.getCell(2)));
                    c.setEmail(formatter.formatCellValue(row.getCell(3)));
                    c.setUsername(formatter.formatCellValue(row.getCell(4)));
                    c.setPassword(formatter.formatCellValue(row.getCell(5)));

                    String rol = formatter.formatCellValue(row.getCell(6));
                    c.setTipUtilizator(rol.isEmpty() ? "Client" : rol);

                    // Adaugam in lista temporara doar daca are username
                    if (c.getUsername() != null && !c.getUsername().trim().isEmpty()) {
                        listaPreview.add(c);
                    }
                } catch (Exception e) {
                    // Putem ignora randurile goale sau eronate la preview
                }
            }

            // SALVAM LISTA IN SESIUNE (TEMPORAR)
            session.setAttribute("listaImportPreview", listaPreview);
            response.sendRedirect("import_clienti.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("import_clienti.jsp?error=Fisierul nu este valid!");
        }
    }

    // --- FAZA 2: SALVARE IN BAZA DE DATE ---
    private void handleSave(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException {

        List<Client> lista = (List<Client>) session.getAttribute("listaImportPreview");

        if (lista == null || lista.isEmpty()) {
            response.sendRedirect("import_clienti.jsp?error=Sesiunea a expirat, incarca din nou.");
            return;
        }

        int success = 0;
        int fail = 0;

        for (Client c : lista) {
            if (clientDAO.addClient(c)) {
                success++;
            } else {
                fail++;
            }
        }

        // Curatam sesiunea
        session.removeAttribute("listaImportPreview");

        String msg = "Import Finalizat! Reușite: " + success + ", Eșuate: " + fail;
        response.sendRedirect("clienti_admin.jsp?msg=" + java.net.URLEncoder.encode(msg, "UTF-8"));
    }
}