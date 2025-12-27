package ro.serviceauto.serviceauto.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ro.serviceauto.serviceauto.dao.VehiculDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.Vehicul;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/admin-export-vehicule")
public class AdminExportVehiculeServlet extends HttpServlet {
    private VehiculDAO vehiculDAO;
    public void init() { vehiculDAO = new VehiculDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String type = request.getParameter("type");
        List<Vehicul> lista = vehiculDAO.getAllVehiculeAdmin();

        if ("pdf".equals(type)) exportToPDF(response, lista);
        else if ("excel".equals(type)) exportToExcel(response, lista);
    }

    private void exportToPDF(HttpServletResponse response, List<Vehicul> lista) throws IOException {
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Raport_Vehicule.pdf");
        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            document.add(new Paragraph("Raport Vehicule", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18)));
            document.add(new Paragraph(" "));

            PdfPTable table = new PdfPTable(5); // 5 Coloane
            table.setWidthPercentage(100);

            String[] headers = {"Marca", "Model", "Nr. Inmatriculare", "Serie Sasiu", "Motor"};
            for (String h : headers) table.addCell(new Phrase(h, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));

            for (Vehicul v : lista) {
                table.addCell(v.getMarca());
                table.addCell(v.getModel());
                table.addCell(v.getNrInmatriculare());
                table.addCell(v.getSerieSasiu());
                table.addCell(v.getMotor());
            }
            document.add(table);
            document.close();
        } catch (DocumentException e) { e.printStackTrace(); }
    }

    private void exportToExcel(HttpServletResponse response, List<Vehicul> lista) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=Raport_Vehicule.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Vehicule");
            Row header = sheet.createRow(0);
            String[] heads = {"ID", "Marca", "Model", "Numar", "Sasiu", "Tip", "Motor"};
            for(int i=0; i<heads.length; i++) header.createCell(i).setCellValue(heads[i]);

            int rowIdx = 1;
            for (Vehicul v : lista) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(v.getIdv());
                row.createCell(1).setCellValue(v.getMarca());
                row.createCell(2).setCellValue(v.getModel());
                row.createCell(3).setCellValue(v.getNrInmatriculare());
                row.createCell(4).setCellValue(v.getSerieSasiu());
                row.createCell(5).setCellValue(v.getTip());
                row.createCell(6).setCellValue(v.getMotor());
            }
            try (OutputStream out = response.getOutputStream()) { workbook.write(out); }
        }
    }
}