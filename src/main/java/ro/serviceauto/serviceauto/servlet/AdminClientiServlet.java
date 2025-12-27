package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.model.Client;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-clienti")
public class AdminClientiServlet extends HttpServlet {
    private ClientDAO clientDAO;

    public void init() {
        clientDAO = new ClientDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Securitate Admin
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String search = request.getParameter("search");
        List<Client> lista;

        if (search != null && !search.trim().isEmpty()) {
            lista = clientDAO.searchClients(search); // Filtrare
        } else {
            lista = clientDAO.getAllClients(); // Listare completa
        }

        request.setAttribute("listaClienti", lista);
        request.getRequestDispatcher("clienti_admin.jsp").forward(request, response);
    }
}