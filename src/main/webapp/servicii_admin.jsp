<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    String currentSort = (String) request.getAttribute("currentSort");
    String currentDir = (String) request.getAttribute("currentDir");

    java.util.function.BiFunction<String, String, String> getSortLink = (colName, label) -> {
        String newDir = "ASC";
        String icon = "<i class='fa-solid fa-sort text-muted ms-1 small'></i>";
        if (colName.equals(currentSort)) {
            if ("ASC".equals(currentDir)) { newDir = "DESC"; icon = "<i class='fa-solid fa-sort-up text-white ms-1'></i>"; }
            else { newDir = "ASC"; icon = "<i class='fa-solid fa-sort-down text-white ms-1'></i>"; }
        }
        return "<a href='admin-servicii?sort=" + colName + "&dir=" + newDir + "' class='text-decoration-none text-white d-block'>" + label + icon + "</a>";
    };
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Servicii</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-warning ps-3">
                    Catalog Servicii
                </h2>
                <div class="btn-group shadow-sm">
                    <a href="admin-serviciu-actions?action=new" class="btn btn-warning fw-bold text-dark">
                        <i class="fa-solid fa-plus me-1"></i> Adaugă
                    </a>
                    <a href="import_servicii.jsp" class="btn btn-dark">
                        <i class="fa-solid fa-file-import me-1"></i> Import
                    </a>
                    <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-file-export me-1"></i> Export
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="admin-export-servicii?type=pdf" target="_blank"><i class="fa-solid fa-file-pdf text-danger me-2"></i>PDF</a></li>
                        <li><a class="dropdown-item" href="admin-export-servicii?type=excel"><i class="fa-solid fa-file-excel text-success me-2"></i>Excel</a></li>
                    </ul>
                </div>
            </div>

            <div class="card card-dashboard mb-4 border-0">
                <div class="card-body">
                    <form action="admin-servicii" method="get" class="row g-2 align-items-center">
                        <div class="col-md-5">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                                <input type="text" name="search" class="form-control border-start-0" placeholder="Caută denumire serviciu...">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-dark">Caută</button>
                            <a href="admin-servicii" class="btn btn-outline-secondary">Reset</a>
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
                            <th><%= getSortLink.apply("nume", "Denumire") %></th>
                            <th><%= getSortLink.apply("descriere", "Descriere") %></th>
                            <th><%= getSortLink.apply("durata", "Durată (min)") %></th>
                            <th><%= getSortLink.apply("atelier", "Atelier") %></th>
                            <th class="text-end pe-4">Acțiuni</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Serviciu> list = (List<Serviciu>) request.getAttribute("listaServicii");
                            if (list != null && !list.isEmpty()) {
                                for (Serviciu s : list) {
                        %>
                        <tr>
                            <td class="ps-4 text-muted fw-bold">#<%= s.getIds() %></td>
                            <td>
                                <div class="fw-bold text-primary"><i class="fa-solid fa-wrench me-2"></i><%= s.getNume() %></div>
                            </td>
                            <td class="text-secondary small"><%= s.getDescriere() %></td>
                            <td><span class="badge bg-light text-dark border"><i class="fa-regular fa-clock me-1"></i><%= s.getDurataEstimata() %> min</span></td>
                            <td>
                                <% if (s.getNumeAtelier() != null) { %>
                                <span class="badge bg-secondary"><%= s.getNumeAtelier() %></span>
                                <% } else { %>
                                <span class="text-danger small">Neasignat</span>
                                <% } %>
                            </td>
                            <td class="text-end pe-4">
                                <a href="admin-serviciu-actions?action=edit&id=<%= s.getIds() %>" class="btn btn-sm btn-outline-primary me-1" title="Editează">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="admin-serviciu-actions?action=delete&id=<%= s.getIds() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Sigur vrei să ștergi acest serviciu?')" title="Șterge">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% }} else { %> <tr><td colspan="6" class="text-center p-4">Nu există servicii.</td></tr> <% } %>
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