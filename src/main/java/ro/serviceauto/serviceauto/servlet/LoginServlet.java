package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.util.PasswordUtil; // IMPORT IMPORTANT

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private ClientDAO clientDAO;

    public void init() {
        clientDAO = new ClientDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userOrEmail = request.getParameter("username"); // Poate fi si email
        String passPlain = request.getParameter("password");

        // 1. CRIPTAM parola venita din formular
        String hashedPassword = PasswordUtil.hashPassword(passPlain);

        // 2. Trimitem parola criptata la DAO
        Client client = clientDAO.authenticate(userOrEmail, hashedPassword);

        if (client != null) {
            // Login reusit
            HttpSession session = request.getSession();
            session.setAttribute("user", client);

            if ("Admin".equals(client.getTipUtilizator())) {
                response.sendRedirect("dashboard_admin.jsp");
            } else {
                response.sendRedirect("dashboard_client.jsp");
            }
        } else {
            // Login esuat
            request.setAttribute("error", "Email/Username sau parola incorecte!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

    // Pentru a putea vedea pagina de login daca cineva da GET
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}