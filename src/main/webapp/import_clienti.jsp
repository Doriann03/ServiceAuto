<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%@ page import="java.util.List" %>
<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }
    List<Client> listaPreview = (List<Client>) session.getAttribute("listaImportPreview");
    boolean showPreview = (listaPreview != null && !listaPreview.isEmpty());
%>
<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Import Clienți</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">
    <jsp:include page="includes/sidebar_admin.jsp" />
    <div class="main-content flex-grow-1 bg-light">
        <div class="container p-4">

            <div class="d-flex justify-content-between align-items-center mb-4">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb mb-0">
                        <li class="breadcrumb-item"><a href="dashboard_admin.jsp">Home</a></li>
                        <li class="breadcrumb-item"><a href="admin-clienti">Clienți</a></li>
                        <li class="breadcrumb-item active">Import</li>
                    </ol>
                </nav>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-10">
                    <div class="card card-dashboard border-0 shadow-lg">
                        <div class="card-header bg-warning text-dark py-3">
                            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-users-viewfinder me-2"></i> Import Bază de Date Clienți</h4>
                        </div>
                        <div class="card-body p-4">

                            <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger"><i class="fa-solid fa-bug me-2"></i> <%= request.getParameter("error") %></div>
                            <% } %>

                            <% if (!showPreview) { %>
                            <div class="alert alert-secondary mb-4">
                                <strong>Structură Fișier:</strong> Nume | Prenume | Telefon | Email | Username | Parolă | Rol<br>
                                <small class="text-muted">Nu includeți coloana ID. Parolele vor fi hash-uite automat la import.</small>
                            </div>
                            <form action="admin-import-clienti" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="step" value="preview">
                                <div class="input-group mb-4">
                                    <input type="file" name="fisierExcel" class="form-control" accept=".xlsx" required>
                                    <button class="btn btn-warning" type="submit"><strong>Încarcă</strong></button>
                                </div>
                                <a href="clienti_admin.jsp" class="btn btn-link text-secondary">Înapoi la listă</a>
                            </form>
                            <% } else { %>
                            <div class="table-responsive border rounded mb-4" style="max-height: 400px;">
                                <table class="table table-sm table-hover mb-0">
                                    <thead class="table-dark sticky-top">
                                    <tr><th>#</th><th>Nume</th><th>Prenume</th><th>Telefon</th><th>Email</th><th>User</th><th>Rol</th></tr>
                                    </thead>
                                    <tbody>
                                    <% int idx = 1; for (Client c : listaPreview) { %>
                                    <tr>
                                        <td><%= idx++ %></td><td><%= c.getNume() %></td><td><%= c.getPrenume() %></td>
                                        <td><%= c.getTelefon() %></td><td><%= c.getEmail() %></td><td><%= c.getUsername() %></td><td><%= c.getTipUtilizator() %></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>
                            <div class="d-flex justify-content-center gap-2">
                                <form action="admin-import-clienti" method="post"><input type="hidden" name="step" value="save"><button type="submit" class="btn btn-success fw-bold">Importă</button></form>
                                <form action="admin-import-clienti" method="post"><input type="hidden" name="step" value="cancel"><button type="submit" class="btn btn-danger fw-bold">Anulează</button></form>
                            </div>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>