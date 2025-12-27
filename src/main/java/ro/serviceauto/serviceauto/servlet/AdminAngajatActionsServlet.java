package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.AngajatDAO;
import ro.serviceauto.serviceauto.dao.IstoricDAO;
import ro.serviceauto.serviceauto.model.Angajat;
import ro.serviceauto.serviceauto.model.Atelier;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-angajat-actions")
public class AdminAngajatActionsServlet extends HttpServlet {
    private AngajatDAO angajatDAO;
    private IstoricDAO istoricDAO;

    public void init() {
        angajatDAO = new AngajatDAO();
        istoricDAO = new IstoricDAO();
    }

    // GET: Pregatire formular sau Stergere
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // --- 1. SECURITATE & PRELUARE ADMIN ---
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }
        String numeAdmin = admin.getNume() + " " + admin.getPrenume();
        // ----------------------------------------

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("delete".equals(action) && idStr != null) {
            int idAngajat = Integer.parseInt(idStr);

            // Preluam angajatul inainte sa il stergem, ca sa ii scriem numele in log
            Angajat a = angajatDAO.getAngajatById(idAngajat);
            String infoAngajat = (a != null) ? a.getNume() + " " + a.getPrenume() : "ID " + idAngajat;

            // Executam stergerea
            angajatDAO.deleteAngajat(idAngajat);

            // --- 2. LOGARE STERGERE ---
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin, "SQL: DELETE | Șters Angajat: " + infoAngajat);

            response.sendRedirect("admin-angajati");
        }
        else if ("edit".equals(action) || "new".equals(action)) {
            // Avem nevoie de lista de ateliere pt Dropdown
            List<Atelier> ateliere = angajatDAO.getAllAteliere();
            request.setAttribute("listaAteliere", ateliere);

            if ("edit".equals(action) && idStr != null) {
                Angajat a = angajatDAO.getAngajatById(Integer.parseInt(idStr));
                request.setAttribute("angajatDeEditat", a);
            }
            request.getRequestDispatcher("form_angajat.jsp").forward(request, response);
        }
    }

    // POST: Salvare
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // --- 1. SECURITATE & PRELUARE ADMIN ---
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }
        String numeAdmin = admin.getNume() + " " + admin.getPrenume();
        // ----------------------------------------

        String idStr = request.getParameter("id");

        Angajat a = new Angajat();
        a.setNume(request.getParameter("nume"));
        a.setPrenume(request.getParameter("prenume"));
        a.setFunctie(request.getParameter("functie"));

        // Verificam daca 'ida' vine corect (pentru siguranta)
        String idaStr = request.getParameter("ida");
        if (idaStr != null && !idaStr.isEmpty()) {
            a.setIda(Integer.parseInt(idaStr));
        }

        if (idStr == null || idStr.isEmpty()) {
            // INSERT
            angajatDAO.addAngajat(a);

            // --- 3. LOGARE ADAUGARE ---
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin,
                    "SQL: INSERT | Angajat nou: " + a.getNume() + " " + a.getPrenume() + " (" + a.getFunctie() + ")");

        } else {
            // UPDATE
            a.setIdAngajat(Integer.parseInt(idStr));
            angajatDAO.updateAngajat(a);

            // --- 4. LOGARE MODIFICARE ---
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin,
                    "SQL: UPDATE | Modificat Angajat ID " + idStr + ": " + a.getNume() + " " + a.getPrenume());
        }
        response.sendRedirect("admin-angajati");
    }
}