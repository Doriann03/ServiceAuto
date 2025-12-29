<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Vehicul" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>

<%
    // Securitate
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    Vehicul v = (Vehicul) request.getAttribute("vehiculDeEditat");
    boolean isEdit = (v != null);
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title><%= isEdit ? "Editare" : "Adăugare" %> Vehicul</title>
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
                        <li class="breadcrumb-item"><a href="admin-vehicule">Vehicule</a></li>
                        <li class="breadcrumb-item active"><%= isEdit ? "Editare" : "Nou" %></li>
                    </ol>
                </nav>
                <a href="admin-vehicule" class="btn btn-outline-secondary btn-sm">
                    <i class="fa-solid fa-arrow-left me-1"></i> Înapoi
                </a>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card card-dashboard border-0 shadow-lg">
                        <div class="card-header bg-primary text-white py-3">
                            <h4 class="mb-0 fw-bold">
                                <i class="fa-solid <%= isEdit ? "fa-pen-to-square" : "fa-car-on" %> me-2"></i>
                                <%= isEdit ? "Modifică Date Vehicul" : "Înregistrează Vehicul Nou" %>
                            </h4>
                        </div>
                        <div class="card-body p-4">

                            <form action="admin-vehicul-actions" method="post">
                                <% if(isEdit) { %>
                                <input type="hidden" name="id" value="<%= v.getIdv() %>">
                                <% } %>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Marcă</label>
                                        <input type="text" name="marca" class="form-control" placeholder="ex: Dacia" value="<%= isEdit ? v.getMarca() : "" %>" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label fw-bold">Model</label>
                                        <input type="text" name="model" class="form-control" placeholder="ex: Logan" value="<%= isEdit ? v.getModel() : "" %>" required>
                                    </div>
                                </div>

                                <div class="row g-3 mb-3">
                                    <div class="col-md-4">
                                        <label class="form-label fw-bold">Nr. Înmatriculare</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-hashtag text-primary"></i></span>
                                            <input type="text" name="nrInmatriculare" class="form-control border-start-0 text-uppercase" placeholder="B 123 ABC" value="<%= isEdit ? v.getNrInmatriculare() : "" %>" required>
                                        </div>
                                    </div>
                                    <div class="col-md-8">
                                        <label class="form-label fw-bold">Serie Șasiu (VIN)</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-white border-end-0"><i class="fa-solid fa-fingerprint text-secondary"></i></span>
                                            <input type="text" name="serieSasiu" class="form-control border-start-0 text-uppercase" placeholder="XXXXXXXXXXXXXXXXX" value="<%= isEdit ? v.getSerieSasiu() : "" %>" required maxlength="17">
                                        </div>
                                    </div>
                                </div>

                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label class="form-label">Tip Caroserie</label>
                                        <input type="text" name="tip" class="form-control" placeholder="ex: Sedan, Break" value="<%= isEdit ? v.getTip() : "" %>">
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label">Motorizare</label>
                                        <input type="text" name="motor" class="form-control" placeholder="ex: 1.5 dCi" value="<%= isEdit ? v.getMotor() : "" %>">
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between pt-3 border-top">
                                    <a href="admin-vehicule" class="btn btn-outline-danger px-4">Renunță</a>
                                    <button type="submit" class="btn btn-success px-4 fw-bold">
                                        <i class="fa-solid fa-save me-2"></i> <%= isEdit ? "Salvează" : "Adaugă Vehicul" %>
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