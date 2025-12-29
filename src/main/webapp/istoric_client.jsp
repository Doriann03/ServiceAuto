<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.IstoricClient" %>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Istoric Clienți</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-primary ps-3">
                    Audit Clienți
                </h2>
                <div class="btn-group">
                    <a href="admin-istoric" class="btn btn-outline-info btn-sm">Vezi Istoric Admin</a>
                </div>
            </div>

            <div class="card card-dashboard border-0 shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-primary text-white">
                        <tr>
                            <th class="ps-4 bg-primary text-white" style="width: 50px;">ID</th>
                            <th class="bg-primary text-white">Data & Ora</th>
                            <th class="bg-primary text-white">Client</th>
                            <th class="bg-primary text-white">Acțiune</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<IstoricClient> logs = (List<IstoricClient>) request.getAttribute("listaLogs");
                            if (logs != null && !logs.isEmpty()) {
                                for (IstoricClient log : logs) {
                                    String actiune = log.getActiune();

                                    String badgeHTML = "<span class='badge bg-secondary'>INFO</span>";
                                    if (actiune.contains("PROGRAMARE")) badgeHTML = "<span class='badge bg-success'>PROGRAMARE</span>";
                                    else if (actiune.contains("REGISTER")) badgeHTML = "<span class='badge bg-danger'>REGISTER</span>";
                                    else if (actiune.contains("LOGIN")) badgeHTML = "<span class='badge bg-dark'>LOGIN</span>";
                        %>
                        <tr>
                            <td class="ps-4 text-muted"><%= log.getId() %></td>
                            <td><small class="text-secondary"><%= log.getDataOra() %></small></td>
                            <td><strong><%= log.getNumeClient() %></strong></td>
                            <td><%= badgeHTML %> <span class="ms-2"><%= actiune %></span></td>
                        </tr>
                        <% }} else { %>
                        <tr><td colspan="4" class="text-center p-5 text-muted">Fără activitate.</td></tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>