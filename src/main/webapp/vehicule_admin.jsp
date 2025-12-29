<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // Securitate
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Logica de Sortare (Pastram logica ta, doar o stilizam)
    String currentSort = (String) request.getAttribute("currentSort");
    String currentDir = (String) request.getAttribute("currentDir");

    java.util.function.BiFunction<String, String, String> getSortLink = (colName, label) -> {
        String newDir = "ASC";
        String icon = "<i class='fa-solid fa-sort text-muted ms-1 small'></i>"; // Iconita default

        if (colName.equals(currentSort)) {
            if ("ASC".equals(currentDir)) {
                newDir = "DESC";
                icon = "<i class='fa-solid fa-sort-up text-white ms-1'></i>";
            } else {
                newDir = "ASC";
                icon = "<i class='fa-solid fa-sort-down text-white ms-1'></i>";
            }
        }
        return "<a href='admin-vehicule?sort=" + colName + "&dir=" + newDir + "' class='text-decoration-none text-white d-block'>" + label + icon + "</a>";
    };
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Vehicule</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-primary ps-3">
                    Flotă Vehicule
                </h2>

                <div class="btn-group shadow-sm">
                    <a href="admin-vehicul-actions?action=new" class="btn btn-primary fw-bold">
                        <i class="fa-solid fa-plus me-1"></i> Adaugă
                    </a>
                    <button type="button" class="btn btn-dark dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-download me-1"></i> Export
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="admin-export-vehicule?type=pdf" target="_blank"><i class="fa-solid fa-file-pdf text-danger me-2"></i>PDF</a></li>
                        <li><a class="dropdown-item" href="admin-export-vehicule?type=excel"><i class="fa-solid fa-file-excel text-success me-2"></i>Excel</a></li>
                    </ul>
                </div>
            </div>

            <div class="card card-dashboard mb-4 border-0">
                <div class="card-body">
                    <form action="admin-vehicule" method="get" class="row g-2 align-items-center">
                        <div class="col-auto">
                            <label class="fw-bold text-secondary">Filtrează:</label>
                        </div>
                        <div class="col-md-5">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fa-solid fa-car text-muted"></i></span>
                                <input type="text" name="search" class="form-control border-start-0" placeholder="Caută Nr. Înmatriculare, Marcă sau Serie Șasiu...">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-dark">Caută</button>
                            <a href="admin-vehicule" class="btn btn-outline-secondary">Reset</a>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card card-dashboard border-0 shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th><%= getSortLink.apply("marca", "Marcă & Model") %></th>
                            <th><%= getSortLink.apply("nr", "Nr. Înmatriculare") %></th>
                            <th><%= getSortLink.apply("serie", "Serie Șasiu (VIN)") %></th>
                            <th class="text-end pe-4">Acțiuni</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Vehicul> list = (List<Vehicul>) request.getAttribute("listaVehicule");
                            if (list != null && !list.isEmpty()) {
                                for (Vehicul v : list) {
                        %>
                        <tr>
                            <td class="ps-4 text-muted fw-bold">#<%= v.getIdv() %></td>
                            <td>
                                <div class="fw-bold"><%= v.getMarca() %> <%= v.getModel() %></div>
                                <small class="text-muted"><%= v.getTip() != null ? v.getTip() : "" %> <%= v.getMotor() != null ? "(" + v.getMotor() + ")" : "" %></small>
                            </td>
                            <td>
                                <span class="badge bg-white text-dark border border-secondary fw-bold" style="font-family: monospace; font-size: 14px;">
                                    <%= v.getNrInmatriculare() %>
                                </span>
                            </td>
                            <td class="text-monospace text-secondary small">
                                <%= v.getSerieSasiu() %>
                            </td>
                            <td class="text-end pe-4">
                                <a href="admin-vehicul-actions?action=edit&id=<%= v.getIdv() %>" class="btn btn-sm btn-outline-primary me-1" title="Editează">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="admin-vehicul-actions?action=delete&id=<%= v.getIdv() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Sigur doriți să ștergeți acest vehicul?')" title="Șterge">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="5" class="text-center p-5 text-muted">Nu există vehicule în baza de date.</td></tr>
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