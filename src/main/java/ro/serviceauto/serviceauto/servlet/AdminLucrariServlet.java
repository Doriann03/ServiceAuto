package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.IstoricDAO; // 1. IMPORT NOU
import ro.serviceauto.serviceauto.dao.LucrareDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.dto.LucrareAdminDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-lucrari")
public class AdminLucrariServlet extends HttpServlet {

    private LucrareDAO lucrareDAO;
    private IstoricDAO istoricDAO; // 2. DECLARARE

    public void init() {
        lucrareDAO = new LucrareDAO();
        istoricDAO = new IstoricDAO(); // 3. INITIALIZARE
    }

    // Afisare Lista
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        List<LucrareAdminDTO> lista = lucrareDAO.getAllLucrari();
        request.setAttribute("listaLucrari", lista);
        request.getRequestDispatcher("lucrari_admin.jsp").forward(request, response);
    }

    // Finalizare Lucrare (POST) - AICI INTERVENIM
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 4. SECURITATE & IDENTIFICARE ADMIN (DoPost nu avea verificare, am adaugat-o)
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }
        String numeAdmin = user.getNume() + " " + user.getPrenume();

        // Preluam datele din formularul mic de finalizare
        int idLucrare = Integer.parseInt(request.getParameter("idLucrare"));
        double pret = Double.parseDouble(request.getParameter("pretFinal"));

        // Executam finalizarea
        lucrareDAO.finalizeazaLucrare(idLucrare, pret);

        // 5. LOGARE FINALIZARE
        istoricDAO.logAdminAction(user.getIdc(), numeAdmin,
                "WORKFLOW | Finalizat Lucrare ID: " + idLucrare + " (Pret total: " + pret + " RON)");

        response.sendRedirect("admin-lucrari"); // Refresh la pagina
    }
}