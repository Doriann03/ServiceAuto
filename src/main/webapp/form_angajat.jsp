<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Angajat" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // Securitate
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    Angajat ang = (Angajat) request.getAttribute("angajatDeEditat");
    boolean isEdit = (ang != null);
    List<Atelier> ateliere = (List<Atelier>) request.getAttribute("listaAteliere");
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Angajat</title>
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
                        <li class="breadcrumb-item"><a href="admin-angajati">Angajați</a></li>
                        <li class="breadcrumb-item active" aria-current="page"><%= isEdit ? "Editare" : "Adăugare" %></li>
                    </ol>
                </nav>
                <a href="admin-angajati" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Înapoi la Listă
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card card-dashboard border-0 shadow-lg">
                        <div class="card-header bg-primary text-white py-3">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid <%= isEdit ? "fa-user-pen" : "fa-user-plus" %> me-2"></i>
                                <%= isEdit ? "Modifică Date Angajat" : "Înregistrare Angajat Nou" %>
                            </h4>
                        </div>
                        <div class="card-body p-4">

                            <form action="admin-angajat-actions" method="post">
                                <% if(isEdit) { %>
                                <input type="hidden" name="id" value="<%= ang.getIdAngajat() %>">
                                <% } %>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Nume</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                            <input type="text" name="nume" class="form-control" placeholder="ex: Popescu" value="<%= isEdit ? ang.getNume() : "" %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Prenume</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fa-solid fa-user"></i></span>
                                            <input type="text" name="prenume" class="form-control" placeholder="ex: Ion" value="<%= isEdit ? ang.getPrenume() : "" %>" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Funcție</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-briefcase"></i></span>
                                        <input type="text" name="functie" class="form-control" placeholder="ex: Mecanic Auto" value="<%= isEdit ? ang.getFunctie() : "" %>" required>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold">Atelier Asociat</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-warehouse"></i></span>
                                        <select name="ida" class="form-select" required>
                                            <option value="" disabled <%= !isEdit ? "selected" : "" %>>Selectează un atelier...</option>
                                            <%
                                                if(ateliere != null) {
                                                    for(Atelier at : ateliere) {
                                                        boolean selected = isEdit && (ang.getIda() == at.getIda());
                                            %>
                                            <option value="<%= at.getIda() %>" <%= selected ? "selected" : "" %>>
                                                <%= at.getNume() %> (ID: <%= at.getIda() %>)
                                            </option>
                                            <% }} %>
                                        </select>
                                    </div>
                                    <div class="form-text">Angajatul va fi repartizat la locația selectată.</div>
                                </div>

                                <div class="d-flex justify-content-between pt-3 border-top">
                                    <a href="admin-angajati" class="btn btn-outline-danger px-4">Anulează</a>
                                    <button type="submit" class="btn btn-success px-4 fw-bold">
                                        <i class="fa-solid fa-save me-2"></i> <%= isEdit ? "Salvează Modificările" : "Înregistrează Angajat" %>
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