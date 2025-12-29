<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="ro.serviceauto.serviceauto.model.Client" %>
<%@ page import="ro.serviceauto.serviceauto.model.MaterialePiese" %>
<%@ page import="java.util.List" %>

<%
    Client user = (Client) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getTipUtilizator())) {
        response.sendRedirect("login.jsp"); return;
    }

    List<MaterialePiese> listaPreview = (List<MaterialePiese>) session.getAttribute("previewMateriale");
    boolean showPreview = (listaPreview != null && !listaPreview.isEmpty());
%>

<!DOCTYPE html>
<html lang="ro">
<head>
    <title>Import Materiale</title>
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
                        <li class="breadcrumb-item"><a href="admin-materiale">Stoc</a></li>
                        <li class="breadcrumb-item active">Import Excel</li>
                    </ol>
                </nav>
            </div>

            <div class="row justify-content-center">
                <div class="col-lg-8">
                    <div class="card card-dashboard border-0 shadow-lg">
                        <div class="card-header text-white py-3" style="background-color: #6f42c1;">
                            <h4 class="mb-0 fw-bold"><i class="fa-solid fa-boxes-packing me-2"></i> Import Stoc Piese</h4>
                        </div>
                        <div class="card-body p-4">

                            <% if (request.getParameter("error") != null) { %>
                            <div class="alert alert-danger d-flex align-items-center mb-4">
                                <i class="fa-solid fa-triangle-exclamation fa-2x me-3"></i>
                                <div><strong>Eroare:</strong> <%= request.getParameter("error") %></div>
                            </div>
                            <% } %>

                            <% if (!showPreview) { %>
                            <div class="alert alert-light border border-info shadow-sm mb-4">
                                <h6 class="text-info fw-bold"><i class="fa-solid fa-list-ol me-2"></i> Structura Coloanelor:</h6>
                                <div class="row g-2 font-monospace small mt-2">
                                    <div class="col-md-6">1. Denumire Piesă (Text)</div>
                                    <div class="col-md-6">2. Cantitate (Număr)</div>
                                    <div class="col-md-6">3. Preț Unitar (Număr cu virgulă)</div>
                                    <div class="col-md-6">4. ID Serviciu (Număr)</div>
                                </div>
                            </div>

                            <form action="admin-import-materiale" method="post" enctype="multipart/form-data">
                                <input type="hidden" name="step" value="preview">
                                <label class="form-label fw-bold">Încarcă fișier .xlsx</label>
                                <div class="input-group mb-4">
                                    <input type="file" name="fisierExcel" class="form-control" accept=".xlsx" required>
                                    <button class="btn text-white" style="background-color: #6f42c1;" type="submit">
                                        <i class="fa-solid fa-magnifying-glass me-2"></i> Previzualizare
                                    </button>
                                </div>
                                <div class="text-end"><a href="admin-materiale" class="btn btn-outline-secondary">Anulează</a></div>
                            </form>

                            <% } else { %>
                            <div class="alert alert-warning border-0 shadow-sm d-flex align-items-center">
                                <i class="fa-solid fa-circle-exclamation fa-2x me-3"></i>
                                <div>Verifică datele extrase din Excel înainte de salvare.</div>
                            </div>

                            <div class="table-responsive border rounded mb-4" style="max-height: 400px;">
                                <table class="table table-hover mb-0 align-middle">
                                    <thead class="table-dark sticky-top">
                                    <tr>
                                        <th>#</th>
                                        <th>Piesă</th>
                                        <th>Cantitate</th>
                                        <th>Preț</th>
                                        <th>ID Serv</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    <% int idx = 1; for (MaterialePiese m : listaPreview) { %>
                                    <tr>
                                        <td><%= idx++ %></td>
                                        <td class="fw-bold"><%= m.getDenumire() %></td>
                                        <td>
                                                    <span class="badge <%= m.getCantitate() < 5 ? "bg-danger" : "bg-success" %> rounded-pill">
                                                        <%= m.getCantitate() %>
                                                    </span>
                                        </td>
                                        <td><%= m.getPretUnitar() %></td>
                                        <td><%= m.getIds() %></td>
                                    </tr>
                                    <% } %>
                                    </tbody>
                                </table>
                            </div>

                            <div class="d-flex gap-2 justify-content-center">
                                <form action="admin-import-materiale" method="post">
                                    <input type="hidden" name="step" value="save">
                                    <button type="submit" class="btn btn-success fw-bold px-4 shadow-sm"><i class="fa-solid fa-check me-2"></i> Importă</button>
                                </form>
                                <form action="admin-import-materiale" method="post">
                                    <input type="hidden" name="step" value="cancel">
                                    <button type="submit" class="btn btn-outline-danger fw-bold px-4 shadow-sm">Renunță</button>
                                </form>
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