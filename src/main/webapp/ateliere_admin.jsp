<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
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
        return "<a href='admin-ateliere?sort=" + colName + "&dir=" + newDir + "' class='text-decoration-none text-white d-block'>" + label + icon + "</a>";
    };
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Ateliere</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">
    <jsp:include page="includes/sidebar_admin.jsp" />
    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-info ps-3">
                    Rețea Ateliere
                </h2>
                <a href="admin-atelier-actions?action=new" class="btn btn-info text-white shadow-sm fw-bold">
                    <i class="fa-solid fa-plus me-1"></i> Adaugă Atelier
                </a>
            </div>

            <div class="card card-dashboard mb-4 border-0">
                <div class="card-body">
                    <form action="admin-ateliere" method="get" class="row g-2 align-items-center">
                        <div class="col-md-5">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                                <input type="text" name="search" class="form-control border-start-0" placeholder="Caută Nume sau Adresă...">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-dark">Caută</button>
                            <a href="admin-ateliere" class="btn btn-outline-secondary">Reset</a>
                        </div>
                    </form>
                </div>
            </div>

            <div class="card card-dashboard border-0 shadow-sm">
                <div class="card-body p-0">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-dark">
                        <tr>
                            <th class="ps-4"><%= getSortLink.apply("id", "ID") %></th>
                            <th><%= getSortLink.apply("nume", "Denumire Atelier") %></th>
                            <th><%= getSortLink.apply("adresa", "Locație / Adresă") %></th>
                            <th class="text-end pe-4">Acțiuni</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Atelier> list = (List<Atelier>) request.getAttribute("listaAteliere");
                            if (list != null && !list.isEmpty()) {
                                for (Atelier a : list) {
                        %>
                        <tr>
                            <td class="ps-4 text-muted fw-bold">#<%= a.getIda() %></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <i class="fa-solid fa-warehouse text-info me-2 fs-5"></i>
                                    <span class="fw-bold"><%= a.getNume() %></span>
                                </div>
                            </td>
                            <td><i class="fa-solid fa-location-dot text-danger me-1"></i> <%= a.getAdresa() %></td>
                            <td class="text-end pe-4">
                                <a href="admin-atelier-actions?action=edit&id=<%= a.getIda() %>" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="admin-atelier-actions?action=delete&id=<%= a.getIda() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Ștergi acest atelier?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% }} else { %> <tr><td colspan="4" class="text-center p-4">Nu există ateliere.</td></tr> <% } %>
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