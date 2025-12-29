<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.dto.ProgramareAdminDTO" %>
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
    <title>Administrare Programări</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-success ps-3">
                    Calendar Programări
                </h2>
                <button class="btn btn-outline-dark disabled">
                    <i class="fa-regular fa-calendar me-2"></i> Vizualizare Listă
                </button>
            </div>

            <div class="card card-dashboard border-0 shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Dată & Oră</th>
                            <th>Client / Contact</th>
                            <th>Vehicul</th>
                            <th>Status Curent</th>
                            <th class="text-end pe-4" style="min-width: 170px;">Acțiuni Workflow</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<ProgramareAdminDTO> lista = (List<ProgramareAdminDTO>) request.getAttribute("listaProgramari");
                            if (lista != null && !lista.isEmpty()) {
                                for (ProgramareAdminDTO p : lista) {

                                    // Logica de Culori pentru Badge-uri
                                    String badgeClass = "bg-secondary";
                                    String iconStatus = "fa-circle-question";

                                    if ("Programat".equalsIgnoreCase(p.getStatus())) {
                                        badgeClass = "bg-primary"; // Albastru
                                        iconStatus = "fa-calendar-check";
                                    } else if (p.getStatus() != null && p.getStatus().contains("Lucru")) {
                                        badgeClass = "bg-warning text-dark"; // Galben
                                        iconStatus = "fa-screwdriver-wrench";
                                    } else if ("Finalizat".equalsIgnoreCase(p.getStatus())) {
                                        badgeClass = "bg-success"; // Verde
                                        iconStatus = "fa-check-circle";
                                    }
                        %>
                        <tr>
                            <td class="ps-4 text-muted fw-bold">#<%= p.getIdProgramare() %></td>

                            <td>
                                <div class="d-flex align-items-center text-dark">
                                    <i class="fa-regular fa-calendar-days me-2 text-secondary"></i>
                                    <span class="fw-bold"><%= p.getDataProgramare() %></span>
                                </div>
                            </td>

                            <td>
                                <div>
                                    <div class="fw-bold"><%= p.getNumeClient() %></div>
                                    <small class="text-muted"><i class="fa-solid fa-phone me-1" style="font-size: 0.8em;"></i> <%= p.getTelefonClient() %></small>
                                </div>
                            </td>

                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-light rounded p-2 me-2 text-secondary">
                                        <i class="fa-solid fa-car-side"></i>
                                    </div>
                                    <div>
                                        <div class="fw-bold"><%= p.getMarcaModel() %></div>
                                        <span class="badge bg-white text-dark border border-secondary" style="font-family: monospace;">
                                            <%= p.getNrInmatriculare() %>
                                        </span>
                                    </div>
                                </div>
                            </td>

                            <td>
                                <span class="badge <%= badgeClass %> p-2">
                                    <i class="fa-solid <%= iconStatus %> me-1"></i> <%= p.getStatus() %>
                                </span>
                            </td>

                            <td class="text-end pe-4">
                                <div class="d-flex justify-content-end align-items-center gap-2">

                                    <% if ("Programat".equals(p.getStatus())) { %>
                                    <a href="admin-creare-lucrare?id=<%= p.getIdProgramare() %>" class="btn btn-sm btn-success fw-bold shadow-sm" title="Începe Lucrarea">
                                        <i class="fa-solid fa-play me-1"></i> Start
                                    </a>

                                    <% } else { %>
                                    <span class="text-muted fst-italic small me-2">
                                            <i class="fa-solid fa-lock me-1"></i>Blocat
                                        </span>
                                    <% } %>

                                    <a href="admin-delete-programare?id=<%= p.getIdProgramare() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Ești sigur că vrei să ștergi această programare?')" title="Șterge Programarea">
                                        <i class="fa-solid fa-trash"></i>
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="6" class="text-center p-5 text-muted">Nu există programări în sistem.</td></tr>
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