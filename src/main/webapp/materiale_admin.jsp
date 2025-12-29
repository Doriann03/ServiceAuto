<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.MaterialePiese" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }
    String currentSort = (String) request.getAttribute("currentSort");
    String currentDir = (String) request.getAttribute("currentDir");
    java.util.function.BiFunction<String, String, String> getSortLink = (colName, label) -> {
        String newDir = (colName.equals(currentSort) && "ASC".equals(currentDir)) ? "DESC" : "ASC";
        String arrow = colName.equals(currentSort) ? ("ASC".equals(currentDir) ? " <i class='fa-solid fa-sort-down'></i>" : " <i class='fa-solid fa-sort-up'></i>") : "";
        return "<a href='admin-materiale?sort=" + colName + "&dir=" + newDir + "' class='text-decoration-none text-white d-block'>" + label + arrow + "</a>";
    };
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Piese</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">
    <jsp:include page="includes/sidebar_admin.jsp" />
    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-primary ps-3" style="border-color: #6f42c1 !important;">
                    Stoc Materiale & Piese
                </h2>
                <div class="btn-group shadow-sm">
                    <a href="admin-materiale-actions?action=new" class="btn text-white fw-bold" style="background-color: #6f42c1;">
                        <i class="fa-solid fa-plus me-1"></i> Adaugă
                    </a>
                    <a href="import_materiale.jsp" class="btn btn-dark">
                        <i class="fa-solid fa-file-import me-1"></i> Import
                    </a>
                    <button type="button" class="btn btn-secondary dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-file-export me-1"></i> Export
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="admin-export-materiale?type=pdf" target="_blank"><i class="fa-solid fa-file-pdf text-danger me-2"></i>PDF</a></li>
                        <li><a class="dropdown-item" href="admin-export-materiale?type=excel"><i class="fa-solid fa-file-excel text-success me-2"></i>Excel</a></li>
                    </ul>
                </div>
            </div>

            <div class="card card-dashboard mb-4 border-0">
                <div class="card-body">
                    <form action="admin-materiale" method="get" class="row g-2 align-items-center">
                        <div class="col-md-5">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                                <input type="text" name="search" class="form-control border-start-0" placeholder="Caută denumire piesă...">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-dark">Caută</button>
                            <a href="admin-materiale" class="btn btn-outline-secondary">Reset</a>
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
                            <th><%= getSortLink.apply("denumire", "Denumire Piesă") %></th>
                            <th><%= getSortLink.apply("cantitate", "Stoc") %></th>
                            <th><%= getSortLink.apply("pret", "Preț Unitar") %></th>
                            <th><%= getSortLink.apply("serviciu", "Asociat cu Serviciul") %></th>
                            <th class="text-end pe-4">Acțiuni</th>
                        </tr>
                        </thead>
                        <tbody>
                        <% List<MaterialePiese> list = (List<MaterialePiese>) request.getAttribute("listaMateriale");
                            if(list != null && !list.isEmpty()) { for(MaterialePiese m : list) { %>
                        <tr>
                            <td class="ps-4 fw-bold text-muted">#<%= m.getIdMat() %></td>
                            <td>
                                <span class="fw-bold text-dark"><i class="fa-solid fa-box-open me-2 text-secondary"></i><%= m.getDenumire() %></span>
                            </td>
                            <td>
                                <span class="badge <%= m.getCantitate() < 5 ? "bg-danger" : "bg-success" %> rounded-pill">
                                    <%= m.getCantitate() %> buc
                                </span>
                            </td>
                            <td class="fw-bold text-success"><%= m.getPretUnitar() %> RON</td>
                            <td><%= m.getNumeServiciu() != null ? m.getNumeServiciu() : "-" %></td>
                            <td class="text-end pe-4">
                                <a href="admin-materiale-actions?action=edit&id=<%= m.getIdMat() %>" class="btn btn-sm btn-outline-primary me-1">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="admin-materiale-actions?action=delete&id=<%= m.getIdMat() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Ștergi această piesă?')">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% }} else { %> <tr><td colspan="6" class="text-center p-4">Nu există date.</td></tr> <% } %>
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