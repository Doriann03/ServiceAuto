package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.dao.IstoricDAO; // 1. IMPORT NOU
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.util.PasswordUtil; // 2. IMPORT NOU (Pt parola)

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-client-actions")
public class AdminClientActionsServlet extends HttpServlet {
    private ClientDAO clientDAO;
    private IstoricDAO istoricDAO; // 3. DECLARARE DAO ISTORIC

    public void init() {
        clientDAO = new ClientDAO();
        istoricDAO = new IstoricDAO(); // 4. INITIALIZARE DAO ISTORIC
    }

    // doGet: Folosit pentru STERGERE sau pregatirea formularului de EDITARE
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // --- [A] SECURITATE & IDENTIFICARE ADMIN ---
        // Fara asta nu putem scrie in istoric cine a facut actiunea
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }
        String numeAdmin = admin.getNume() + " " + admin.getPrenume();
        // -------------------------------------------

        String action = request.getParameter("action"); // 'delete' sau 'edit'
        String idStr = request.getParameter("id");

        if ("delete".equals(action) && idStr != null) {
            int idClient = Integer.parseInt(idStr);

            // Preluam datele clientului inainte sa il stergem (pentru log)
            Client c = clientDAO.getClientById(idClient);
            String infoClient = (c != null) ? c.getNume() + " " + c.getPrenume() : "ID " + idClient;

            clientDAO.deleteClient(idClient);

            // --- [B] LOGARE STERGERE ---
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin, "SQL: DELETE | Șters Client: " + infoClient);

            response.sendRedirect("admin-clienti");
        }
        else if ("edit".equals(action) && idStr != null) {
            Client c = clientDAO.getClientById(Integer.parseInt(idStr));
            request.setAttribute("clientDeEditat", c);
            request.getRequestDispatcher("form_client.jsp").forward(request, response);
        }
        else if ("new".equals(action)) {
            // Doar trimitem catre formularul gol
            request.getRequestDispatcher("form_client.jsp").forward(request, response);
        }
    }

    // doPost: Folosit pentru SALVARE (Insert sau Update)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // --- [A] SECURITATE & IDENTIFICARE ADMIN ---
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }
        String numeAdmin = admin.getNume() + " " + admin.getPrenume();
        // -------------------------------------------

        String idStr = request.getParameter("id");
        Client c = new Client();
        c.setNume(request.getParameter("nume"));
        c.setPrenume(request.getParameter("prenume"));
        c.setTelefon(request.getParameter("telefon"));
        c.setEmail(request.getParameter("email"));
        c.setUsername(request.getParameter("username"));

        // Tip utilizator vine din form (daca e selectabil) sau e default Client
        String tip = request.getParameter("tipUtilizator");
        c.setTipUtilizator((tip != null && !tip.isEmpty()) ? tip : "Client");

        // Parola (o preluam din form)
        String rawPass = request.getParameter("password");

        if (idStr == null || idStr.isEmpty()) {
            // CAZ 1: INSERT (Client Nou)

            // Trebuie sa criptam parola daca e user nou!
            if (rawPass != null && !rawPass.isEmpty()) {
                c.setPassword(PasswordUtil.hashPassword(rawPass));
            }

            clientDAO.addClient(c);

            // --- [C] LOGARE ADAUGARE ---
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin,
                    "SQL: INSERT | Client nou: " + c.getNume() + " " + c.getPrenume() + " (" + c.getEmail() + ")");

        } else {
            // CAZ 2: UPDATE (Client Existent)
            c.setIdc(Integer.parseInt(idStr));

            // Logica parola la update: Daca adminul a scris ceva in campul parola, o schimbam.
            // Daca a lasat gol, pastram parola veche (aici ar trebui o logica in DAO sa nu o suprascrie cu null).
            // Pentru simplitate acum, presupunem ca daca a scris, o updatam criptata.
            if (rawPass != null && !rawPass.trim().isEmpty()) {
                c.setPassword(PasswordUtil.hashPassword(rawPass));
            } else {
                // Truc: Luam parola veche din baza ca sa nu o stricam (sau modifici DAO sa ignore null)
                Client old = clientDAO.getClientById(c.getIdc());
                c.setPassword(old.getPassword());
            }

            clientDAO.updateClient(c);

            // --- [D] LOGARE MODIFICARE ---
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin,
                    "SQL: UPDATE | Modificat Client ID " + idStr + ": " + c.getNume() + " " + c.getPrenume());
        }

        response.sendRedirect("admin-clienti");
    }
}