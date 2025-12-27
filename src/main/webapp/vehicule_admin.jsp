<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // 1. SECURITATE
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // 2. LOGICA DE SORTARE
    String currentSort = (String) request.getAttribute("currentSort");
    String currentDir = (String) request.getAttribute("currentDir");

    // Definim functia pentru link-uri de sortare
    java.util.function.BiFunction<String, String, String> getSortLink = (colName, label) -> {
        String newDir = "ASC";
        String arrow = "";

        // Verificam daca sortam deja dupa coloana asta
        if (colName.equals(currentSort)) {
            if ("ASC".equals(currentDir)) {
                newDir = "DESC";
                arrow = " 🔼";
            } else {
                newDir = "ASC";
                arrow = " 🔽";
            }
        }
        return "<a href='admin-vehicule?sort=" + colName + "&dir=" + newDir + "' style='color:white; text-decoration:none;'>" + label + arrow + "</a>";
    };
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Vehicule</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .toolbar { display: flex; justify-content: space-between; margin-bottom: 20px; padding: 15px; background: #f8f9fa; border: 1px solid #ddd; }
        .table-admin { width: 100%; border-collapse: collapse; }
        .table-admin th { background-color: #343a40; color: white; padding: 10px; text-align: left; }
        .table-admin td { border: 1px solid #ddd; padding: 8px; }
        .btn-add { background-color: #28a745; color: white; padding: 8px; text-decoration: none; border-radius: 4px;}
        .btn-pdf { background-color: #dc3545; color: white; padding: 8px; text-decoration: none; border-radius: 4px;}
        .btn-xls { background-color: #17a2b8; color: white; padding: 8px; text-decoration: none; border-radius: 4px;}
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1200px;">
    <h2>🚗 Bază de date: Vehicule</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi</a>
    <br><br>

    <div class="toolbar">
        <form action="admin-vehicule" method="get">
            <input type="text" name="search" placeholder="Nr, Marca sau Sasiu..." style="padding: 8px; width: 250px;">
            <button type="submit" class="btn">🔍 Caută</button>
            <a href="admin-vehicule" class="btn" style="background:#6c757d;">Reset</a>
        </form>
        <div style="display:flex; gap:10px;">
            <a href="admin-vehicul-actions?action=new" class="btn-add">➕ Adaugă</a>
            <a href="admin-export-vehicule?type=pdf" class="btn-pdf" target="_blank">📄 PDF</a>
            <a href="admin-export-vehicule?type=excel" class="btn-xls">📊 Excel</a>
        </div>
    </div>

    <table class="table-admin">
        <thead>
        <tr>
            <th>ID</th>
            <th><%= getSortLink.apply("marca", "Marcă") %></th>
            <th><%= getSortLink.apply("model", "Model") %></th>
            <th><%= getSortLink.apply("nr", "Nr. Înmatriculare") %></th>
            <th><%= getSortLink.apply("serie", "Serie Șasiu") %></th>
            <th>Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <%
            // PRELUAM LISTA DIN REQUEST
            List<Vehicul> list = (List<Vehicul>) request.getAttribute("listaVehicule");

            if (list != null && !list.isEmpty()) {
                for (Vehicul v : list) {
        %>
        <tr>
            <td><%= v.getIdv() %></td>
            <td><%= v.getMarca() %></td>
            <td><%= v.getModel() %></td>
            <td><strong><%= v.getNrInmatriculare() %></strong></td>
            <td><%= v.getSerieSasiu() %></td>
            <td>
                <a href="admin-vehicul-actions?action=edit&id=<%= v.getIdv() %>" style="text-decoration:none; font-size:1.2em;">✏️</a>
                <a href="admin-vehicul-actions?action=delete&id=<%= v.getIdv() %>" onclick="return confirm('Ștergi vehiculul?');" style="text-decoration:none; font-size:1.2em; margin-left:10px;">🗑️</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="6" style="text-align:center; padding:20px;">Nu există vehicule în baza de date.</td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>