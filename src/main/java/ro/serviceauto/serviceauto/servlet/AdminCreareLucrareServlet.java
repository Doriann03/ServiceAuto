package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.AngajatDAO;
import ro.serviceauto.serviceauto.dao.LucrareDAO; // Il facem imediat
import ro.serviceauto.serviceauto.model.Client;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-creare-lucrare")
public class AdminCreareLucrareServlet extends HttpServlet {

    private AngajatDAO angajatDAO;
    private LucrareDAO lucrareDAO; // Urmeaza sa-l facem

    public void init() {
        angajatDAO = new AngajatDAO();
        lucrareDAO = new LucrareDAO();
    }

    // Pasul 1: Afisam formularul de selectie mecanic
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp"); return;
        }

        String idProg = request.getParameter("id");
        request.setAttribute("idProgramare", idProg);
        request.setAttribute("listaMecanici", angajatDAO.getMecanici());

        request.getRequestDispatcher("creare_lucrare.jsp").forward(request, response);
    }

    // Pasul 2: Salvam lucrarea
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int idProgramare = Integer.parseInt(request.getParameter("idProgramare"));
        int idAngajat = Integer.parseInt(request.getParameter("idAngajat"));
        String descriere = request.getParameter("descriere");

        // Aici vom apela lucrareDAO.createLucrare(...)
        // Dar intai sa facem DAO-ul!
        lucrareDAO.creazaLucrareDinProgramare(idProgramare, idAngajat, descriere);

        response.sendRedirect("admin-programari");
    }
}