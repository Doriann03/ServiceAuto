<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.ProgramareAdminDTO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Administrare Programări</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .table-admin { width: 100%; border-collapse: collapse; margin-top: 20px; }
        .table-admin th, .table-admin td { border: 1px solid #ddd; padding: 12px; text-align: left; }
        .table-admin th { background-color: #343a40; color: white; }
        .table-admin tr:nth-child(even) { background-color: #f2f2f2; }

        .status-Programat { color: blue; font-weight: bold; }
        .status-Inlucru { color: orange; font-weight: bold; }
        .status-Finalizat { color: green; font-weight: bold; }

        .btn-sm { padding: 5px 10px; font-size: 12px; margin-right: 5px; text-decoration: none; border-radius: 3px; color: white; display: inline-block;}
        .btn-delete { background-color: #dc3545; }
        .btn-job { background-color: #28a745; }
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1000px;">
    <h2>Toate Programările</h2>
    <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi la Panou Admin</a>

    <table class="table-admin">
        <thead>
        <tr>
            <th>ID</th>
            <th>Dată</th>
            <th>Client</th>
            <th>Telefon</th>
            <th>Vehicul</th>
            <th>Status</th>
            <th>Acțiuni</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<ProgramareAdminDTO> lista = (List<ProgramareAdminDTO>) request.getAttribute("listaProgramari");
            if (lista != null) {
                for (ProgramareAdminDTO p : lista) {
                    String statusClass = "status-" + p.getStatus().replace(" ", "");
        %>
        <tr>
            <td><%= p.getIdProgramare() %></td>
            <td><%= p.getDataProgramare() %></td>
            <td><%= p.getNumeClient() %></td>
            <td><%= p.getTelefonClient() %></td>
            <td>
                <%= p.getMarcaModel() %><br>
                <small><%= p.getNrInmatriculare() %></small>
            </td>
            <td><span class="<%= statusClass %>"><%= p.getStatus() %></span></td>
            <td>
                <a href="admin-creare-lucrare?id=<%= p.getIdProgramare() %>" class="btn-sm btn-job">🛠️ Lucrare</a>
                <a href="admin-delete-programare?id=<%= p.getIdProgramare() %>"
                   class="btn-sm btn-delete"
                   onclick="return confirm('Sigur vrei să ștergi această programare?');">
                    🗑️ Șterge
                </a>
            </td>
        </tr>
        <% } } %>
        </tbody>
    </table>
</div>
</body>
</html>