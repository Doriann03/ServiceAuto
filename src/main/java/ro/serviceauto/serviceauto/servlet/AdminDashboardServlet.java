package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.DashboardDAO;
import ro.serviceauto.serviceauto.model.Client;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Map;

// ATENTIE: Mapam acest servlet la /admin-dashboard
@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private DashboardDAO dashboardDAO;

    public void init() {
        dashboardDAO = new DashboardDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Securitate
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Luam datele simple (Carduri)
        int nrClienti = dashboardDAO.getCount("client");
        int nrVehicule = dashboardDAO.getCount("vehicul");
        int nrProgramari = dashboardDAO.getCount("programare");
        int nrLucrari = dashboardDAO.getCount("lucrare"); // Daca ai tabela lucrare

        // 3. Luam datele pentru Grafice
        Map<String, Integer> statsStatus = dashboardDAO.getProgramariPeStatus();
        Map<String, Integer> statsZile = dashboardDAO.getProgramariUltimele7Zile();

        // 4. Pregatim datele pentru JavaScript (String formatat: "10, 5, 3")
        // Pt Status (Placinta)
        String statusLabels = "'Programat', 'În lucru', 'Finalizat'";
        String statusData = statsStatus.getOrDefault("Programat", 0) + "," +
                statsStatus.getOrDefault("In lucru", 0) + "," +
                statsStatus.getOrDefault("Finalizat", 0);

        // Pt Zile (Liniar)
        StringBuilder zileLabels = new StringBuilder();
        StringBuilder zileData = new StringBuilder();
        for (Map.Entry<String, Integer> entry : statsZile.entrySet()) {
            if (zileLabels.length() > 0) { zileLabels.append(","); zileData.append(","); }
            zileLabels.append("'").append(entry.getKey()).append("'");
            zileData.append(entry.getValue());
        }

        // 5. Trimitem totul la JSP
        request.setAttribute("nrClienti", nrClienti);
        request.setAttribute("nrVehicule", nrVehicule);
        request.setAttribute("nrProgramari", nrProgramari);
        request.setAttribute("nrLucrari", nrLucrari);

        request.setAttribute("chartStatusData", statusData);
        request.setAttribute("chartZileLabels", zileLabels.toString());
        request.setAttribute("chartZileData", zileData.toString());

        request.getRequestDispatcher("dashboard_admin.jsp").forward(request, response);
    }
}