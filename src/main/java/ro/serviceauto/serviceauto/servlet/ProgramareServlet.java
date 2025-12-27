package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ProgramareDAO;
import ro.serviceauto.serviceauto.dao.ServiciuDAO;
import ro.serviceauto.serviceauto.dao.VehiculDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.Vehicul;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/programare")
public class ProgramareServlet extends HttpServlet {

    private VehiculDAO vehiculDAO;
    private ServiciuDAO serviciuDAO;
    private ProgramareDAO programareDAO;

    public void init() {
        vehiculDAO = new VehiculDAO();
        serviciuDAO = new ServiciuDAO();
        programareDAO = new ProgramareDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Modificare: Aducem doar vehiculele clientului!
        request.setAttribute("listaVehicule", vehiculDAO.getVehiclesByClient(user.getIdc()));
        request.setAttribute("listaServicii", serviciuDAO.getAllServices());

        request.getRequestDispatcher("programare.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null) { response.sendRedirect("login.jsp"); return; }

        int idVehiculFinal = 0;
        String tipSelectie = request.getParameter("vehicleOption"); // "existing" sau "new"

        if ("new".equals(tipSelectie)) {
            // A. Cazul Vehicul Nou: Il citim si il salvam
            Vehicul v = new Vehicul();
            v.setMarca(request.getParameter("marca"));
            v.setModel(request.getParameter("model"));
            v.setNrInmatriculare(request.getParameter("nrInmatriculare"));
            v.setSerieSasiu(request.getParameter("serieSasiu"));
            v.setTip(request.getParameter("tip"));
            v.setMotor(request.getParameter("motor"));

            // Il inseram si primim ID-ul
            idVehiculFinal = vehiculDAO.insertVehicle(v);
        } else {
            // B. Cazul Vehicul Existent
            idVehiculFinal = Integer.parseInt(request.getParameter("vehiculID"));
        }

        int idServiciu = Integer.parseInt(request.getParameter("serviciuID"));
        String dataProg = request.getParameter("dataProg"); // Vine din radio button (AJAX)

        if (idVehiculFinal > 0) {
            boolean saved = programareDAO.createProgramare(user.getIdc(), idVehiculFinal, idServiciu, dataProg);
            if (saved) {
                response.sendRedirect("dashboard_client.jsp?msg=succes");
            } else {
                request.setAttribute("error", "Eroare la salvare.");
                doGet(request, response);
            }
        } else {
            request.setAttribute("error", "Eroare la procesarea vehiculului.");
            doGet(request, response);
        }
    }
}