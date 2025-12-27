package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ProgramareDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.dto.ProgramareAdminDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-programari")
public class AdminProgramariServlet extends HttpServlet {

    private ProgramareDAO programareDAO;

    public void init() {
        programareDAO = new ProgramareDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");

        // SECURITATE: Verificam daca e ADMIN
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<ProgramareAdminDTO> lista = programareDAO.getAllProgramariAdmin();
        request.setAttribute("listaProgramari", lista);

        request.getRequestDispatcher("programari_admin.jsp").forward(request, response);
    }
}