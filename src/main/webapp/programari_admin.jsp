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
        .table-admin th, .table-admin td { border: 1px solid #ddd; padding: 12px; text-align: left; vertical-align: middle; }
        .table-admin th { background-color: #343a40; color: white; }
        .table-admin tr:nth-child(even) { background-color: #f2f2f2; }

        .status-Programat { color: blue; font-weight: bold; }
        .status-Inlucru { color: orange; font-weight: bold; }
        .status-Finalizat { color: green; font-weight: bold; }

        /* Stiluri Butoane Mici */
        .btn-sm {
            padding: 5px 10px;
            font-size: 12px;
            text-decoration: none;
            border-radius: 4px;
            color: white;
            display: inline-block;
            margin-right: 5px;
            border: none;
            cursor: pointer;
        }
        .btn-delete { background-color: #dc3545; }
        .btn-delete:hover { background-color: #c82333; }

        .btn-job { background-color: #28a745; }
        .btn-job:hover { background-color: #218838; }

        /* Container pentru actiuni ca sa stea pe un rand */
        .action-container {
            display: flex;
            align-items: center;
        }
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
            <th style="width: 180px;">Acțiuni</th> </tr>
        </thead>
        <tbody>
        <%
            List<ProgramareAdminDTO> lista = (List<ProgramareAdminDTO>) request.getAttribute("listaProgramari");
            if (lista != null) {
                for (ProgramareAdminDTO p : lista) {
                    // Calculam clasa CSS dinamic (status-Programat, etc.)
                    // .replace(" ", "") e util daca ai status "In lucru" cu spatiu
                    String statusClass = "status-" + p.getStatus().replace(" ", "");
        %>
        <tr>
            <td><%= p.getIdProgramare() %></td>
            <td><%= p.getDataProgramare() %></td>
            <td><%= p.getNumeClient() %></td>
            <td><%= p.getTelefonClient() %></td>
            <td>
                <%= p.getMarcaModel() %><br>
                <small style="color:#666;"><%= p.getNrInmatriculare() %></small>
            </td>
            <td><span class="<%= statusClass %>"><%= p.getStatus() %></span></td>

            <td>
                <div class="action-container">

                    <% if ("Programat".equals(p.getStatus())) { %>
                    <a href="admin-creare-lucrare?id=<%= p.getIdProgramare() %>" class="btn-sm btn-job">🛠️ Start lucrare</a>

                    <% } else { %>
                    <span style="color: #999; font-size: 11px; margin-right: 10px; font-style: italic;">
                            (Deja <%= p.getStatus() %>)
                        </span>
                    <% } %>

                    <a href="admin-delete-programare?id=<%= p.getIdProgramare() %>" class="btn-sm btn-delete" onclick="return confirm('Ești sigur că vrei să ștergi această programare?')">🗑️</a>

                </div>
            </td>
        </tr>
        <% } } %>
        </tbody>
    </table>
</div>
</body>
</html>