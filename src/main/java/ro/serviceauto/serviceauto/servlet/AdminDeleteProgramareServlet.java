package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ProgramareDAO;
import ro.serviceauto.serviceauto.model.Client;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-delete-programare")
public class AdminDeleteProgramareServlet extends HttpServlet {
    private ProgramareDAO programareDAO;

    public void init() {
        programareDAO = new ProgramareDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Securitate Admin
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Luam ID-ul din URL
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            programareDAO.deleteProgramare(id);
        }

        // 3. Ne intoarcem la tabel
        response.sendRedirect("admin-programari");
    }
}