package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ServiciuDAO;
import ro.serviceauto.serviceauto.model.Serviciu;
import ro.serviceauto.serviceauto.model.Atelier;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-serviciu-actions")
public class AdminServiciuActionsServlet extends HttpServlet {
    private ServiciuDAO serviciuDAO;
    public void init() { serviciuDAO = new ServiciuDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("delete".equals(action)) {
            serviciuDAO.deleteServiciu(Integer.parseInt(idStr));
            response.sendRedirect("admin-servicii");
        }
        else if ("edit".equals(action) || "new".equals(action)) {
            List<Atelier> ateliere = serviciuDAO.getAllAteliere();
            request.setAttribute("listaAteliere", ateliere);

            if ("edit".equals(action) && idStr != null) {
                Serviciu s = serviciuDAO.getServiciuById(Integer.parseInt(idStr));
                request.setAttribute("serviciuDeEditat", s);
            }
            request.getRequestDispatcher("form_serviciu.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("id");

        Serviciu s = new Serviciu();
        s.setNume(request.getParameter("nume"));
        s.setDescriere(request.getParameter("descriere"));
        s.setDurataEstimata(Integer.parseInt(request.getParameter("durata")));
        s.setIda(Integer.parseInt(request.getParameter("ida")));

        if (idStr == null || idStr.isEmpty()) {
            serviciuDAO.addServiciu(s);
        } else {
            s.setIds(Integer.parseInt(idStr));
            serviciuDAO.updateServiciu(s);
        }
        response.sendRedirect("admin-servicii");
    }
}