package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.AtelierDAO;
import ro.serviceauto.serviceauto.model.Atelier;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-atelier-actions")
public class AdminAtelierActionsServlet extends HttpServlet {
    private AtelierDAO atelierDAO;
    public void init() { atelierDAO = new AtelierDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("delete".equals(action) && idStr != null) {
            atelierDAO.deleteAtelier(Integer.parseInt(idStr));
            response.sendRedirect("admin-ateliere");
        }
        else if ("edit".equals(action) && idStr != null) {
            Atelier a = atelierDAO.getAtelierById(Integer.parseInt(idStr));
            request.setAttribute("atelierDeEditat", a);
            request.getRequestDispatcher("form_atelier.jsp").forward(request, response);
        }
        else if ("new".equals(action)) {
            request.getRequestDispatcher("form_atelier.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("id");

        Atelier a = new Atelier();
        a.setNume(request.getParameter("nume"));
        a.setAdresa(request.getParameter("adresa"));

        if (idStr == null || idStr.isEmpty()) {
            atelierDAO.addAtelier(a);
        } else {
            a.setIda(Integer.parseInt(idStr));
            atelierDAO.updateAtelier(a);
        }
        response.sendRedirect("admin-ateliere");
    }
}