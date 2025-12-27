package ro.serviceauto.serviceauto.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ro.serviceauto.serviceauto.dao.ServiciuDAO;
import ro.serviceauto.serviceauto.model.Serviciu;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/admin-export-servicii")
public class AdminExportServiciiServlet extends HttpServlet {
    private ServiciuDAO serviciuDAO;
    public void init() { serviciuDAO = new ServiciuDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String type = request.getParameter("type");
        List<Serviciu> lista = serviciuDAO.getAllServiciiAdmin();

        if ("pdf".equals(type)) exportToPDF(response, lista);
        else if ("excel".equals(type)) exportToExcel(response, lista);
    }

    private void exportToPDF(HttpServletResponse response, List<Serviciu> lista) throws IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Raport_Servicii.pdf");
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Raport Servicii - Service Auto", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
            document.add(new Paragraph(" ")); // Spatiu

            PdfPTable table = new PdfPTable(4);
            table.setWidthPercentage(100);

            String[] headers = {"ID", "Denumire", "Durata (min)", "Atelier"};
            for (String h : headers) table.addCell(new Phrase(h, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));

            for (Serviciu s : lista) {
                table.addCell(String.valueOf(s.getIds()));
                table.addCell(s.getNume());
                table.addCell(String.valueOf(s.getDurataEstimata()));
                table.addCell(s.getNumeAtelier() != null ? s.getNumeAtelier() : "-");
            }
            document.add(table);
            document.close();
        } catch (DocumentException e) { e.printStackTrace(); }
    }

    private void exportToExcel(HttpServletResponse response, List<Serviciu> lista) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=Raport_Servicii.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Servicii");
            Row header = sheet.createRow(0);
            String[] heads = {"ID", "Denumire", "Descriere", "Durata", "Atelier"};
            for(int i=0; i<heads.length; i++) header.createCell(i).setCellValue(heads[i]);

            int rowIdx = 1;
            for (Serviciu s : lista) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(s.getIds());
                row.createCell(1).setCellValue(s.getNume());
                row.createCell(2).setCellValue(s.getDescriere());
                row.createCell(3).setCellValue(s.getDurataEstimata());
                row.createCell(4).setCellValue(s.getNumeAtelier());
            }
            try (OutputStream out = response.getOutputStream()) { workbook.write(out); }
        }
    }
}