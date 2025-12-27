package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.model.Client;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-client-actions")
public class AdminClientActionsServlet extends HttpServlet {
    private ClientDAO clientDAO;

    public void init() {
        clientDAO = new ClientDAO();
    }

    // doGet: Folosit pentru STERGERE sau pregatirea formularului de EDITARE
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action"); // 'delete' sau 'edit'
        String idStr = request.getParameter("id");

        if ("delete".equals(action) && idStr != null) {
            clientDAO.deleteClient(Integer.parseInt(idStr));
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

        String idStr = request.getParameter("id");
        Client c = new Client();
        c.setNume(request.getParameter("nume"));
        c.setPrenume(request.getParameter("prenume"));
        c.setTelefon(request.getParameter("telefon"));
        c.setEmail(request.getParameter("email"));
        c.setUsername(request.getParameter("username"));
        c.setTipUtilizator(request.getParameter("tipUtilizator"));

        // Parola o luam doar daca e user nou (sau putem implementa logica de schimbare parola)
        c.setPassword(request.getParameter("password"));

        if (idStr == null || idStr.isEmpty()) {
            // INSERT (Client Nou)
            clientDAO.addClient(c);
        } else {
            // UPDATE (Client Existent)
            c.setIdc(Integer.parseInt(idStr));
            clientDAO.updateClient(c);
        }

        response.sendRedirect("admin-clienti");
    }
}