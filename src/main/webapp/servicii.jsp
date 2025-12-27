<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.ServiciuAfisare" %>

<!DOCTYPE html>
<html>
<head>
    <title>Servicii Disponibile</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="admin-home">
    <h2>Servicii Disponibile</h2>
    <a href="dashboard_client.jsp" class="btn">⬅ Înapoi la Dashboard</a>
    <br><br>
    <table>
        <thead>
        <tr>
            <th>Denumire Serviciu</th>
            <th>Descriere</th>
            <th>Durată</th>
            <th>Atelier</th>
            <th>Adresă Atelier</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Verificam daca lista exista inainte sa o folosim
            List<ServiciuAfisare> lista = (List<ServiciuAfisare>) request.getAttribute("listaServicii");

            if (lista != null && !lista.isEmpty()) {
                for (ServiciuAfisare s : lista) {
        %>
        <tr>
            <td><%= s.getNumeServiciu() %></td>
            <td><%= s.getDescriere() %></td>
            <td><%= s.getDurata() %> min</td>
            <td><%= s.getNumeAtelier() %></td>
            <td><%= s.getAdresaAtelier() %></td>
        </tr>
        <%  }
        } else { %>
        <tr>
            <td colspan="5" style="text-align:center; color:red;">
                Nu s-au găsit date, deși consola zice că există!
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>