package ro.serviceauto.serviceauto.servlet;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ro.serviceauto.serviceauto.dao.ServiciuDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.Serviciu;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin-import-servicii")
@MultipartConfig
public class AdminImportServiciiServlet extends HttpServlet {
    private ServiciuDAO serviciuDAO;
    public void init() { serviciuDAO = new ServiciuDAO(); }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String step = request.getParameter("step");
        if ("preview".equals(step)) handlePreview(request, response, session);
        else if ("save".equals(step)) handleSave(request, response, session);
        else if ("cancel".equals(step)) {
            session.removeAttribute("previewServicii");
            response.sendRedirect("import_servicii.jsp");
        }
    }

    private void handlePreview(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException, ServletException {

        // Acum linia asta nu mai da eroare
        Part filePart = request.getPart("fisierExcel");

        List<Serviciu> lista = new ArrayList<>();
        DataFormatter formatter = new DataFormatter();

        try (InputStream is = filePart.getInputStream(); Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // Skip header
                try {
                    Serviciu s = new Serviciu();
                    // A: Nume
                    s.setNume(formatter.formatCellValue(row.getCell(0)));
                    // B: Descriere
                    s.setDescriere(formatter.formatCellValue(row.getCell(1)));

                    // C: Durata
                    String dur = formatter.formatCellValue(row.getCell(2));
                    // Tratare sigura pentru durata (daca e goala punem 0)
                    try {
                        s.setDurataEstimata(dur.isEmpty() ? 0 : (int)Double.parseDouble(dur));
                    } catch (NumberFormatException e) { s.setDurataEstimata(0); }

                    // D: ID Atelier
                    String idaStr = formatter.formatCellValue(row.getCell(3));
                    // Tratare sigura pentru ID Atelier
                    try {
                        s.setIda(idaStr.isEmpty() ? 0 : (int)Double.parseDouble(idaStr));
                    } catch (NumberFormatException e) { s.setIda(0); }

                    // Adaugam doar daca are nume
                    if (s.getNume() != null && !s.getNume().trim().isEmpty()) {
                        lista.add(s);
                    }
                } catch (Exception e) { e.printStackTrace(); }
            }
            session.setAttribute("previewServicii", lista);
            response.sendRedirect("import_servicii.jsp");
        } catch (Exception e) {
            response.sendRedirect("import_servicii.jsp?error=Fisier invalid sau corupt");
        }
    }

    private void handleSave(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        List<Serviciu> lista = (List<Serviciu>) session.getAttribute("previewServicii");
        if (lista != null) {
            for (Serviciu s : lista) serviciuDAO.addServiciu(s);
        }
        session.removeAttribute("previewServicii");
        response.sendRedirect("admin-servicii");
    }
}