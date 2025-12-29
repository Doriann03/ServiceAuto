<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Atelier" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    Atelier at = (Atelier) request.getAttribute("atelierDeEditat");
    boolean isEdit = (at != null);
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Atelier</title>
    <jsp:include page="includes/head.jsp" />
</head>
<body>
<div class="d-flex">

    <jsp:include page="includes/sidebar_admin.jsp" />

    <div class="main-content flex-grow-1 bg-light">
        <div class="container p-4">

            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="card card-dashboard border-0 shadow-lg mt-5">
                        <div class="card-header bg-info text-white py-3">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid fa-warehouse me-2"></i>
                                <%= isEdit ? "Modifică Atelier" : "Adaugă Atelier Nou" %>
                            </h4>
                        </div>
                        <div class="card-body p-4">

                            <form action="admin-atelier-actions" method="post">
                                <% if(isEdit) { %> <input type="hidden" name="id" value="<%= at.getIda() %>"> <% } %>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Denumire Atelier</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-tag"></i></span>
                                        <input type="text" name="nume" class="form-control" value="<%= isEdit ? at.getNume() : "" %>" required placeholder="ex: Mecanică Ușoară">
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold">Adresă / Locație</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-map-location-dot"></i></span>
                                        <input type="text" name="adresa" class="form-control" value="<%= isEdit ? at.getAdresa() : "" %>" required placeholder="ex: Hala B, Stand 3">
                                    </div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn btn-info text-white fw-bold shadow-sm">
                                        <%= isEdit ? "💾 Salvează" : "➕ Înregistrează Atelier" %>
                                    </button>
                                    <a href="admin-ateliere" class="btn btn-outline-danger border-0">Renunță</a>
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