package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.AngajatDAO;
import ro.serviceauto.serviceauto.model.Angajat;
import ro.serviceauto.serviceauto.model.Atelier;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-angajat-actions")
public class AdminAngajatActionsServlet extends HttpServlet {
    private AngajatDAO angajatDAO;

    public void init() { angajatDAO = new AngajatDAO(); }

    // GET: Pregatire formular sau Stergere
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("delete".equals(action) && idStr != null) {
            angajatDAO.deleteAngajat(Integer.parseInt(idStr));
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
        String idStr = request.getParameter("id");

        Angajat a = new Angajat();
        a.setNume(request.getParameter("nume"));
        a.setPrenume(request.getParameter("prenume"));
        a.setFunctie(request.getParameter("functie"));
        a.setIda(Integer.parseInt(request.getParameter("ida"))); // ID Atelier din Dropdown

        if (idStr == null || idStr.isEmpty()) {
            angajatDAO.addAngajat(a);
        } else {
            a.setIdAngajat(Integer.parseInt(idStr));
            angajatDAO.updateAngajat(a);
        }
        response.sendRedirect("admin-angajati");
    }
}