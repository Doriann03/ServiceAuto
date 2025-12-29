<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.IstoricAdmin" %>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Jurnal Activitate Admin</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-info ps-3">
                    Audit Administratori
                </h2>
                <a href="dashboard_admin.jsp" class="btn btn-outline-dark btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Dashboard
                </a>
            </div>

            <div class="card card-dashboard border-0 shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                        <tr>
                            <th class="ps-4" style="width: 50px;">ID</th>
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

                                    // Transformam cuvintele cheie in Badge-uri
                                    String badgeHTML = "<span class='badge bg-secondary'>INFO</span>";

                                    if (actiune.contains("DELETE")) badgeHTML = "<span class='badge bg-danger'>DELETE</span>";
                                    else if (actiune.contains("INSERT")) badgeHTML = "<span class='badge bg-success'>INSERT</span>";
                                    else if (actiune.contains("UPDATE")) badgeHTML = "<span class='badge bg-primary'>UPDATE</span>";
                                    else if (actiune.contains("LOGIN") || actiune.contains("LOGOUT")) badgeHTML = "<span class='badge bg-dark'>AUTH</span>";
                                    else if (actiune.contains("WORKFLOW")) badgeHTML = "<span class='badge bg-warning text-dark'>WORKFLOW</span>";

                                    // Curatam textul actiunii (scoatem prefixul SQL: ... ca sa ramana doar mesajul)
                                    String mesajCurat = actiune.replace("SQL: ", "").replace("WORKFLOW | ", "");
                        %>
                        <tr>
                            <td class="ps-4 text-muted"><%= log.getId() %></td>
                            <td><small class="text-secondary"><i class="fa-regular fa-clock me-1"></i><%= log.getDataOra() %></small></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-light rounded-circle p-1 border me-2"><i class="fa-solid fa-user-shield text-info"></i></div>
                                    <strong><%= log.getNumeAdmin() %></strong>
                                </div>
                            </td>
                            <td>
                                <%= badgeHTML %> <span class="ms-2"><%= mesajCurat %></span>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="4" class="text-center p-5 text-muted">Nu există activitate înregistrată.</td></tr>
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