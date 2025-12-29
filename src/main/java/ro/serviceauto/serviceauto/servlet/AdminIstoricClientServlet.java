package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.IstoricDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.IstoricClient; // Modelul corect

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-istoric-client")
public class AdminIstoricClientServlet extends HttpServlet {
    private IstoricDAO istoricDAO;

    public void init() {
        istoricDAO = new IstoricDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Securitate: Verificam daca e Admin (doar adminul are voie sa vada istoricul clientilor)
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        // 2. Luam datele folosind metoda din DAO
        List<IstoricClient> logs = istoricDAO.getClientLogs();

        // 3. Le trimitem la JSP
        request.setAttribute("listaLogs", logs);
        request.getRequestDispatcher("istoric_client.jsp").forward(request, response);
    }
}