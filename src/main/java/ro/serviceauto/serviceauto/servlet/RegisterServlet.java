package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ClientDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.util.PasswordUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private ClientDAO clientDAO;

    public void init() {
        clientDAO = new ClientDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Preluam TOATE datele, inclusiv username
        String nume = request.getParameter("nume");
        String prenume = request.getParameter("prenume");
        String telefon = request.getParameter("telefon");
        String email = request.getParameter("email");
        String username = request.getParameter("username"); // <-- NOU
        String pass = request.getParameter("password");
        String passConfirm = request.getParameter("password_confirm");

        // 2. Validari
        String error = null;

        if (pass == null || !pass.equals(passConfirm)) {
            error = "Parolele nu coincid!";
        }
        else if (clientDAO.isEmailExists(email)) {
            error = "Acest email este deja înregistrat!";
        }
        else if (clientDAO.isUsernameExists(username)) { // <-- NOU: Validare username
            error = "Acest username este deja luat! Alege altul.";
        }

        // 3. Eroare? Intoarcem utilizatorul la formular
        if (error != null) {
            request.setAttribute("errorMessage", error);
            request.setAttribute("oldNume", nume);
            request.setAttribute("oldPrenume", prenume);
            request.setAttribute("oldTel", telefon);
            request.setAttribute("oldEmail", email);
            request.setAttribute("oldUser", username); // <-- NOU: Pastram ce a scris

            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // 4. Salvare
        Client c = new Client();
        c.setNume(nume);
        c.setPrenume(prenume);
        c.setTelefon(telefon);
        c.setEmail(email);
        c.setUsername(username); // <-- NOU: Setam username-ul

        // Criptam parola
        String hashedPassword = PasswordUtil.hashPassword(pass);
        c.setPassword(hashedPassword);

        if (clientDAO.registerClient(c)) {
            response.sendRedirect("login.jsp?success=Cont creat cu succes! Te poti autentifica.");
        } else {
            request.setAttribute("errorMessage", "Eroare la salvare in baza de date.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }
}