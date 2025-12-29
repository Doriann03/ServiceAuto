<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.IstoricAdmin" %> <!DOCTYPE html>
<html>
<head>
    <title>Jurnal Activitate Admin</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .table-logs { width: 100%; border-collapse: collapse; font-size: 14px; margin-top: 20px; }
        .table-logs th, .table-logs td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        .table-logs th { background-color: #343a40; color: white; }
        .table-logs tr:nth-child(even) { background-color: #f9f9f9; }

        /* Culori pentru actiuni */
        .log-delete { color: #dc3545; font-weight: bold; }
        .log-insert { color: #28a745; font-weight: bold; }
        .log-update { color: #007bff; font-weight: bold; }
        .log-auth { color: #6f42c1; font-weight: bold; } /* Login/Logout */
        .log-work { color: #fd7e14; font-weight: bold; } /* Workflow */
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <h2>📋 Jurnal Activitate Administratori (Audit)</h2>

    <div style="margin-bottom: 15px;">
        <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi la Panou</a>
    </div>

    <table class="table-logs">
        <thead>
        <tr>
            <th style="width: 50px;">ID</th>
            <th style="width: 180px;">Data & Ora</th>
            <th style="width: 200px;">Administrator</th>
            <th>Acțiune Detaliată</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<IstoricAdmin> logs = (List<IstoricAdmin>) request.getAttribute("listaLogs");

            if (logs != null && !logs.isEmpty()) {
                for (IstoricAdmin log : logs) {
                    String actiune = log.getActiune();

                    // Logica de culori CSS
                    String cssClass = "";
                    if (actiune.contains("DELETE")) cssClass = "log-delete";
                    else if (actiune.contains("INSERT")) cssClass = "log-insert";
                    else if (actiune.contains("UPDATE")) cssClass = "log-update";
                    else if (actiune.contains("LOGIN") || actiune.contains("LOGOUT")) cssClass = "log-auth";
                    else if (actiune.contains("WORKFLOW")) cssClass = "log-work";
        %>
        <tr>
            <td style="color:#888;"><%= log.getId() %></td>
            <td><%= log.getDataOra() %></td> <td><strong><%= log.getNumeAdmin() %></strong></td> <td class="<%= cssClass %>"><%= actiune %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" style="text-align:center; padding: 20px;">
                Nu există activitate înregistrată încă.
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>