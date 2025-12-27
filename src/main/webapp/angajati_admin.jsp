<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Angajat" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestiune Angajați</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .toolbar { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .btn-add { background-color: #28a745; color: white; padding: 5px 10px; text-decoration: none; border-radius: 5px;}
        .action-btn { margin-right: 5px; text-decoration: none; font-size: 1.2em; }
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1000px;">
    <h2>👨‍🔧 Bază de date: Angajați</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi</a>
    <br><br>

    <div class="toolbar">
        <form action="admin-angajati" method="get" style="display:inline;">
            <input type="text" name="search" placeholder="Cauta nume sau functie..." style="padding: 5px;">
            <button type="submit" class="btn">🔍</button>
            <a href="admin-angajati" class="btn" style="background:#888;">Reset</a>
        </form>

        <a href="admin-angajat-actions?action=new" class="btn-add">➕ Adaugă Angajat</a>
    </div>

    <table border="1" style="width:100%; border-collapse: collapse;">
        <thead>
        <tr style="background:#343a40; color:white;">
            <th>ID</th>
            <th>Nume Complet</th>
            <th>Funcție</th>
            <th>Atelier</th>
            <th>Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Angajat> list = (List<Angajat>) request.getAttribute("listaAngajati");
            if(list != null && !list.isEmpty()) {
                for(Angajat a : list) {
        %>
        <tr>
            <td><%= a.getIdAngajat() %></td>
            <td><%= a.getNume() %> <%= a.getPrenume() %></td>
            <td><%= a.getFunctie() %></td>
            <td><%= a.getNumeAtelier() != null ? a.getNumeAtelier() : "-" %></td>
            <td>
                <a href="admin-angajat-actions?action=edit&id=<%= a.getIdAngajat() %>" class="action-btn">✏️</a>
                <a href="admin-angajat-actions?action=delete&id=<%= a.getIdAngajat() %>" class="action-btn" onclick="return confirm('Stergi angajatul?');">🗑️</a>
            </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="5">Nu există angajați.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>