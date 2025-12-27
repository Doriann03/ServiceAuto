package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.AngajatDAO;
import ro.serviceauto.serviceauto.model.Angajat;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-angajati")
public class AdminAngajatiServlet extends HttpServlet {
    private AngajatDAO angajatDAO;

    public void init() { angajatDAO = new AngajatDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String search = request.getParameter("search");
        List<Angajat> lista;
        if (search != null && !search.trim().isEmpty()) {
            lista = angajatDAO.searchAngajati(search);
        } else {
            lista = angajatDAO.getAllAngajati();
        }

        request.setAttribute("listaAngajati", lista);
        request.getRequestDispatcher("angajati_admin.jsp").forward(request, response);
    }
}