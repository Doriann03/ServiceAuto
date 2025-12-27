package ro.serviceauto.serviceauto.servlet;

import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/admin-export-clienti")
public class AdminExportClientiServlet extends HttpServlet {

    private ClientDAO clientDAO;

    public void init() {
        clientDAO = new ClientDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Verificam Admin
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String type = request.getParameter("type");
        List<Client> listaClienti = clientDAO.getAllClients();

        if ("pdf".equals(type)) {
            exportToPDF(response, listaClienti);
        } else if ("excel".equals(type)) {
            exportToExcel(response, listaClienti);
        }
    }

    // --- METODA EXPORT PDF ---
    private void exportToPDF(HttpServletResponse response, List<Client> lista) throws IOException {
        // Setam tipul fisierului pentru browser
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=Raport_Clienti.pdf");

        try {
            Document document = new Document();
            PdfWriter.getInstance(document, response.getOutputStream());

            document.open();

            // Titlu
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.BLACK);
            Paragraph title = new Paragraph("Raport Clienți - Service Auto", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingAfter(20);
            document.add(title);

            // Tabel cu 6 coloane
            PdfPTable table = new PdfPTable(6);
            table.setWidthPercentage(100);

            // Header Tabel
            String[] headers = {"ID", "Nume", "Prenume", "Telefon", "Email", "Username"};
            for (String h : headers) {
                table.addCell(new Phrase(h, FontFactory.getFont(FontFactory.HELVETICA_BOLD)));
            }

            // Date Tabel
            for (Client c : lista) {
                table.addCell(String.valueOf(c.getIdc()));
                table.addCell(c.getNume());
                table.addCell(c.getPrenume());
                table.addCell(c.getTelefon());
                table.addCell(c.getEmail());
                table.addCell(c.getUsername());
            }

            document.add(table);
            document.close();

        } catch (DocumentException e) {
            e.printStackTrace();
        }
    }

    // --- METODA EXPORT EXCEL ---
    private void exportToExcel(HttpServletResponse response, List<Client> lista) throws IOException {
        // Setam tipul fisierului
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=Raport_Clienti.xlsx");

        try (Workbook workbook = new XSSFWorkbook()) { // Creaza fisier Excel nou
            Sheet sheet = workbook.createSheet("Clienti");

            // Randul de Header (Antet)
            Row headerRow = sheet.createRow(0);
            String[] headers = {"ID", "Nume", "Prenume", "Telefon", "Email", "Username", "Rol"};
            for (int i = 0; i < headers.length; i++) {
                headerRow.createCell(i).setCellValue(headers[i]);
            }

            // Randurile de date
            int rowNum = 1;
            for (Client c : lista) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(c.getIdc());
                row.createCell(1).setCellValue(c.getNume());
                row.createCell(2).setCellValue(c.getPrenume());
                row.createCell(3).setCellValue(c.getTelefon());
                row.createCell(4).setCellValue(c.getEmail());
                row.createCell(5).setCellValue(c.getUsername());
                row.createCell(6).setCellValue(c.getTipUtilizator());
            }

            // Auto-size coloane (sa se vada textul bine)
            for (int i = 0; i < headers.length; i++) {
                sheet.autoSizeColumn(i);
            }

            // Scriem in output-ul browserului
            try (OutputStream out = response.getOutputStream()) {
                workbook.write(out);
            }
        }
    }
}