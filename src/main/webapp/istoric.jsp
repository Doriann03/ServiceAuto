<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.IstoricDTO" %>

<!DOCTYPE html>
<html>
<head>
    <title>Istoric Lucrări</title>
    <link rel="stylesheet" href="css/style.css">
    <style>
        /* Stiluri simple pentru culori status */
        .status-Programat { color: #007bff; font-weight: bold; }
        .status-Inlucru { color: #e67e22; font-weight: bold; } /* Atentie: In lucru are spatiu in BD */
        .status-Finalizat { color: #28a745; font-weight: bold; }
        .status-Anulat { color: #dc3545; font-weight: bold; }
    </style>
</head>
<body>
<div class="admin-home">
    <h2>Istoricul Programărilor Tale</h2>
    <a href="dashboard_client.jsp" class="btn">⬅ Înapoi la Dashboard</a>
    <br><br>

    <table border="1" style="width: 100%; border-collapse: collapse;">
        <thead>
        <tr style="background-color: #f2f2f2;">
            <th style="padding: 10px;">Data</th>
            <th style="padding: 10px;">Vehicul</th>
            <th style="padding: 10px;">Număr</th>
            <th style="padding: 10px;">Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<IstoricDTO> lista = (List<IstoricDTO>) request.getAttribute("listaIstoric");

            if (lista != null && !lista.isEmpty()) {
                for (IstoricDTO i : lista) {
                    // Un mic truc pentru CSS: scoatem spatiile din "In lucru" -> "Inlucru"
                    String clasaStatus = "status-" + i.getStatus().replace(" ", "");
        %>
        <tr>
            <td style="padding: 10px; text-align: center;"><%= i.getDataProgramare() %></td>
            <td style="padding: 10px;"><%= i.getMarcaModel() %></td>
            <td style="padding: 10px; text-align: center;"><%= i.getNrInmatriculare() %></td>
            <td style="padding: 10px; text-align: center;">
                <span class="<%= clasaStatus %>"><%= i.getStatus() %></span>
            </td>
        </tr>
        <%  }
        } else { %>
        <tr>
            <td colspan="4" style="text-align:center; padding: 20px;">
                Nu ai nicio programare înregistrată.
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>
</body>
</html>