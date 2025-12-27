package ro.serviceauto.serviceauto.servlet;

import ro.serviceauto.serviceauto.dao.ServiciuDAO;
import ro.serviceauto.serviceauto.model.Client;
import ro.serviceauto.serviceauto.model.Serviciu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin-servicii")
public class AdminServiciiServlet extends HttpServlet {

    private ServiciuDAO serviciuDAO;

    public void init() {
        serviciuDAO = new ServiciuDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Verificare Admin
        HttpSession session = request.getSession();
        Client user = (Client) session.getAttribute("user");
        if (user == null || !"Admin".equals(user.getTipUtilizator())) {
            response.sendRedirect("login.jsp");
            return;
        }

        // 2. Preluam parametrii din URL (Search, Sort, Direction)
        String search = request.getParameter("search");
        String sort = request.getParameter("sort");
        String dir = request.getParameter("dir");

        // 3. Setam valori default pentru sortare (daca nu vin din URL)
        if (sort == null || sort.isEmpty()) sort = "nume";
        if (dir == null || dir.isEmpty()) dir = "ASC";

        List<Serviciu> lista;

        // 4. LOGICA PRINCIPALA: Cautare vs. Sortare
        if (search != null && !search.trim().isEmpty()) {
            // CAZUL A: Utilizatorul a scris ceva in casuta de Search
            // Apelam metoda care filtreaza dupa nume/descriere
            lista = serviciuDAO.searchServicii(search);
        } else {
            // CAZUL B: Nu se cauta nimic, afisam tot tabelul sortat
            // Apelam metoda noua care sorteaza dupa coloana si directie
            lista = serviciuDAO.getAllServiciiSorted(sort, dir);
        }

        // 5. Trimitem datele la JSP
        request.setAttribute("listaServicii", lista);

        // Trimitem inapoi si parametrii de sortare (ca sa stim cum sa desenam sagetile in tabel)
        request.setAttribute("currentSort", sort);
        request.setAttribute("currentDir", dir);

        request.getRequestDispatcher("servicii_admin.jsp").forward(request, response);
    }
}