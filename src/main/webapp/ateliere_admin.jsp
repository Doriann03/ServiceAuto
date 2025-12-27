<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    String currentSort = (String) request.getAttribute("currentSort");
    String currentDir = (String) request.getAttribute("currentDir");

    java.util.function.BiFunction<String, String, String> getSortLink = (colName, label) -> {
        String newDir = "ASC";
        String arrow = "";
        if (colName.equals(currentSort)) {
            if ("ASC".equals(currentDir)) { newDir = "DESC"; arrow = " 🔼"; }
            else { newDir = "ASC"; arrow = " 🔽"; }
        }
        return "<a href='admin-ateliere?sort=" + colName + "&dir=" + newDir + "' style='color:white; text-decoration:none;'>" + label + arrow + "</a>";
    };
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Ateliere</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .toolbar { display: flex; justify-content: space-between; margin-bottom: 20px; padding: 15px; background: #f8f9fa; border: 1px solid #ddd; border-radius: 5px; }
        .table-admin th { background-color: #343a40; color: white; padding: 10px; }
        .table-admin td { border: 1px solid #ddd; padding: 8px; }
        .btn-add { background-color: #28a745; color: white; padding: 8px 15px; text-decoration: none; border-radius: 4px; }
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 900px;">
    <h2>🏢 Bază de date: Ateliere</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi</a>
    <br><br>

    <div class="toolbar">
        <form action="admin-ateliere" method="get">
            <input type="text" name="search" placeholder="Nume sau adresă..." style="padding: 8px;">
            <button type="submit" class="btn">🔍 Caută</button>
            <a href="admin-ateliere" class="btn" style="background:#6c757d;">Reset</a>
        </form>
        <a href="admin-atelier-actions?action=new" class="btn-add">➕ Adaugă Atelier</a>
    </div>

    <table class="table-admin" style="width:100%; border-collapse:collapse;">
        <thead>
        <tr>
            <th><%= getSortLink.apply("id", "ID") %></th>
            <th><%= getSortLink.apply("nume", "Denumire Atelier") %></th>
            <th><%= getSortLink.apply("adresa", "Adresă") %></th>
            <th>Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Atelier> list = (List<Atelier>) request.getAttribute("listaAteliere");
            if (list != null && !list.isEmpty()) {
                for (Atelier a : list) {
        %>
        <tr>
            <td><%= a.getIda() %></td>
            <td><strong><%= a.getNume() %></strong></td>
            <td><%= a.getAdresa() %></td>
            <td>
                <a href="admin-atelier-actions?action=edit&id=<%= a.getIda() %>" style="margin-right:10px;">✏️</a>
                <a href="admin-atelier-actions?action=delete&id=<%= a.getIda() %>" onclick="return confirm('Ștergi acest atelier? Atenție: Dacă are angajați sau servicii, ștergerea poate eșua!');">🗑️</a>
            </td>
        </tr>
        <% }} else { %> <tr><td colspan="4" style="text-align:center;">Nu există ateliere.</td></tr> <% } %>
        </tbody>
    </table>
</div>
</body>
</html>