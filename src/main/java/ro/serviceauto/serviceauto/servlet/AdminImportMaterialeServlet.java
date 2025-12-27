package ro.serviceauto.serviceauto.servlet;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ro.serviceauto.serviceauto.dao.MaterialePieseDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.MaterialePiese;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/admin-import-materiale")
@MultipartConfig
public class AdminImportMaterialeServlet extends HttpServlet {
    private MaterialePieseDAO dao;
    public void init() { dao = new MaterialePieseDAO(); }

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
            session.removeAttribute("previewMateriale");
            response.sendRedirect("import_materiale.jsp");
        }
    }

    private void handlePreview(HttpServletRequest request, HttpServletResponse response, HttpSession session)
            throws IOException, ServletException {

        Part filePart = request.getPart("fisierExcel");
        List<MaterialePiese> lista = new ArrayList<>();
        DataFormatter formatter = new DataFormatter();

        try (InputStream is = filePart.getInputStream(); Workbook workbook = new XSSFWorkbook(is)) {
            Sheet sheet = workbook.getSheetAt(0);
            for (Row row : sheet) {
                if (row.getRowNum() == 0) continue; // Skip header
                try {
                    // Col A: Denumire, B: Cantitate, C: Pret, D: ID Serviciu
                    MaterialePiese m = new MaterialePiese();
                    m.setDenumire(formatter.formatCellValue(row.getCell(0)));

                    String cant = formatter.formatCellValue(row.getCell(1));
                    m.setCantitate(cant.isEmpty() ? 0 : (int)Double.parseDouble(cant));

                    String pret = formatter.formatCellValue(row.getCell(2));
                    m.setPretUnitar(pret.isEmpty() ? 0.0 : Double.parseDouble(pret));

                    String idsStr = formatter.formatCellValue(row.getCell(3));
                    m.setIds(idsStr.isEmpty() ? 0 : (int)Double.parseDouble(idsStr));

                    if (m.getDenumire() != null && !m.getDenumire().isEmpty()) lista.add(m);
                } catch (Exception e) { e.printStackTrace(); }
            }
            session.setAttribute("previewMateriale", lista);
            response.sendRedirect("import_materiale.jsp");
        } catch (Exception e) { response.sendRedirect("import_materiale.jsp?error=Fisier invalid"); }
    }

    private void handleSave(HttpServletRequest request, HttpServletResponse response, HttpSession session) throws IOException {
        List<MaterialePiese> lista = (List<MaterialePiese>) session.getAttribute("previewMateriale");
        if (lista != null) {
            for (MaterialePiese m : lista) dao.addMaterial(m);
        }
        session.removeAttribute("previewMateriale");
        response.sendRedirect("admin-materiale");
    }
}