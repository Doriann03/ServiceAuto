<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
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
    <title>Gestiune Clienți</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .toolbar { display: flex; justify-content: space-between; margin-bottom: 20px; }
        .search-form { display: flex; gap: 10px; }
        .action-btn { padding: 5px 10px; border-radius: 4px; color: white; text-decoration: none; font-size: 14px; }
        .btn-edit { background-color: #ffc107; color: black; }
        .btn-delete { background-color: #dc3545; }
        .btn-add { background-color: #28a745; }
        /* Butoane placeholder pt export (le facem functionale in pasul urmator) */
        .btn-export { background-color: #17a2b8; }
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1200px;">
    <h2>Bază de date: Clienți</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi la Dashboard</a>
    <br><br>

    <div class="toolbar">
        <form action="admin-clienti" method="get" class="search-form">
            <input type="text" name="search" placeholder="Nume, Telefon sau Email..." style="padding: 8px; width: 300px;">
            <button type="submit" class="btn">🔍 Caută</button>
            <a href="admin-clienti" class="btn" style="background:#6c757d">Resetează</a>
        </form>

        <div>
            <a href="admin-client-actions?action=new" class="btn btn-add">➕ Adaugă Client</a>
            <a href="admin-export-clienti?type=pdf" class="btn btn-export" target="_blank">📄 Export PDF</a>
            <a href="admin-export-clienti?type=excel" class="btn btn-export">📊 Export Excel</a>
            <a href="import_clienti.jsp" class="btn" style="background-color: #6f42c1;">📥 Import Excel</a>
        </div>
    </div>

    <table border="1" style="width:100%; border-collapse: collapse;">
        <thead>
        <tr style="background:#343a40; color:white;">
            <th>ID</th>
            <th>Nume</th>
            <th>Prenume</th>
            <th>Telefon</th>
            <th>Email</th>
            <th>Username</th>
            <th>Rol</th>
            <th>Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Client> list = (List<Client>) request.getAttribute("listaClienti");
            if(list != null && !list.isEmpty()) {
                for(Client c : list) {
        %>
        <tr>
            <td><%= c.getIdc() %></td>
            <td><%= c.getNume() %></td>
            <td><%= c.getPrenume() %></td>
            <td><%= c.getTelefon() %></td>
            <td><%= c.getEmail() %></td>
            <td><%= c.getUsername() %></td>
            <td><%= c.getTipUtilizator() %></td>
            <td>
                <a href="admin-client-actions?action=edit&id=<%= c.getIdc() %>" class="action-btn btn-edit">✏️</a>
                <a href="admin-client-actions?action=delete&id=<%= c.getIdc() %>" class="action-btn btn-delete"
                   onclick="return confirm('Sigur ștergi acest client?');">🗑️</a>
            </td>
        </tr>
        <% }} else { %>
        <tr><td colspan="8" style="text-align:center">Niciun client găsit.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
<%
    String msg = request.getParameter("msg");
    if (msg != null) {
%>
<div style="background-color: #d4edda; color: #155724; padding: 15px; text-align: center; margin-bottom: 20px;">
    <%= java.net.URLDecoder.decode(msg, "UTF-8") %>
</div>
<% } %>
</html>