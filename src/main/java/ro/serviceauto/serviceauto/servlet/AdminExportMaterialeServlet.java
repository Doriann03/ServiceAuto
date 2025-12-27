package ro.serviceauto.serviceauto.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ro.serviceauto.serviceauto.dao.MaterialePieseDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.MaterialePiese;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/admin-export-materiale")
public class AdminExportMaterialeServlet extends HttpServlet {
    private MaterialePieseDAO dao;
    public void init() { dao = new MaterialePieseDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String type = request.getParameter("type");
        List<MaterialePiese> lista = dao.getAllMaterialeAdmin();

        if ("pdf".equals(type)) exportToPDF(response, lista);
        else if ("excel".equals(type)) exportToExcel(response, lista);
    }

    private void exportToPDF(HttpServletResponse response, List<MaterialePiese> lista) throws IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Stoc_Piese.pdf");
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Raport Stoc Piese", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);

            String[] headers = {"Denumire", "Cantitate", "Pret Unitar", "Serviciu Asociat"};
            for (String h : headers) table.addCell(new Phrase(h, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));

            for (MaterialePiese m : lista) {
                table.addCell(m.getDenumire());
                table.addCell(String.valueOf(m.getCantitate()));
                table.addCell(String.valueOf(m.getPretUnitar()));
                table.addCell(m.getNumeServiciu() != null ? m.getNumeServiciu() : "-");
            }
            document.add(table);
            document.close();
        } catch (DocumentException e) { e.printStackTrace(); }
    }

    private void exportToExcel(HttpServletResponse response, List<MaterialePiese> lista) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=Stoc_Piese.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Materiale");
            Row header = sheet.createRow(0);
            String[] heads = {"ID", "Denumire", "Cantitate", "Pret", "Serviciu"};
            for(int i=0; i<heads.length; i++) header.createCell(i).setCellValue(heads[i]);

            int rowIdx = 1;
            for (MaterialePiese m : lista) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(m.getIdMat());
                row.createCell(1).setCellValue(m.getDenumire());
                row.createCell(2).setCellValue(m.getCantitate());
                row.createCell(3).setCellValue(m.getPretUnitar());
                row.createCell(4).setCellValue(m.getNumeServiciu());
            }
            try (OutputStream out = response.getOutputStream()) { workbook.write(out); }
        }
    }
}