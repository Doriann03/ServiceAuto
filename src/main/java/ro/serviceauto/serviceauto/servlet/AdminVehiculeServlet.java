package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.VehiculDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.Vehicul;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-vehicule")
public class AdminVehiculeServlet extends HttpServlet {

    private VehiculDAO vehiculDAO;

    public void init() {
        vehiculDAO = new VehiculDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificare Securitate: Doar Adminii au acces
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Preluare Parametri din URL (Search, Sort, Direction)
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        String dir = request.getParameter("dir");

        // 3. Setare valori implicite (Default)
        // Daca nu se specifica sortarea, sortam dupa 'marca' crescator
        if (sort == null || sort.isEmpty()) sort = "marca";
        if (dir == null || dir.isEmpty()) dir = "ASC";

        List<Vehicul> lista;

        // 4. Logica de afisare
        if (search != null && !search.trim().isEmpty()) {
            // CAZ A: Utilizatorul a scris ceva in search -> Cautam
            lista = vehiculDAO.searchVehicule(search);
        } else {
            // CAZ B: Utilizatorul vrea lista completa -> Afisam sortat
            lista = vehiculDAO.getAllVehiculeSorted(sort, dir);
        }

        // 5. Trimitem datele catre JSP
        request.setAttribute("listaVehicule", lista);

        // Trimitem inapoi si parametrii de sortare (ca sa stim cum punem sagetile in tabel)
        request.setAttribute("currentSort", sort);
        request.setAttribute("currentDir", dir);

        // 6. Randare pagina
        request.getRequestDispatcher("vehicule_admin.jsp").forward(request, response);
    }
}