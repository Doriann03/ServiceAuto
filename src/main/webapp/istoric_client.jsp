<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.IstoricClient" %>

<!DOCTYPE html>
<html>
<head>
    <title>Istoric Activitate Clienți</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        .table-logs { width: 100%; border-collapse: collapse; font-size: 14px; margin-top: 20px; }
        .table-logs th, .table-logs td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        .table-logs th { background-color: #007bff; color: white; } /* Albastru pt diferentiere de Admin */
        .table-logs tr:nth-child(even) { background-color: #f9f9f9; }

        /* Culori specifice Client */
        .log-prog { color: #28a745; font-weight: bold; } /* Programare - Verde */
        .log-reg { color: #e83e8c; font-weight: bold; }  /* Register - Roz */
        .log-auth { color: #6f42c1; font-weight: bold; }  /* Login/Logout - Mov */
        .log-other { color: #333; }
    </style>
</head>
<body>
<div class="admin-home" style="max-width: 1200px; margin: 0 auto; padding: 20px;">
    <h2>👥 Jurnal Activitate Clienți</h2>

    <div style="margin-bottom: 15px;">
        <a href="dashboard_admin.jsp" class="btn">⬅ Înapoi la Panou</a>
        <a href="admin-istoric" class="btn" style="background-color: #6c757d; float:right;">Vezi Istoric Admin ➡</a>
    </div>

    <table class="table-logs">
        <thead>
        <tr>
            <th style="width: 50px;">ID</th>
            <th style="width: 180px;">Data & Ora</th>
            <th style="width: 200px;">Nume Client</th>
            <th>Acțiune Detaliată</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<IstoricClient> logs = (List<IstoricClient>) request.getAttribute("listaLogs");

            if (logs != null && !logs.isEmpty()) {
                for (IstoricClient log : logs) {
                    String actiune = log.getActiune();

                    // Logica de culori CSS pt Client
                    String cssClass = "log-other";
                    if (actiune.contains("PROGRAMARE")) cssClass = "log-prog";
                    else if (actiune.contains("REGISTER") || actiune.contains("Cont nou")) cssClass = "log-reg";
                    else if (actiune.contains("LOGIN") || actiune.contains("LOGOUT")) cssClass = "log-auth";
        %>
        <tr>
            <td style="color:#888;"><%= log.getId() %></td>
            <td><%= log.getDataOra() %></td>
            <td><strong><%= log.getNumeClient() %></strong></td>
            <td class="<%= cssClass %>"><%= actiune %></td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="4" style="text-align:center; padding: 20px;">
                Nu există activitate a clienților înregistrată.
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>