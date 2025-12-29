package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.IstoricDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.IstoricAdmin; // Folosim clasa ta

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-istoric")
public class AdminIstoricAdminServlet extends HttpServlet {
    private IstoricDAO istoricDAO;

    public void init() {
        istoricDAO = new IstoricDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Securitate: Verificam daca e Admin
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        // 2. Luam datele folosind metoda ta existenta
        List<IstoricAdmin> logs = istoricDAO.getAdminLogs();

        // 3. Le trimitem la JSP
        request.setAttribute("listaLogs", logs);
        request.getRequestDispatcher("istoric_admin.jsp").forward(request, response);
    }
}