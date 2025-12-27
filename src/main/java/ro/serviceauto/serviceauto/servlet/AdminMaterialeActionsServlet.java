package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.MaterialePieseDAO;
import ro.serviceauto.serviceauto.model.MaterialePiese;
import ro.serviceauto.serviceauto.model.Serviciu;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-materiale-actions")
public class AdminMaterialeActionsServlet extends HttpServlet {
    private MaterialePieseDAO dao;
    public void init() { dao = new MaterialePieseDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        if ("delete".equals(action)) {
            dao.deleteMaterial(Integer.parseInt(idStr));
            response.sendRedirect("admin-materiale");
        }
        else if ("edit".equals(action) || "new".equals(action)) {
            // Trimitem lista de Servicii pt Dropdown
            List<Serviciu> servicii = dao.getAllServiciiSimple();
            request.setAttribute("listaServicii", servicii);

            if ("edit".equals(action) && idStr != null) {
                MaterialePiese m = dao.getMaterialById(Integer.parseInt(idStr));
                request.setAttribute("materialDeEditat", m);
            }
            request.getRequestDispatcher("form_materiale.jsp").forward(request, response);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String idStr = request.getParameter("id");

        MaterialePiese m = new MaterialePiese();
        m.setDenumire(request.getParameter("denumire"));
        m.setCantitate(Integer.parseInt(request.getParameter("cantitate")));
        m.setPretUnitar(Double.parseDouble(request.getParameter("pretUnitar")));
        m.setIds(Integer.parseInt(request.getParameter("ids")));

        if (idStr == null || idStr.isEmpty()) {
            dao.addMaterial(m);
        } else {
            m.setIdMat(Integer.parseInt(idStr));
            dao.updateMaterial(m);
        }
        response.sendRedirect("admin-materiale");
    }
}