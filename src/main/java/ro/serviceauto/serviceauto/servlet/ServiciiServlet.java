package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ServiciuDAO;
// Importam clasa din sub-pachetul dto
import ro.serviceauto.serviceauto.model.dto.ServiciuAfisare;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/servicii")
public class ServiciiServlet extends HttpServlet {
    private ServiciuDAO serviciuDAO;

    public void init() {
        serviciuDAO = new ServiciuDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        if (session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Aici folosim clasa DTO
        List<ServiciuAfisare> lista = serviciuDAO.getServiciiCuDetaliiAtelier();

        request.setAttribute("listaServicii", lista);
        request.getRequestDispatcher("servicii.jsp").forward(request, response);
    }
}