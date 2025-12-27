<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.LucrareAdminDTO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Gestiune Lucrări</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .table-admin { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .table-admin th, .table-admin td { border: 1px solid #ddd; padding: 10px; text-align: left; vertical-align: middle; }
        .table-admin th { background-color: #343a40; color: white; }

        .status-Inlucru { color: orange; font-weight: bold; }
        .status-Finalizat { color: green; font-weight: bold; }

        .input-price { width: 80px; padding: 5px; }
        .btn-finish { background-color: #28a745; color: white; border: none; padding: 5px 10px; cursor: pointer; border-radius: 3px; }
        .btn-finish:hover { background-color: #218838; }
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1100px;">
    <h2>Lucrări în Service</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi</a>

    <table class="table-admin">
        <thead>
        <tr>
            <th>ID</th>
            <th>Client & Mașină</th>
            <th>Mecanic</th>
            <th>Descriere</th>
            <th>Status</th>
            <th>Acțiune / Preț Final</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<LucrareAdminDTO> lista = (List<LucrareAdminDTO>) request.getAttribute("listaLucrari");
            if (lista != null) {
                for (LucrareAdminDTO L : lista) {
                    boolean isInLucru = "In lucru".equals(L.getStatus());
        %>
        <tr>
            <td><%= L.getIdLucrare() %></td>
            <td>
                <strong><%= L.getNumeClient() %></strong><br>
                <%= L.getMasina() %>
            </td>
            <td><%= L.getNumeMecanic() %></td>
            <td><%= L.getDescriere() %></td>
            <td>
                        <span class="status-<%= L.getStatus().replace(" ", "") %>">
                            <%= L.getStatus() %>
                        </span>
            </td>
            <td>
                <% if (isInLucru) { %>
                <form action="admin-lucrari" method="post" style="display: flex; gap: 5px;">
                    <input type="hidden" name="idLucrare" value="<%= L.getIdLucrare() %>">
                    <input type="number" step="0.01" name="pretFinal" class="input-price" placeholder="Preț RON" required>
                    <button type="submit" class="btn-finish">✅ Finalizează</button>
                </form>
                <% } else { %>
                <strong><%= L.getPret() %> RON</strong>
                <% } %>
            </td>
        </tr>
        <% } } else { %>
        <tr><td colspan="6">Nu există lucrări.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>