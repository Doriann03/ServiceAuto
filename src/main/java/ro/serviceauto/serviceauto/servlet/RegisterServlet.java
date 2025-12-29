package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.dao.IstoricDAO; // 1. IMPORT NOU
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private ClientDAO clientDAO;
    private IstoricDAO istoricDAO; // 2. DECLARARE

    public void init() {
        clientDAO = new ClientDAO();
        istoricDAO = new IstoricDAO(); // 3. INITIALIZARE
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        String nume = request.getParameter("nume");
        String prenume = request.getParameter("prenume");
        String telefon = request.getParameter("telefon");
        String email = request.getParameter("email");
        String username = request.getParameter("username");
        String pass = request.getParameter("password");
        String passConfirm = request.getParameter("password_confirm");

        String error = null;

        if (pass == null || !pass.equals(passConfirm)) {
            error = "Parolele nu coincid!";
        }
        else if (clientDAO.isEmailExists(email)) {
            error = "Acest email este deja înregistrat!";
        }
        else if (clientDAO.isUsernameExists(username)) {
            error = "Acest username este deja luat! Alege altul.";
        }

        if (error != null) {
            request.setAttribute("errorMessage", error);
            request.setAttribute("oldNume", nume);
            request.setAttribute("oldPrenume", prenume);
            request.setAttribute("oldTel", telefon);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldUser", username);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        Client c = new Client();
        c.setNume(nume);
        c.setPrenume(prenume);
        c.setTelefon(telefon);
        c.setEmail(email);
        c.setUsername(username);

        String hashedPassword = PasswordUtil.hashPassword(pass);
        c.setPassword(hashedPassword);

        if (clientDAO.registerClient(c)) {

            // --- 4. LOGARE INREGISTRARE ---
            // Truc: Pentru a afla ID-ul generat, facem o "autentificare" interna rapida
            // sau cautam dupa username. authenticate e sigur ca il avem.
            Client newClient = clientDAO.authenticate(username, hashedPassword);

            if (newClient != null) {
                String numeComplet = newClient.getNume() + " " + newClient.getPrenume();
                istoricDAO.logClientAction(newClient.getIdc(), numeComplet, "REGISTER | Cont nou creat");
            }

            response.sendRedirect("login.jsp?success=Cont creat cu succes! Te poti autentifica.");
        } else {
            request.setAttribute("errorMessage", "Eroare la salvare in baza de date.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}