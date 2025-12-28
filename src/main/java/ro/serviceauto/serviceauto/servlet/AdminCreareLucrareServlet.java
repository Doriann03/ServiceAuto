package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.AngajatDAO;
import ro.serviceauto.serviceauto.dao.IstoricDAO; // 1. IMPORT NOU
import ro.serviceauto.serviceauto.dao.LucrareDAO;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-creare-lucrare")
public class AdminCreareLucrareServlet extends HttpServlet {

    private AngajatDAO angajatDAO;
    private LucrareDAO lucrareDAO;
    private IstoricDAO istoricDAO; // 2. DECLARARE

    public void init() {
        angajatDAO = new AngajatDAO();
        lucrareDAO = new LucrareDAO();
        istoricDAO = new IstoricDAO(); // 3. INITIALIZARE
    }

    // Pasul 1: Afisam formularul de selectie mecanic (Aici nu modificam nimic, doar afisam)
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String idProg = request.getParameter("id");
        request.setAttribute("idProgramare", idProg);
        request.setAttribute("listaMecanici", angajatDAO.getMecanici());

        request.getRequestDispatcher("creare_lucrare.jsp").forward(request, response);
    }

    // Pasul 2: Salvam lucrarea (AICI ESTE ACTIUNEA)
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 4. SECURITATE ADMIN (Trebuie adaugata si la doPost pt a sti cine face actiunea)
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }
        String numeAdmin = user.getNume() + " " + user.getPrenume();

        int idProgramare = Integer.parseInt(request.getParameter("idProgramare"));
        int idAngajat = Integer.parseInt(request.getParameter("idAngajat"));
        String descriere = request.getParameter("descriere");

        // Executam crearea lucrarii
        lucrareDAO.creazaLucrareDinProgramare(idProgramare, idAngajat, descriere);

        // 5. LOGARE START LUCRARE
        istoricDAO.logAdminAction(user.getIdc(), numeAdmin,
                "WORKFLOW | Început lucrare la Programarea ID: " + idProgramare + " (Mecanic ID: " + idAngajat + ")");

        response.sendRedirect("admin-programari");
    }
}