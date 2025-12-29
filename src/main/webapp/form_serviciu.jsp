<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    Serviciu s = (Serviciu) request.getAttribute("serviciuDeEditat");
    boolean isEdit = (s != null);
    List<Atelier> ateliere = (List<Atelier>) request.getAttribute("listaAteliere");
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Serviciu</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container p-4">

            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card card-dashboard border-0 shadow-lg mt-4">
                        <div class="card-header bg-warning text-dark py-3">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid fa-tools me-2"></i>
                                <%= isEdit ? "Modifică Serviciu" : "Adaugă Serviciu Nou" %>
                            </h4>
                        </div>
                        <div class="card-body p-4">

                            <form action="admin-serviciu-actions" method="post">
                                <% if(isEdit) { %> <input type="hidden" name="id" value="<%= s.getIds() %>"> <% } %>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Denumire Serviciu</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-tag"></i></span>
                                        <input type="text" name="nume" class="form-control" value="<%= isEdit ? s.getNume() : "" %>" required placeholder="ex: Schimb Ulei">
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Descriere</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-align-left"></i></span>
                                        <input type="text" name="descriere" class="form-control" value="<%= isEdit ? s.getDescriere() : "" %>" placeholder="Detalii scurte...">
                                    </div>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Durată (min)</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fa-regular fa-clock"></i></span>
                                            <input type="number" name="durata" class="form-control" value="<%= isEdit ? s.getDurataEstimata() : "60" %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Atelier</label>
                                        <select name="ida" class="form-select" required>
                                            <option value="" disabled <%= !isEdit ? "selected" : "" %>>Alege Atelier...</option>
                                            <% if(ateliere != null) { for(Atelier a : ateliere) { %>
                                            <option value="<%= a.getIda() %>" <%= (isEdit && s.getIda() == a.getIda()) ? "selected" : "" %>>
                                                <%= a.getNume() %>
                                            </option>
                                            <% }} %>
                                        </select>
                                    </div>
                                </div>

                                <div class="d-grid gap-2 pt-2">
                                    <button type="submit" class="btn btn-warning fw-bold shadow-sm">
                                        <%= isEdit ? "💾 Salvează" : "➕ Adaugă Serviciu" %>
                                    </button>
                                    <a href="admin-servicii" class="btn btn-outline-danger border-0">Anulează</a>
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