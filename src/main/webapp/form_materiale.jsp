<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.MaterialePiese" %>
<%@ page import="ro.serviceauto.serviceauto.model.Serviciu" %>
<%@ page import="java.util.List" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    MaterialePiese m = (MaterialePiese) request.getAttribute("materialDeEditat");
    boolean isEdit = (m != null);
    List<Serviciu> servicii = (List<Serviciu>) request.getAttribute("listaServicii");
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Material</title>
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
                        <div class="card-header text-white py-3" style="background-color: #6f42c1;">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid fa-boxes-stacked me-2"></i>
                                <%= isEdit ? "Modifică Piesa" : "Adaugă Piesa Nouă" %>
                            </h4>
                        </div>
                        <div class="card-body p-4">

                            <form action="admin-materiale-actions" method="post">
                                <% if(isEdit) { %> <input type="hidden" name="id" value="<%= m.getIdMat() %>"> <% } %>

                                <div class="mb-3">
                                    <label class="form-label fw-bold">Denumire Piesă</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fa-solid fa-tag"></i></span>
                                        <input type="text" name="denumire" class="form-control" value="<%= isEdit ? m.getDenumire() : "" %>" required>
                                    </div>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Stoc (Cantitate)</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fa-solid fa-layer-group"></i></span>
                                            <input type="number" name="cantitate" class="form-control" value="<%= isEdit ? m.getCantitate() : "0" %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Preț Unitar (RON)</label>
                                        <div class="input-group">
                                            <span class="input-group-text"><i class="fa-solid fa-money-bill"></i></span>
                                            <input type="number" step="0.01" name="pretUnitar" class="form-control" value="<%= isEdit ? m.getPretUnitar() : "0.00" %>" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label fw-bold">Asociat cu Serviciul</label>
                                    <select name="ids" class="form-select" required>
                                        <option value="" disabled <%= !isEdit ? "selected" : "" %>>Alege Serviciu...</option>
                                        <% if(servicii != null) { for(Serviciu s : servicii) { %>
                                        <option value="<%= s.getIds() %>" <%= (isEdit && m.getIds() == s.getIds()) ? "selected" : "" %>>
                                            <%= s.getNume() %>
                                        </option>
                                        <% }} %>
                                    </select>
                                    <div class="form-text">Piesa va fi legată de acest serviciu.</div>
                                </div>

                                <div class="d-grid gap-2">
                                    <button type="submit" class="btn text-white fw-bold shadow-sm" style="background-color: #6f42c1;">
                                        <%= isEdit ? "💾 Salvează" : "➕ Adaugă" %>
                                    </button>
                                    <a href="admin-materiale" class="btn btn-outline-danger border-0">Renunță</a>
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