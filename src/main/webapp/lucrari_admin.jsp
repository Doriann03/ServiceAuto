<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.LucrareAdminDTO" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // Securitate
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Lucrări</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-danger ps-3">
                    Monitorizare Lucrări
                </h2>
                <a href="admin-lucrari" class="btn btn-outline-dark btn-sm">
                    <i class="fa-solid fa-rotate me-1"></i> Actualizează
                </a>
            </div>

            <div class="card card-dashboard border-0 shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Client & Vehicul</th>
                            <th>Mecanic Responsabil</th>
                            <th style="max-width: 300px;">Descriere / Diagnostic</th>
                            <th>Status</th>
                            <th style="min-width: 200px;">Acțiune / Cost Final</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<LucrareAdminDTO> lista = (List<LucrareAdminDTO>) request.getAttribute("listaLucrari");
                            if (lista != null && !lista.isEmpty()) {
                                for (LucrareAdminDTO L : lista) {
                                    boolean isInLucru = "In lucru".equals(L.getStatus());

                                    // Stiluri dinamice
                                    String badgeClass = isInLucru ? "bg-warning text-dark" : "bg-success";
                                    String iconClass = isInLucru ? "fa-screwdriver-wrench" : "fa-check-circle";
                        %>
                        <tr>
                            <td class="ps-4 fw-bold text-secondary">#<%= L.getIdLucrare() %></td>

                            <td>
                                <div class="d-flex flex-column">
                                    <span class="fw-bold text-dark">
                                        <i class="fa-solid fa-user text-secondary me-1"></i> <%= L.getNumeClient() %>
                                    </span>
                                    <small class="text-muted mt-1">
                                        <i class="fa-solid fa-car-side text-primary me-1"></i> <%= L.getMasina() %>
                                    </small>
                                </div>
                            </td>

                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-light rounded-circle p-1 me-2 border">
                                        <i class="fa-solid fa-user-gear text-dark"></i>
                                    </div>
                                    <span><%= L.getNumeMecanic() %></span>
                                </div>
                            </td>

                            <td class="text-secondary small" style="max-width: 300px;">
                                <%= L.getDescriere() %>
                            </td>

                            <td>
                                <span class="badge <%= badgeClass %> p-2">
                                    <i class="fa-solid <%= iconClass %> me-1"></i> <%= L.getStatus() %>
                                </span>
                            </td>

                            <td>
                                <% if (isInLucru) { %>
                                <form action="admin-lucrari" method="post">
                                    <input type="hidden" name="idLucrare" value="<%= L.getIdLucrare() %>">

                                    <div class="input-group input-group-sm">
                                        <span class="input-group-text">RON</span>
                                        <input type="number" step="0.01" name="pretFinal" class="form-control fw-bold" placeholder="0.00" required>
                                        <button type="submit" class="btn btn-success" title="Finalizează Lucrarea">
                                            <i class="fa-solid fa-check"></i>
                                        </button>
                                    </div>
                                </form>
                                <% } else { %>
                                <div class="d-flex align-items-center text-success fw-bold fs-5">
                                    <i class="fa-solid fa-receipt me-2"></i>
                                    <%= L.getPret() %> RON
                                </div>
                                <% } %>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="6" class="text-center p-5 text-muted">Nu există lucrări înregistrate.</td></tr>
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