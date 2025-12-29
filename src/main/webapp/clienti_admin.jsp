<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
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
    <title>Gestiune Clienți</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container-fluid p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="text-dark fw-bold border-start border-4 border-warning ps-3">
                    Bază de date: Clienți
                </h2>

                <div class="btn-group shadow-sm">
                    <a href="admin-client-actions?action=new" class="btn btn-success fw-bold">
                        <i class="fa-solid fa-plus me-1"></i> Adaugă
                    </a>
                    <a href="import_clienti.jsp" class="btn btn-dark">
                        <i class="fa-solid fa-file-import me-1"></i> Import
                    </a>
                    <button type="button" class="btn btn-info dropdown-toggle text-white" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="fa-solid fa-file-export me-1"></i> Export
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" href="admin-export-clienti?type=pdf" target="_blank"><i class="fa-solid fa-file-pdf text-danger me-2"></i>Export PDF</a></li>
                        <li><a class="dropdown-item" href="admin-export-clienti?type=excel"><i class="fa-solid fa-file-excel text-success me-2"></i>Export Excel</a></li>
                    </ul>
                </div>
            </div>

            <%
                String msg = request.getParameter("msg");
                if (msg != null) {
            %>
            <div class="alert alert-success alert-dismissible fade show shadow-sm" role="alert">
                <i class="fa-solid fa-check-circle me-2"></i> <%= java.net.URLDecoder.decode(msg, "UTF-8") %>
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% } %>

            <div class="card card-dashboard mb-4 border-0">
                <div class="card-body">
                    <form action="admin-clienti" method="get" class="row g-2">
                        <div class="col-md-5">
                            <div class="input-group">
                                <span class="input-group-text bg-white"><i class="fa-solid fa-search text-muted"></i></span>
                                <input type="text" name="search" class="form-control border-start-0" placeholder="Caută nume, telefon sau email...">
                            </div>
                        </div>
                        <div class="col-auto">
                            <button type="submit" class="btn btn-dark">Caută</button>
                            <a href="admin-clienti" class="btn btn-outline-secondary">Reset</a>
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
                            <th>Nume & Prenume</th>
                            <th>Contact</th>
                            <th>Utilizator</th>
                            <th>Rol</th>
                            <th class="text-end pe-4">Acțiuni</th>
                        </tr>
                        </thead>
                        <tbody>
                        <%
                            List<Client> list = (List<Client>) request.getAttribute("listaClienti");
                            if(list != null && !list.isEmpty()) {
                                for(Client c : list) {
                        %>
                        <tr>
                            <td class="ps-4 text-muted">#<%= c.getIdc() %></td>
                            <td>
                                <strong><%= c.getNume() %> <%= c.getPrenume() %></strong>
                            </td>
                            <td>
                                <div class="d-flex flex-column small">
                                    <span><i class="fa-solid fa-phone text-success me-2"></i><%= c.getTelefon() %></span>
                                    <span><i class="fa-solid fa-envelope text-primary me-2"></i><%= c.getEmail() %></span>
                                </div>
                            </td>
                            <td>
                                <span class="badge bg-light text-dark border"><i class="fa-solid fa-user me-1"></i> <%= c.getUsername() %></span>
                            </td>
                            <td>
                                <% if("Admin".equals(c.getTipUtilizator())) { %>
                                <span class="badge bg-danger">ADMIN</span>
                                <% } else { %>
                                <span class="badge bg-success">CLIENT</span>
                                <% } %>
                            </td>
                            <td class="text-end pe-4">
                                <a href="admin-client-actions?action=edit&id=<%= c.getIdc() %>" class="btn btn-sm btn-outline-warning text-dark me-1" title="Editează">
                                    <i class="fa-solid fa-pen"></i>
                                </a>
                                <a href="admin-client-actions?action=delete&id=<%= c.getIdc() %>" class="btn btn-sm btn-outline-danger" onclick="return confirm('Sigur ștergi acest client?');" title="Șterge">
                                    <i class="fa-solid fa-trash"></i>
                                </a>
                            </td>
                        </tr>
                        <% }} else { %>
                        <tr><td colspan="6" class="text-center p-4 text-muted">Niciun client găsit.</td></tr>
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