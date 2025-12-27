package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.AtelierDAO;
import ro.serviceauto.serviceauto.model.Atelier;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-ateliere")
public class AdminAteliereServlet extends HttpServlet {
    private AtelierDAO atelierDAO;
    public void init() { atelierDAO = new AtelierDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        String dir = request.getParameter("dir");

        if (sort == null) sort = "nume";
        if (dir == null) dir = "ASC";

        List<Atelier> lista;
        if (search != null && !search.trim().isEmpty()) {
            lista = atelierDAO.searchAteliere(search);
        } else {
            lista = atelierDAO.getAllAteliereSorted(sort, dir);
        }

        request.setAttribute("listaAteliere", lista);
        request.setAttribute("currentSort", sort);
        request.setAttribute("currentDir", dir);

        request.getRequestDispatcher("ateliere_admin.jsp").forward(request, response);
    }
}