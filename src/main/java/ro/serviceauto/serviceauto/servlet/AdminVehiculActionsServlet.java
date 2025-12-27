package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.IstoricDAO;
import ro.serviceauto.serviceauto.dao.VehiculDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.Vehicul;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin-vehicul-actions")
public class AdminVehiculActionsServlet extends HttpServlet {
    private VehiculDAO vehiculDAO;
    private IstoricDAO istoricDAO;

    public void init() {
        vehiculDAO = new VehiculDAO();
        istoricDAO = new IstoricDAO();
    }

    // GET: Se ocupa de Stergere (Delete) sau Pregatire formular (New/Edit)
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Verificare securitate (Admin) - DEFINIM VARIABILELE AICI O DATA
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");

        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String idStr = request.getParameter("id");

        // CAZ 1: STERGERE
        if ("delete".equals(action) && idStr != null) {
            int idVehicul = Integer.parseInt(idStr);
            String confirm = request.getParameter("confirm"); // Citim parametrul de confirmare

            // CAZ A: Utilizatorul a confirmat deja sau nu exista dependinte
            if ("true".equals(confirm) || !vehiculDAO.hasDependencies(idVehicul)) {

                // Executam stergerea (in cascada sau simpla, e aceeasi metoda acum)
                boolean deleted = vehiculDAO.deleteVehiculCascade(idVehicul);

                if (deleted) {
                    // --- CORECTIE AICI ---
                    // Nu mai declaram session sau admin, le folosim pe cele de sus
                    istoricDAO.logAdminAction(admin.getIdc(), admin.getNume(), "SQL: DELETE CASCADE | Vehicul ID: " + idVehicul);
                }
                response.sendRedirect("admin-vehicule");
            }
            // CAZ B: Exista dependinte si utilizatorul NU a confirmat inca
            else {
                // Il trimitem la pagina de confirmare
                Vehicul v = vehiculDAO.getVehiculById(idVehicul);
                request.setAttribute("vehiculDeSters", v);
                request.getRequestDispatcher("confirm_delete.jsp").forward(request, response);
            }
        }
        // CAZ 2: PREGATIRE FORMULAR (Nou sau Editare)
        else if ("edit".equals(action) || "new".equals(action)) {
            if ("edit".equals(action) && idStr != null) {
                Vehicul v = vehiculDAO.getVehiculById(Integer.parseInt(idStr));
                request.setAttribute("vehiculDeEditat", v);
            }
            // Nu mai trimitem lista de clienti, vehiculul e independent
            request.getRequestDispatcher("form_vehicul.jsp").forward(request, response);
        }
    }

    // POST: Se ocupa de Salvare (Insert sau Update)
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. Verificare securitate
        HttpSession session = request.getSession();
        Client admin = (Client) session.getAttribute("user");
        if (admin == null || !"Admin".equals(admin.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("id");

        // Construim obiectul Vehicul din datele formularului
        Vehicul v = new Vehicul();
        v.setMarca(request.getParameter("marca"));
        v.setModel(request.getParameter("model"));
        v.setNrInmatriculare(request.getParameter("nrInmatriculare"));
        v.setSerieSasiu(request.getParameter("serieSasiu"));
        v.setTip(request.getParameter("tip"));
        v.setMotor(request.getParameter("motor"));

        String numeAdmin = admin.getNume() + " " + admin.getPrenume();

        if (idStr == null || idStr.isEmpty()) {
            // CAZ: INSERT (Adaugare noua)
            vehiculDAO.addVehicul(v);

            // --- LOGGING ---
            String mesajLog = "SQL: INSERT | Adaugare vehicul: " + v.getMarca() + " " + v.getModel() + " (" + v.getNrInmatriculare() + ")";
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin, mesajLog);

        } else {
            // CAZ: UPDATE (Modificare existenta)
            v.setIdv(Integer.parseInt(idStr));
            vehiculDAO.updateVehicul(v);

            // --- LOGGING ---
            String mesajLog = "SQL: UPDATE | Modificare vehicul ID " + idStr + ": " + v.getNrInmatriculare();
            istoricDAO.logAdminAction(admin.getIdc(), numeAdmin, mesajLog);
        }

        response.sendRedirect("admin-vehicule");
    }
}