package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ProgramareDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.dto.IstoricDTO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/istoric")
public class IstoricServlet extends HttpServlet {

    private ProgramareDAO programareDAO;

    public void init() {
        programareDAO = new ProgramareDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificam cine e logat
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Cerem istoricul DOAR pentru acel user (user.getIdc())
        List<IstoricDTO> lista = programareDAO.getIstoricClient(user.getIdc());

        // 3. Trimitem la JSP
        request.setAttribute("listaIstoric", lista);
        request.getRequestDispatcher("istoric.jsp").forward(request, response);
    }
}