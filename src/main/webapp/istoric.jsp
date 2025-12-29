<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.IstoricDTO" %>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Istoric Lucrări</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body class="bg-light">

<jsp:include page="includes/navbar_client.jsp" />

<div class="container">
    <div class="card border-0 shadow-sm">
        <div class="card-header bg-white py-3">
            <h4 class="mb-0 fw-bold text-dark"><i class="fa-solid fa-clock-rotate-left me-2 text-info"></i> Istoric Programări & Reparații</h4>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light">
                <tr>
                    <th class="ps-4">Data Programării</th>
                    <th>Vehicul</th>
                    <th>Număr Înmatriculare</th>
                    <th>Status Lucrare</th>
                </tr>
                </thead>
                <tbody>
                <%
                    List<IstoricDTO> lista = (List<IstoricDTO>) request.getAttribute("listaIstoric");
                    if (lista != null && !lista.isEmpty()) {
                        for (IstoricDTO i : lista) {
                            // Logică culori
                            String status = i.getStatus();
                            String badgeClass = "bg-secondary";
                            if(status.contains("Programat")) badgeClass = "bg-primary";
                            else if(status.contains("Lucru")) badgeClass = "bg-warning text-dark";
                            else if(status.contains("Finalizat")) badgeClass = "bg-success";
                            else if(status.contains("Anulat")) badgeClass = "bg-danger";
                %>
                <tr>
                    <td class="ps-4 fw-bold text-muted">
                        <i class="fa-regular fa-calendar me-2"></i> <%= i.getDataProgramare() %>
                    </td>
                    <td><%= i.getMarcaModel() %></td>
                    <td>
                         <span class="badge bg-white text-dark border border-secondary" style="font-family: monospace;">
                             <%= i.getNrInmatriculare() %>
                         </span>
                    </td>
                    <td>
                        <span class="badge <%= badgeClass %>"><%= status %></span>
                    </td>
                </tr>
                <%  } } else { %>
                <tr>
                    <td colspan="4" class="text-center p-5">
                        <i class="fa-solid fa-folder-open fa-2x text-muted mb-3"></i><br>
                        Nu ai nicio programare înregistrată.
                        <br>
                        <a href="programare" class="btn btn-sm btn-primary mt-2">Fă o programare</a>
                    </td>
                </tr>
                <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>