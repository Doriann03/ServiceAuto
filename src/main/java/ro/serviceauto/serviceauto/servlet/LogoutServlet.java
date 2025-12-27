package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.IstoricDAO;
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Luam sesiunea curenta, daca exista
        HttpSession session = request.getSession(false);

        if (session != null) {
            // 1. Luam userul INAINTE sa distrugem sesiunea, ca sa stim cine pleaca
            Client user = (Client) session.getAttribute("user");

            // 2. LOGARE IN ISTORIC (Doar pentru Admini)
            if (user != null && "Admin".equals(user.getTipUtilizator())) {
                IstoricDAO istoricDAO = new IstoricDAO();
                String numeComplet = user.getNume() + " " + user.getPrenume();

                // Scriem in baza de date
                istoricDAO.logAdminAction(user.getIdc(), numeComplet, "LOGOUT | Deconectare Admin");
            }

            // 3. DISTRUGEM SESIUNEA (Aici se sterge userul din memoria serverului)
            session.invalidate();
        }

        // 4. Trimitem userul la pagina de login
        response.sendRedirect("login.jsp");
    }
}