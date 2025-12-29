<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Angajat" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Gestiune Angajați</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-primary ps-3">
                    Bază de date: Angajați
                </h2>
                <a href="admin-angajat-actions?action=new" class="btn btn-primary shadow-sm">
                    <i class="fa-solid fa-plus me-2"></i> Adaugă Angajat
                </a>
            </div>

            <div class="card card-dashboard mb-4 border-0">
                <div class="card-body">
                    <form action="admin-angajati" method="get" class="row g-2 align-items-center">
                        <div class="col-auto">
                            <label class="fw-bold text-secondary">Filtrează:</label>
                        </div>
                        <div class="col-md-4">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fa-solid fa-magnifying-glass text-muted"></i></span>
                                <input type="text" name="search" class="form-control border-start-0" placeholder="Caută nume sau funcție...">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-dark">Caută</button>
                            <a href="admin-angajati" class="btn btn-outline-secondary">Reset</a>
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
                            <th>Nume Complet</th>
                            <th>Funcție</th>
                            <th>Atelier</th>
                            <th class="text-end pe-4">Acțiuni</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Angajat> list = (List<Angajat>) request.getAttribute("listaAngajati");
                            if(list != null && !list.isEmpty()) {
                                for(Angajat a : list) {
                        %>
                        <tr>
                            <td class="ps-4 text-secondary fw-bold">#<%= a.getIdAngajat() %></td>
                            <td>
                                <div class="d-flex align-items-center">
                                    <div class="bg-light rounded-circle d-flex justify-content-center align-items-center me-3 text-primary" style="width: 35px; height: 35px;">
                                        <i class="fa-solid fa-user-tie"></i>
                                    </div>
                                    <span class="fw-bold"><%= a.getNume() %> <%= a.getPrenume() %></span>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-info text-dark"><%= a.getFunctie() %></span>
                            </td>
                            <td>
                                <% if (a.getNumeAtelier() != null) { %>
                                <span class="badge bg-secondary"><i class="fa-solid fa-warehouse me-1"></i> <%= a.getNumeAtelier() %></span>
                                <% } else { %>
                                <span class="text-muted">-</span>
                                <% } %>
                            </td>
                            <td class="text-end pe-4">
                                <a href="admin-angajat-actions?action=edit&id=<%= a.getIdAngajat() %>" class="btn btn-sm btn-outline-primary me-1" title="Editează">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="admin-angajat-actions?action=delete&id=<%= a.getIdAngajat() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Sigur doriți să ștergeți acest angajat?')" title="Șterge">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% }} else { %>
                        <tr><td colspan="5" class="text-center p-4 text-muted">Nu există angajați înregistrați.</td></tr>
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