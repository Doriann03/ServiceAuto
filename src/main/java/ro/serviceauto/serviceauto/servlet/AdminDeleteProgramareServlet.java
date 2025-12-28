package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.IstoricDAO; // 1. IMPORT NOU
import ro.serviceauto.serviceauto.dao.ProgramareDAO;
import ro.serviceauto.serviceauto.model.Client;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-delete-programare")
public class AdminDeleteProgramareServlet extends HttpServlet {
    private ProgramareDAO programareDAO;
    private IstoricDAO istoricDAO; // 2. DECLARARE

    public void init() {
        programareDAO = new ProgramareDAO();
        istoricDAO = new IstoricDAO(); // 3. INITIALIZARE
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

        // 4. PREGATIRE NUME ADMIN (Il luam acum ca sa il folosim jos)
        String numeAdmin = user.getNume() + " " + user.getPrenume();

        // 2. Luam ID-ul din URL
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);

            // Executam stergerea
            programareDAO.deleteProgramare(id);

            // 5. LOGARE STERGERE
            istoricDAO.logAdminAction(user.getIdc(), numeAdmin,
                    "SQL: DELETE | Șters Programarea ID: " + id);
        }

        // 3. Ne intoarcem la tabel
        response.sendRedirect("admin-programari");
    }
}