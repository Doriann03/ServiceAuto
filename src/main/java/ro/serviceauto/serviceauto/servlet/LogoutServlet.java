package ro.serviceauto.serviceauto.servlet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Luam sesiunea daca exista
        if (session != null) {
            session.invalidate(); // O distrugem (stergem userul logat)
        }

        // Redirect catre pagina de login
        response.sendRedirect("login.jsp");
    }
}