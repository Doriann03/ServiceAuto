package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.util.PasswordUtil; // IMPORT IMPORTANT
import ro.serviceauto.serviceauto.dao.IstoricDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private ClientDAO clientDAO;
    private IstoricDAO istoricDAO;

    public void init() {
        clientDAO = new ClientDAO();
        istoricDAO = new IstoricDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String userOrEmail = request.getParameter("username"); // Poate fi si email
        String passPlain = request.getParameter("password");

        //CRIPTAM parola venita din formular
        String hashedPassword = PasswordUtil.hashPassword(passPlain);

        //Trimitem parola criptata la DAO
        Client client = clientDAO.authenticate(userOrEmail, hashedPassword);

        if (client != null) {
            // Login reusit
            HttpSession session = request.getSession();
            session.setAttribute("user", client);

            // Construim numele complet pentru log
            String numeComplet = client.getNume() + " " + client.getPrenume();

            if ("Admin".equals(client.getTipUtilizator())) {
                istoricDAO.logAdminAction(client.getIdc(), numeComplet, "LOGIN | Autentificare Admin reușită");
                response.sendRedirect("dashboard_admin.jsp");
            } else {
                istoricDAO.logClientAction(client.getIdc(), numeComplet, "LOGIN | Client autentificat");
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