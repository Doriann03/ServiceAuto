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
            // Luam userul INAINTE sa distrugem sesiunea, ca sa stim cine pleaca
            Client user = (Client) session.getAttribute("user");

            // LOGARE IN ISTORIC (Doar pentru Admini)
            if (user != null) {
                IstoricDAO istoricDAO = new IstoricDAO();
                String numeComplet = user.getNume() + " " + user.getPrenume();

                if ("Admin".equals(user.getTipUtilizator())) {
                    istoricDAO.logAdminAction(user.getIdc(), numeComplet, "LOGOUT | Deconectare Admin");
                } else {
                    // Logare Client
                    istoricDAO.logClientAction(user.getIdc(), numeComplet, "LOGOUT | Deconectare Client");
                }
            }

            // DISTRUGEM SESIUNEA (Aici se sterge userul din memoria serverului)
            session.invalidate();
        }

        // Trimitem userul la pagina de login
        response.sendRedirect("login.jsp");
    }
}