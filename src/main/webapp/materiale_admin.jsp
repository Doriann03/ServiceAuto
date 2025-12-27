<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.MaterialePiese" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }
    String currentSort = (String) request.getAttribute("currentSort");
    String currentDir = (String) request.getAttribute("currentDir");
    java.util.function.BiFunction<String, String, String> getSortLink = (colName, label) -> {
        String newDir = (colName.equals(currentSort) && "ASC".equals(currentDir)) ? "DESC" : "ASC";
        String arrow = colName.equals(currentSort) ? ("ASC".equals(currentDir) ? " 🔽" : " 🔼") : "";
        return "<a href='admin-materiale?sort=" + colName + "&dir=" + newDir + "' style='color:white; text-decoration:none;'>" + label + arrow + "</a>";
    };
%>
<!DOCTYPE html>
<html>
<head>
    <title>Gestiune Piese</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .toolbar { display: flex; justify-content: space-between; margin-bottom: 20px; padding: 15px; background: #f8f9fa; border: 1px solid #ddd; }
        .table-admin th { background-color: #343a40; color: white; padding: 10px; }
        .table-admin td { border: 1px solid #ddd; padding: 8px; }
        .btn-add { background-color: #28a745; color: white; padding: 8px; border-radius: 4px; text-decoration:none;}
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1100px;">
    <h2>⚙️ Bază de date: Materiale & Piese</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi</a>
    <br><br>
    <div class="toolbar">
        <form action="admin-materiale" method="get">
            <input type="text" name="search" placeholder="Cauta piesa..." style="padding: 8px;">
            <button type="submit" class="btn">🔍</button>
            <a href="admin-materiale" class="btn" style="background:#6c757d;">Reset</a>
        </form>
        <div style="display:flex; gap:10px;">
            <a href="admin-materiale-actions?action=new" class="btn-add">➕ Adaugă</a>
            <a href="admin-export-materiale?type=pdf" class="btn" style="background:#dc3545;">PDF</a>
            <a href="admin-export-materiale?type=excel" class="btn" style="background:#17a2b8;">Excel</a>
            <a href="import_materiale.jsp" class="btn" style="background:#6f42c1;">Import</a>
        </div>
    </div>
    <table class="table-admin" style="width:100%; border-collapse:collapse;">
        <thead>
        <tr>
            <th>ID</th>
            <th><%= getSortLink.apply("denumire", "Denumire") %></th>
            <th><%= getSortLink.apply("cantitate", "Cantitate") %></th>
            <th><%= getSortLink.apply("pret", "Preț (RON)") %></th>
            <th><%= getSortLink.apply("serviciu", "Asociat cu Serviciul") %></th>
            <th>Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <% List<MaterialePiese> list = (List<MaterialePiese>) request.getAttribute("listaMateriale");
            if(list != null && !list.isEmpty()) { for(MaterialePiese m : list) { %>
        <tr>
            <td><%= m.getIdMat() %></td>
            <td><%= m.getDenumire() %></td>
            <td><strong><%= m.getCantitate() %></strong></td>
            <td><%= m.getPretUnitar() %></td>
            <td><%= m.getNumeServiciu() != null ? m.getNumeServiciu() : "-" %></td>
            <td>
                <a href="admin-materiale-actions?action=edit&id=<%= m.getIdMat() %>">✏️</a>
                <a href="admin-materiale-actions?action=delete&id=<%= m.getIdMat() %>" onclick="return confirm('Stergi?');">🗑️</a>
            </td>
        </tr>
        <% }} else { %> <tr><td colspan="6" style="text-align:center;">Nu există date.</td></tr> <% } %>
        </tbody>
    </table>
</div>
</body>
</html>