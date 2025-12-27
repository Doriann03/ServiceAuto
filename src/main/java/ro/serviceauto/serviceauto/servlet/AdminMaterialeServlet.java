package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.MaterialePieseDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.MaterialePiese;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-materiale")
public class AdminMaterialeServlet extends HttpServlet {
    private MaterialePieseDAO dao;
    public void init() { dao = new MaterialePieseDAO(); }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        String dir = request.getParameter("dir");
        if (sort == null) sort = "denumire";
        if (dir == null) dir = "ASC";

        List<MaterialePiese> lista;
        if (search != null && !search.trim().isEmpty()) {
            lista = dao.searchMateriale(search);
        } else {
            lista = dao.getAllMaterialeSorted(sort, dir);
        }

        request.setAttribute("listaMateriale", lista);
        request.setAttribute("currentSort", sort);
        request.setAttribute("currentDir", dir);
        request.getRequestDispatcher("materiale_admin.jsp").forward(request, response);
    }
}