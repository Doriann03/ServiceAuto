package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ServiciuDAO;
import ro.serviceauto.serviceauto.dao.IstoricDAO;
import ro.serviceauto.serviceauto.model.Serviciu;
import ro.serviceauto.serviceauto.model.Atelier;
import ro.serviceauto.serviceauto.model.Client;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-serviciu-actions")
public class AdminServiciuActionsServlet extends HttpServlet {
    private ServiciuDAO serviciuDAO;
    private IstoricDAO istoricDAO;

    public void init() {
        serviciuDAO = new ServiciuDAO();
        istoricDAO = new IstoricDAO();
    }

    // doGet: PREGATIRE (Afisare Formular sau Stergere)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Securitate & Preluare Admin
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        // Construim numele complet pentru logare
        String numeAdmin = admin.getNume() + " " + admin.getPrenume();

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        // --- LOGICA DE STERGERE ---
        if ("delete".equals(action) && idStr != null) {
            int id = Integer.parseInt(idStr);

            // Preluam datele vechi pentru Log
            Serviciu s = serviciuDAO.getServiciuById(id);
            String numeServiciu = (s != null) ? s.getNume() : "ID " + id;

            // Executam stergerea
            serviciuDAO.deleteServiciu(id);

            // Logam actiunea
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin, "SQL: DELETE | Sters Serviciu: " + numeServiciu);

            response.sendRedirect("admin-servicii");
        }
        // --- LOGICA DE PREGATIRE FORMULAR ---
        else if ("edit".equals(action) || "new".equals(action)) {
            // Trimitem lista de ateliere pentru dropdown
            List<Atelier> ateliere = serviciuDAO.getAllAteliere();
            request.setAttribute("listaAteliere", ateliere);

            // Daca e editare, cautam serviciul si il trimitem in JSP
            if ("edit".equals(action) && idStr != null) {
                Serviciu s = serviciuDAO.getServiciuById(Integer.parseInt(idStr));
                request.setAttribute("serviciuDeEditat", s);
            }
            request.getRequestDispatcher("form_serviciu.jsp").forward(request, response);
        }
    }

    // doPost: EXECUTIE (Salvare date)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Securitate & Preluare Admin
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        // 2. Construim numele complet
        String numeAdmin = admin.getNume() + " " + admin.getPrenume();

        String idStr = request.getParameter("id");

        // Construim obiectul Serviciu (FARA PRET)
        Serviciu s = new Serviciu();
        s.setNume(request.getParameter("nume"));
        s.setDescriere(request.getParameter("descriere"));
        s.setDurataEstimata(Integer.parseInt(request.getParameter("durata")));
        s.setIda(Integer.parseInt(request.getParameter("ida"))); // ID Atelier

        // 3. Decidem daca e INSERT sau UPDATE
        if (idStr == null || idStr.isEmpty()) {
            // ADAUGARE
            serviciuDAO.addServiciu(s);

            // Logare corecta (Am scos pretul, am pus durata)
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin,
                    "SQL: INSERT | Serviciu nou: " + s.getNume() + " (Durata: " + s.getDurataEstimata() + " min)");
        } else {
            // UPDATE
            s.setIds(Integer.parseInt(idStr));
            serviciuDAO.updateServiciu(s);

            // Logare corecta
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin,
                    "SQL: UPDATE | Modificat Serviciu ID " + idStr + ": " + s.getNume());
        }
        response.sendRedirect("admin-servicii");
    }
}