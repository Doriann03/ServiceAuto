package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ProgramareDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/check-availability")
public class IntervaleOrareServlet extends HttpServlet {

    private ProgramareDAO programareDAO;
    private final String[] ore = {"08:00", "09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"};

    public void init() {
        programareDAO = new ProgramareDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Preluam parametrii trimisi prin JS (AJAX)
        String date = request.getParameter("data");
        String idsStr = request.getParameter("ids");

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        if (date == null || idsStr == null || date.isEmpty() || idsStr.isEmpty()) {
            out.println("<p>Selectați o dată și un serviciu.</p>");
            return;
        }

        int idServiciu = Integer.parseInt(idsStr);

        out.println("<table class='time-table' border='1' cellpadding='8' style='width:100%; border-collapse: collapse;'>");
        out.println("<tr><th>Ora</th><th>Status</th><th>Selectează</th></tr>");

        for (String ora : ore) {
            // Construim string-ul datetime pt DB: "2025-05-30 08:00:00"
            String dateTimeDb = date + " " + ora + ":00";

            String status = programareDAO.checkSlotStatus(idServiciu, dateTimeDb);

            String culoare = "#d4edda"; // Verde (Disponibil)
            String disabled = "";
            String statusText = "Disponibil";

            if ("Ocupat".equals(status)) {
                culoare = "#f8d7da"; // Rosu
                disabled = "disabled";
                statusText = "Ocupat";
            } else if ("In lucru".equals(status)) {
                culoare = "#fff3cd"; // Portocaliu
                disabled = "disabled";
                statusText = "În lucru";
            }

            out.println("<tr style='background-color:" + culoare + "'>");
            out.println("<td>" + ora + "</td>");
            out.println("<td>" + statusText + "</td>");
            out.println("<td>");

            if (!disabled.isEmpty()) {
                out.println("<input type='radio' disabled>");
            } else {
                // Valoarea trimisa va fi data completa: YYYY-MM-DD HH:mm:00
                out.println("<input type='radio' name='dataProg' value='" + dateTimeDb + "' required>");
            }

            out.println("</td></tr>");
        }
        out.println("</table>");
    }
}