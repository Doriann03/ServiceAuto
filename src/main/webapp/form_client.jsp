<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%
    Client userAdmin = (Client) session.getAttribute("user");
    if (userAdmin == null || !"Admin".equals(userAdmin.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    Client clientEdit = (Client) request.getAttribute("clientDeEditat");
    boolean isEdit = (clientEdit != null);
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title><%= isEdit ? "Editare Client" : "Adăugare Client" %></title>
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
                        <li class="breadcrumb-item active"><%= isEdit ? "Editare" : "Nou" %></li>
                    </ol>
                </nav>
                <a href="admin-clienti" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Înapoi la Tabel
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-9">
                    <div class="card card-dashboard border-0 shadow-lg">
                        <div class="card-header bg-warning text-dark py-3">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid <%= isEdit ? "fa-user-pen" : "fa-user-plus" %> me-2"></i>
                                <%= isEdit ? "Editare Client: " + clientEdit.getNume() : "Adăugare Client Nou" %>
                            </h4>
                        </div>
                        <div class="card-body p-4">

                            <form action="admin-client-actions" method="post">
                                <% if(isEdit) { %>
                                <input type="hidden" name="id" value="<%= clientEdit.getIdc() %>">
                                <% } %>

                                <h6 class="text-uppercase text-muted fw-bold mb-3 small"><i class="fa-solid fa-address-card me-1"></i> Date Personale</h6>
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label class="form-label">Nume</label>
                                        <input type="text" name="nume" class="form-control" value="<%= isEdit ? clientEdit.getNume() : "" %>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Prenume</label>
                                        <input type="text" name="prenume" class="form-control" value="<%= isEdit ? clientEdit.getPrenume() : "" %>" required>
                                    </div>
                                </div>

                                <h6 class="text-uppercase text-muted fw-bold mb-3 small border-top pt-3"><i class="fa-solid fa-address-book me-1"></i> Contact</h6>
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label class="form-label">Telefon</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fa-solid fa-phone text-success"></i></span>
                                            <input type="text" name="telefon" class="form-control" value="<%= isEdit ? clientEdit.getTelefon() : "" %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Email</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fa-solid fa-envelope text-primary"></i></span>
                                            <input type="email" name="email" class="form-control" value="<%= isEdit ? clientEdit.getEmail() : "" %>" required>
                                        </div>
                                    </div>
                                </div>

                                <h6 class="text-uppercase text-muted fw-bold mb-3 small border-top pt-3"><i class="fa-solid fa-shield-halved me-1"></i> Date Cont & Securitate</h6>
                                <div class="row g-3 mb-4">
                                    <div class="col-md-4">
                                        <label class="form-label">Username</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-light">@</span>
                                            <input type="text" name="username" class="form-control" value="<%= isEdit ? clientEdit.getUsername() : "" %>" required>
                                        </div>
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label"><%= isEdit ? "Resetare Parolă (Opțional)" : "Parolă" %></label>
                                        <input type="password" name="password" class="form-control" <%= !isEdit ? "required" : "" %> placeholder="<%= isEdit ? "Lasă gol pt a nu schimba" : "" %>">
                                    </div>

                                    <div class="col-md-4">
                                        <label class="form-label">Rol Utilizator</label>
                                        <select name="tipUtilizator" class="form-select">
                                            <option value="Client" <%= (isEdit && "Client".equals(clientEdit.getTipUtilizator())) ? "selected" : "" %>>Client</option>
                                            <option value="Admin" <%= (isEdit && "Admin".equals(clientEdit.getTipUtilizator())) ? "selected" : "" %>>Admin</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between pt-3 border-top mt-4">
                                    <a href="admin-clienti" class="btn btn-outline-dark px-4">Anulează</a>
                                    <button type="submit" class="btn btn-success px-5 fw-bold shadow-sm">
                                        <%= isEdit ? "💾 Salvează Modificările" : "➕ Adaugă Client" %>
                                    </button>
                                </div>
                            </form>
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